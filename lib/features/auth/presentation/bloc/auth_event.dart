abstract class AuthEvent {
  AuthEvent();
}


class LoginRequestEvent extends AuthEvent{
  final String email;
  final String password;

  LoginRequestEvent(this.email,this.password);
}
