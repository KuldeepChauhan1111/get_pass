import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_pass/features/auth/domain/usecase/login_use_case.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;

  AuthBloc({required this.loginUseCase})
      : super(AuthInitialState()) {
    on<LoginRequestEvent>(_onLoginRequested);
  }

  Future<void> _onLoginRequested(
      LoginRequestEvent event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoadingState());

    final result = await loginUseCase(
      email: event.email,
      password: event.password,
    );

    result.fold(
          (failure) {
        emit(AuthFailureState(message: failure.message));
      },
          (success) {
        emit(
          AuthSuccessState(
            success.user,
            success.refreshToken,
            success.accessToken,
          ),
        );
      },
    );
  }
}
