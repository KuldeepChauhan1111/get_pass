import 'package:get_pass/features/auth/domain/entity/auth_entity.dart';
import 'package:get_pass/features/auth/domain/entity/user_entity.dart';

class AuthState {
  AuthState init() {
    return AuthState();
  }
}

class AuthInitialState extends AuthState {
  AuthInitialState();
}

class AuthLoadingState extends AuthState {
  AuthLoadingState();
}

class AuthSuccessState extends AuthState {
  UserEntity userEntity;
  String token;
  String refreshToken;
  AuthSuccessState(this.userEntity,this.refreshToken,this.token);
}

class AuthFailureState extends AuthState {
  String? message;
  AuthFailureState({this.message});
}