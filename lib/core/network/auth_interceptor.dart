import 'dart:convert';
import 'dart:io';

import 'package:get_pass/core/constants/api_constants.dart';
import 'package:get_pass/core/model/api_response_model.dart';
import 'package:get_pass/core/storage/token_storage.dart';
import 'package:http/http.dart' as http;

class AuthInterceptor extends http.BaseClient {
  final http.Client inner;
  final TokenStorage tokenStorage;

  AuthInterceptor({required this.inner, required this.tokenStorage});

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final accessToken = await tokenStorage.getAccessToken();
    if (accessToken != null) {
      request.headers[HttpHeaders.authorizationHeader] = 'Bearer $accessToken';
    }
    http.StreamedResponse response = await inner.send(request);

    if (response.statusCode != 401) {
      return response;
    }
    final refreshed = await _refreshToken();

    if (!refreshed) {
      await tokenStorage.clear();
      return response;
    }

    final retryRequest = _copyRequest(request);
    final newToken = await tokenStorage.getAccessToken();

    retryRequest.headers[HttpHeaders.authorizationHeader] =
    'Bearer $newToken';

    return inner.send(retryRequest);
  }

  Future<bool> _refreshToken() async {
    final refreshToken = await tokenStorage.getRefreshToken();
    if (refreshToken == null) return false;

    final url = Uri.parse(ApiConstants.baseUrl)
        .resolve(ApiConstants.refresh)
        .replace(queryParameters: {'refreshToken': refreshToken});

    final response = await inner.get(
      url,
      headers: {
        HttpHeaders.acceptHeader: 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      final apiResponse = ApiResponse.fromJson(decoded);

      await tokenStorage.saveTokens(
        accessToken: apiResponse.data['accessToken'],
        refreshToken: apiResponse.data['refreshToken'],
      );

      return true;
    }

    return false;
  }


  http.BaseRequest _copyRequest(http.BaseRequest request) {
    final newRequest = http.Request(
      request.method,
      request.url,
    );

    newRequest.headers.addAll(request.headers);

    if (request is http.Request) {
      newRequest.bodyBytes = request.bodyBytes;
    }

    return newRequest;
  }
}
