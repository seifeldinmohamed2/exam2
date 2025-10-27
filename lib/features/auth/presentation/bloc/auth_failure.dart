import 'auth_state.dart';

class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}

class ForgetPasswordSuccess extends AuthState {}

class ResetPasswordSuccess extends AuthState {}
