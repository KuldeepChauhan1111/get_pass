import 'package:dartz/dartz.dart';
import 'package:get_pass/core/error/failure.dart';
import 'package:get_pass/features/auth/domain/entity/auth_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure,AuthEntity>> login(String email, String password);
}