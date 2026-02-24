import 'package:dartz/dartz.dart';
import 'package:get_pass/core/constants/api_constants.dart';
import 'package:get_pass/core/error/failure.dart';
import 'package:get_pass/core/model/api_response_model.dart';
import 'package:get_pass/core/network/network_repository.dart';
import 'package:get_pass/core/storage/token_storage.dart';
import 'package:get_pass/features/auth/data/model/auth_model.dart';

abstract class AuthRemoteDataSource {
  Future<Either<Failure, AuthModel>> login(
      String email,
      String password,
      );
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final NetworkRepository networkRepository;
  final TokenStorage tokenStorage;

  AuthRemoteDataSourceImpl(this.networkRepository,this.tokenStorage);

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
          (ApiResponse response)async {
        if (response.success == true) {

          AuthModel authModel = AuthModel.fromJson(response.data);
          // 🔐 STORE TOKENS HERE
          await tokenStorage.saveTokens(
            accessToken: authModel.accessToken,
            refreshToken: authModel.refreshToken,
          );
          return Right(authModel);
        } else {
          return Left(
            ServerFailure(response.message ?? 'Login failed'),
          );
        }
      },
    );
  }
}
