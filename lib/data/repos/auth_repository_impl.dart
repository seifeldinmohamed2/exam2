
import '../../api/dataSource/auth_remote_data_source.dart';
import '../../domain/model/user.dart';
import '../../domain/repositories/auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<User> signIn(String email, String password) async {
    final userModel = await remoteDataSource.signIn(email, password);
    return userModel;
  }

  @override
  Future<User> signUp(String name, String email, String password) async {
    final userModel = await remoteDataSource.signUp(name, email, password);
    return userModel;
  }

  @override
  Future<void> forgetPassword(String email) {
    return remoteDataSource.forgetPassword(email);
  }
}
