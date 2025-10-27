import 'package:flutter/material.dart';

import '../theme colors/app_colors.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColors.white ,
      body: Column(
        children: [
          SizedBox(height: 50,),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.arrow_back_ios,color: AppColors.black,size: 40,),
              ),
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
        ],
      ),
    );
  }
}
