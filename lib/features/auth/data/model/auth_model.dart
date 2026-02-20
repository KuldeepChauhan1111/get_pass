import 'package:get_pass/features/auth/domain/entity/auth_entity.dart';

import 'user_model.dart';

class AuthModel extends AuthEntity {
  const AuthModel({
    required super.accessToken,
    required super.refreshToken,
    required super.role,
    required super.user,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      role: json['role'],
      user: UserModel.fromJson(json['user']),
    );
  }
}
