import 'package:exam2/features/auth/forget/forget_password.dart';
import 'package:exam2/features/auth/forget/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/di/di.dart';
import '../../theme colors/app_colors.dart';
import '../presentation/bloc/auth_bloc.dart';
import '../presentation/bloc/auth_state.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final List<TextEditingController> controllers = List.generate(4, (_) => TextEditingController());
  bool isError = false;

  bool get isCodeComplete => controllers.every((controller) => controller.text.trim().isNotEmpty);

  void validateCode() {
    setState(() {
      isError = !isCodeComplete;
    });
  }

  @override
  void dispose() {
    for (var c in controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(
        signInUseCase: sl(),
        signUpUseCase: sl(),
        forgetPasswordUseCase: sl(), resetPasswordUseCase:  sl(),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthLoading) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Verifying code...')));
            } else if (state is AuthSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Verification successful')));
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ResetPassword()));
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgetPassword()));
                      },
                      icon: Icon(Icons.arrow_back_ios, color: AppColors.black, size: 30),
                    ),
                    const SizedBox(width: 8),
                    Text("Password",
                        style: TextStyle(color: AppColors.black, fontWeight: FontWeight.w700, fontSize: 30)),
                  ],
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: Text("Email verification",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 12),
                Text(
                  "Please enter the code sent to your email address",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: AppColors.gray),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text("Email address",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.gray)),
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(4, (index) {
                      return SizedBox(
                        width: 60,
                        child: TextField(
                          controller: controllers[index],
                          maxLength: 1,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            counterText: "",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: isError ? Colors.red : Colors.grey,
                                width: 2,
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty && index < 3) {
                              FocusScope.of(context).nextFocus();
                            } else if (value.isEmpty && index > 0) {
                              FocusScope.of(context).previousFocus();
                            }
                            setState(() {});
                          },
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 16),
                if (isError)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.error, color: Colors.red, size: 20),
                      SizedBox(width: 8),
                      Text("Please fill all fields",
                          style: TextStyle(color: Colors.red, fontSize: 14)),
                    ],
                  ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: FilledButton(
                    onPressed: isCodeComplete
                        ? () {
                      validateCode();
                      if (isCodeComplete) {
                        final code = controllers.map((c) => c.text).join();
                        context.read<AuthBloc>().add(VerifyCodeEvent(code));
                      }
                    }
                        : null,
                    style: FilledButton.styleFrom(
                      foregroundColor: AppColors.white,
                      backgroundColor: isCodeComplete ? AppColors.blue : Colors.grey,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    ),
                    child: const Text("Continue",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Didn't receive code? "),
                    GestureDetector(
                      onTap: () {
                        context.read<AuthBloc>().add(ResendCodeEvent());
                      },
                      child: const Text(
                        "Resend",
                        style: TextStyle(
                          color: Colors.blue,
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
    );
  }
}
