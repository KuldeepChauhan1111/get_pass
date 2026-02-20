import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String email;
  final String mobileNo;
  final String role;
  final bool firstLogin;

  const UserEntity({
    required this.id,
    required this.email,
    required this.mobileNo,
    required this.role,
    required this.firstLogin,
  });

  @override
  List<Object?> get props => [id, email, mobileNo, role, firstLogin];
}
