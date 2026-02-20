import 'package:get_pass/features/auth/domain/entity/user_entity.dart';


class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.email,
    required super.mobileNo,
    required super.role,
    required super.firstLogin,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      mobileNo: json['mobileNo'],
      role: json['role'],
      firstLogin: json['firstLogin'],
    );
  }
}
