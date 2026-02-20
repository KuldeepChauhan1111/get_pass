import 'package:dartz/dartz.dart';
import 'package:get_pass/core/constants/api_constants.dart';
import 'package:get_pass/core/error/execptions.dart';
import 'package:get_pass/core/model/api_response_model.dart';
import 'package:get_pass/core/network/network_repository.dart';
import 'package:get_pass/features/auth/data/model/auth_model.dart';

abstract class AuthRemoteDataSource {
  Future<Either<Failure, AuthModel>> login(
      String email,
      String password,
      );
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final NetworkRepository networkRepository;

  AuthRemoteDataSourceImpl(this.networkRepository);

  @override
  Future<Either<Failure, AuthModel>> login(
      String email,
      String password,
      ) async {
    final result = await networkRepository.postMethod(
      path: ApiConstants.login, // your login API
      params: {
        'email': email,
        'password': password,
      },
    );

    return result.fold(
          (failure) => Left(failure),
          (ApiResponse response) {
        if (response.success == true) {
          return Right(AuthModel.fromJson(response.data));
        } else {
          return Left(
            ServerFailure(response.message ?? 'Login failed'),
          );
        }
      },
    );
  }
}
