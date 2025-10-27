import 'package:equatable/equatable.dart';

import '../../../domain/model/user.dart';
import 'auth_event.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final User user;

  AuthSuccess(this.user);
}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}

class PasswordResetSuccess extends AuthState {}
class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}

class ForgetPasswordSuccess extends AuthState {}

class ResetPasswordSuccess extends AuthState {}
class VerifyCodeEvent extends AuthEvent {
  final String code;
  VerifyCodeEvent(this.code);
}

class ResendCodeEvent extends AuthEvent {}

class ResetPasswordEvent extends AuthEvent {
  final String password;
  final String confirmPassword;
  ResetPasswordEvent(this.password, this.confirmPassword);
}
