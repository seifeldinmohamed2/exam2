
import '../repositories/auth.dart';

class ForgetPasswordUseCase {
  final AuthRepository repository;
  ForgetPasswordUseCase(this.repository);

  Future<void> call(String email) {
    return repository.forgetPassword(email);
  }
}
