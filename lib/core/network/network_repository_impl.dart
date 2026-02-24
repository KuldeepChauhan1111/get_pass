import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:get_pass/core/constants/api_constants.dart';
import 'package:get_pass/core/error/failure.dart';
import 'package:get_pass/core/model/api_response_model.dart';
import 'package:get_pass/core/storage/token_storage.dart';
import 'package:get_pass/core/utils/network_info.dart';
import 'package:http/http.dart' as http;

import 'network_repository.dart';

class NetworkRepositoryImpl implements NetworkRepository {
  final http.Client client;
  final NetworkInfo networkInfo;
  final TokenStorage tokenStorage;

  NetworkRepositoryImpl({required this.client, required this.networkInfo,required this.tokenStorage});

  @override
  Future<Either<Failure, ApiResponse>> postMethod({
    required String path,
    required Map<String, dynamic> params,
  }) async {
    if (!await _isConnected()) {
      return const Left(NetworkFailure('No internet connection'));
    }

    try {
      final baseUri = Uri.parse(ApiConstants.baseUrl);
      final normalizedPath =
          path.startsWith('/') ? path.substring(1) : path;
      final uri = baseUri.resolve(normalizedPath);

      final response = await client.post(
        uri,
        headers: await _defaultHeaders(),
        body: jsonEncode(params),
      );

      return _handleResponse(response);
    } on SocketException {
      return const Left(NetworkFailure('No internet connection'));
    } on FormatException {
      return const Left(ServerFailure('Invalid response format'));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiResponse>> getMethod({
    required String url,
    Map<String, dynamic>? queryParams,
  }) async {
    if (!await _isConnected()) {
      return const Left(NetworkFailure('No internet connection'));
    }

    try {
      final uri = Uri.parse(url).replace(
        queryParameters: queryParams,
      );

      final response = await client.get(
        uri,
        headers: await _defaultHeaders(),
      );

      return _handleResponse(response);
    } on SocketException {
      return const Left(NetworkFailure('No internet connection'));
    } on FormatException {
      return const Left(ServerFailure('Invalid response format'));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  Future<bool> _isConnected() async {
    return networkInfo.isConnected;
  }

  Map<String, String> _defaultHeaders() {
    return {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
  }

  Either<Failure, ApiResponse> _handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return Right(_decodeResponse(response.body));
      case 400:
        return const Left(ServerFailure('Bad request'));
      case 401:
      case 403:
        return const Left(ServerFailure('Unauthorized access'));
      case 404:
        return const Left(ServerFailure('API not found'));
      case 500:
        return const Left(ServerFailure('Internal server error'));
      default:
        return Left(
          ServerFailure('Unexpected error: ${response.statusCode}'),
        );
    }
  }

  ApiResponse _decodeResponse(String body) {
    final decoded = jsonDecode(body);
    return ApiResponse.fromJson(decoded);
  }
}
