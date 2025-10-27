import 'package:exam2/features/auth/sign_in.dart';
import 'package:exam2/features/theme colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/di/di.dart';
import '../presentation/bloc/auth_bloc.dart';
import '../presentation/bloc/auth_state.dart';
import 'email_verification_screen.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();

  OutlineInputBorder squareBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(0),
      borderSide: BorderSide(color: color, width: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isFormEmpty =
        _passwordController.text.isEmpty || _rePasswordController.text.isEmpty;

    return BlocProvider(
      create: (_) => AuthBloc(
        signInUseCase: sl(),
        signUpUseCase: sl(),
        forgetPasswordUseCase: sl(),
        resetPasswordUseCase: sl(),
      ),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is ResetPasswordSuccess) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SignIn(),
              ),
            );
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.white,
            body: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                const EmailVerificationScreen(),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: AppColors.black,
                            size: 40,
                          ),
                        ),
                      ),
                      Text(
                        "Password",
                        style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Reset password",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Password must not be empty and must contain",
                      style: TextStyle(fontSize: 16, color: AppColors.gray),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "6 characters with upper case letter and one",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.gray,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "number at least",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.gray,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Enter password",
                      labelText: "Password",
                      border: squareBorder(AppColors.gray),
                      focusedBorder: squareBorder(AppColors.gray),
                      enabledBorder: squareBorder(AppColors.gray),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Password';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 25),
                  TextFormField(
                    controller: _rePasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Confirm password",
                      labelText: "Re-Password",
                      border: squareBorder(AppColors.gray),
                      focusedBorder: squareBorder(AppColors.gray),
                      enabledBorder: squareBorder(AppColors.gray),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Confirm your password';
                      } else if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 50),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: FilledButton(
                      onPressed: state is AuthLoading
                          ? null
                          : () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                            ResetPasswordEvent(
                              _passwordController.text,
                              _rePasswordController.text,
                            ),
                          );
                        }
                      },
                      style: FilledButton.styleFrom(
                        foregroundColor: AppColors.white,
                        backgroundColor:
                        isFormEmpty ? Colors.grey : AppColors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: state is AuthLoading
                          ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                          : const Text(
                        "Continue ",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
