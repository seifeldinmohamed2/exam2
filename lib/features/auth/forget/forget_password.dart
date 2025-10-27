import 'package:exam2/features/auth/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/di/di.dart';
import '../../theme colors/app_colors.dart';
import '../presentation/bloc/auth_bloc.dart';
import '../presentation/bloc/auth_event.dart';
import '../presentation/bloc/auth_state.dart';
import 'email_verification_screen.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  bool isChecked = false;

  OutlineInputBorder squareBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(0),
      borderSide: BorderSide(color: color, width: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isFormEmpty = _emailController.text.isEmpty;

    return BlocProvider(
      create: (_) => AuthBloc(
        signInUseCase: sl(),
        signUpUseCase: sl(),
        forgetPasswordUseCase: sl(),
        resetPasswordUseCase: sl(),
      ),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is ForgetPasswordSuccess) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const EmailVerificationScreen(),
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
            body: Column(
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
                              builder: (context) => const SignIn(),
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
                    "Forget Password",
                    style: TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                    ),
                  ),
                ),
                Text(
                  "Please enter your email associated to",
                  style: TextStyle(
                    color: AppColors.gray,
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                  ),
                ),
                Text(
                  "your account",
                  style: TextStyle(
                    color: AppColors.gray,
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                  ),
                ),
                Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _emailController,
                    onChanged: (_) => setState(() {}),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Email",
                      labelText: "Email",
                      border: squareBorder(AppColors.gray),
                      focusedBorder: squareBorder(AppColors.gray),
                      enabledBorder: squareBorder(AppColors.gray),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      } else if (!value.endsWith('@gmail.com')) {
                        return 'Not a @gmail.com';
                      }
                      return null;
                    },
                  ),
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
                          ForgetPasswordEvent(_emailController.text),
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
          );
        },
      ),
    );
  }
}
