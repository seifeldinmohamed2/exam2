
import 'package:dio/dio.dart';

import '../model/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signIn(String email, String password);
  Future<UserModel> signUp(String name, String email, String password);
  Future<void> forgetPassword(String email);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<UserModel> signIn(String email, String password) async {
    final response = await dio.post('https://exam.elevateegy.com/api/v1/auth/signin', data: {
      'email': email,
      'password': password,
    });
    return UserModel.fromJson(response.data);
  }

  @override
  Future<UserModel> signUp(String name, String email, String password) async {
    final response = await dio.post('https://exam.elevateegy.com/api/v1/auth/signup', data: {
      'name': name,
      'email': email,
      'password': password,
    });
    return UserModel.fromJson(response.data);
  }

  @override
  Future<void> forgetPassword(String email) async {
    await dio.post('https://exam.elevateegy.com/api/v1/auth/changePassword', data: {
      'email': email,
    });
  }
}
