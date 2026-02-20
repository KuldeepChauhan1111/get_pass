import 'package:dartz/dartz.dart';
import 'package:get_pass/core/error/execptions.dart';
import 'package:get_pass/features/auth/domain/entity/auth_entity.dart';
import 'package:get_pass/features/auth/domain/repository/auth_repository.dart';

class LoginUseCase {
  final AuthRepository authRepository;

  LoginUseCase(this.authRepository);

  Future<Either<Failure, AuthEntity>> call({
    required String email,
    required String password,
  }) async {
    return authRepository.login(email, password);
  }
}
