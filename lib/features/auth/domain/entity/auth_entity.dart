import 'package:equatable/equatable.dart';
import 'user_entity.dart';

class AuthEntity extends Equatable {
  final String accessToken;
  final String refreshToken;
  final String role;
  final UserEntity user;

  const AuthEntity({
    required this.accessToken,
    required this.refreshToken,
    required this.role,
    required this.user,
  });

  @override
  List<Object?> get props =>
      [accessToken, refreshToken, role, user];
}
