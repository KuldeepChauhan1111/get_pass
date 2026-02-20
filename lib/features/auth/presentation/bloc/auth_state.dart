import 'package:equatable/equatable.dart';
import 'package:get_pass/features/auth/domain/entity/user_entity.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitialState extends AuthState {
  const AuthInitialState();
}

class AuthLoadingState extends AuthState {
  const AuthLoadingState();
}

class AuthSuccessState extends AuthState {
  final UserEntity user;
  final String refreshToken;
  final String accessToken;

  const AuthSuccessState(this.user, this.refreshToken, this.accessToken);

  @override
  List<Object?> get props => [user, refreshToken, accessToken];
}

class AuthFailureState extends AuthState {
  final String message;

  const AuthFailureState({required this.message});

  @override
  List<Object?> get props => [message];
}
