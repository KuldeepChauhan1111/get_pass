import 'package:dartz/dartz.dart';
import 'package:get_pass/core/error/execptions.dart';
import 'package:get_pass/core/model/api_response_model.dart';

abstract class NetworkRepository {
  Future<Either<Failure, ApiResponse>> postMethod({
    required String path,
    required Map<String, dynamic> params,
  });

  Future<Either<Failure, ApiResponse>> getMethod({
    required String url,
    Map<String, dynamic>? queryParams,
  });
}
