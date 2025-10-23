
import '../model/user.dart';
import '../repositories/auth.dart';

class SignUpUseCase {
  final AuthRepository repository;
  SignUpUseCase(this.repository);

  Future<User> call(String name, String email, String password) {
    return repository.signUp(name, email, password);
  }
}
