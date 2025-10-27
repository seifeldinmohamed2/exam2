import 'package:exam2/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:exam2/features/auth/presentation/bloc/auth_event.dart';
import 'package:exam2/features/auth/presentation/bloc/auth_state.dart';
import 'package:exam2/features/auth/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/di/di.dart';
import '../theme colors/app_colors.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  final _userNameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(
        signInUseCase: sl(),
        signUpUseCase: sl(),
        forgetPasswordUseCase: sl(), resetPasswordUseCase: sl(),
      ),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthLoading) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Signing up...')),
                );
              } else if (state is AuthSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Sign up successful!')),
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignIn()),
                );
              } else if (state is AuthFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SignIn()),
                            );
                          },
                          icon: Icon(Icons.arrow_back_ios, color: AppColors.black, size: 30),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Sign Up",
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
                      controller: _userNameController,
                      decoration: InputDecoration(
                        hintText: "Enter your user name",
                        labelText: "User Name",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter User Name';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _firstNameController,
                            decoration: InputDecoration(
                              hintText: "Enter first name",
                              labelText: "First Name",
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter First Name';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            controller: _lastNameController,
                            decoration: InputDecoration(
                              hintText: "Enter last name",
                              labelText: "Last Name",
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter Last Name';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Enter your email",
                        labelText: "Email",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Email';
                        } else if (!value.endsWith('@gmail.com')) {
                          return 'Not a @gmail.com';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: "Enter password",
                              labelText: "Password",
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter Password';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            controller: _rePasswordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: "Confirm password",
                              labelText: "Re-Password",
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Confirm Password';
                              } else if (value != _passwordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: "Enter phone number",
                        labelText: "Phone",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Phone';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                              SignUpEvent(
                                _userNameController.text,
                                _firstNameController.text,
                                _lastNameController.text,
                                _emailController.text,
                                _passwordController.text,
                                _phoneController.text,
                              ),
                            );
                          }
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.white,
                          ),
                        ),
                      ),
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
