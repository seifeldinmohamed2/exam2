import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/useCase/forget_password_use_case.dart';
import '../../../domain/useCase/reset_password_use_case.dart';
import '../../../domain/useCase/sign_in_use_case.dart';
import '../../../domain/useCase/sign_up_use_case.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final ForgetPasswordUseCase forgetPasswordUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;

  AuthBloc({
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.forgetPasswordUseCase,
    required this.resetPasswordUseCase,
  }) : super(AuthInitial()) {
    on<SignInEvent>(_onSignIn);
    on<SignUpEvent>(_onSignUp);
    on<ForgetPasswordEvent>(_onForgetPassword);
  }

  Future<void> _onSignIn(SignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await signInUseCase(event.email, event.password);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onSignUp(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await signUpUseCase(event.name, event.email, event.password);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onForgetPassword(ForgetPasswordEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await forgetPasswordUseCase(event.email);
      emit(PasswordResetSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
