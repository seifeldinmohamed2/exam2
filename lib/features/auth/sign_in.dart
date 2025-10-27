import 'package:exam2/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:exam2/features/auth/presentation/bloc/auth_event.dart';
import 'package:exam2/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../home/home_page.dart';
import '../core/di/di.dart';
import '../theme colors/app_colors.dart';
import 'forget/forget_password.dart';
import 'sign_up.dart';


class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool isChecked = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  OutlineInputBorder squareBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(0),
      borderSide: BorderSide(color: color, width: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isFormEmpty =
        _emailController.text.isEmpty || _passwordController.text.isEmpty;

    return BlocProvider(
      create: (_) => AuthBloc(
        signInUseCase: sl(),
        signUpUseCase: sl(),
        forgetPasswordUseCase: sl(), resetPasswordUseCase: sl(),
      ),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthLoading) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Logging in...")),
              );
            } else if (state is AuthSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Login successful!")),
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          child: SafeArea(
            child: SingleChildScrollView(
              padding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.arrow_back_ios,
                            color: AppColors.black, size: 30),
                        const SizedBox(width: 8),
                        Text(
                          "Login",
                          style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    TextFormField(
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

                    const SizedBox(height: 25),

                    TextFormField(
                      controller: _passwordController,
                      onChanged: (_) => setState(() {}),
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        hintText: "Password",
                        labelText: "Password",
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        border: squareBorder(AppColors.gray),
                        focusedBorder: squareBorder(AppColors.gray),
                        enabledBorder: squareBorder(AppColors.gray),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        } else if (value.length < 8) {
                          return 'Password must be at least 8 characters';
                        } else if (!RegExp(
                            r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@!#\$%\^&\*]).{8,}$')
                            .hasMatch(value)) {
                          return 'Password must include upper, lower, number, and symbol';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 25),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              activeColor: AppColors.blue,
                              checkColor: AppColors.white,
                              value: isChecked,
                              onChanged: (value) {
                                setState(() {
                                  isChecked = value!;
                                });
                              },
                            ),
                            const Text('Remember me',
                                style: TextStyle(fontSize: 16)),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ForgetPassword()),
                            );
                          },
                          child: Text(
                            'Forget password?',
                            style: TextStyle(
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                              color: AppColors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: FilledButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(SignInEvent(
                              _emailController.text.trim(),
                              _passwordController.text.trim(),
                            ));
                          }
                        },
                        style: FilledButton.styleFrom(
                          foregroundColor: AppColors.white,
                          backgroundColor:
                          isFormEmpty ? Colors.grey : AppColors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        child: const Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have account? ",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUp()),
                            );
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              color: AppColors.blue,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
