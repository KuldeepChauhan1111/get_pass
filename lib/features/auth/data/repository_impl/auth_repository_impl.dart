import 'package:dartz/dartz.dart';
import 'package:get_pass/core/error/failure.dart';
import 'package:get_pass/features/auth/data/datasource/auth_datasource.dart';
import 'package:get_pass/features/auth/data/model/auth_model.dart';
import 'package:get_pass/features/auth/domain/entity/auth_entity.dart';
import 'package:get_pass/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository{
  AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl(this.authRemoteDataSource);



  @override
  Future<Either<Failure, AuthEntity>> login(String email, String password)async {
    final result = await authRemoteDataSource.login(email, password);

    return result.fold(
          (failure) => Left(failure),
          (AuthModel model) => Right(model),
    );


  }

}