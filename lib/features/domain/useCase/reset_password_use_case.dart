
import '../repositories/auth.dart';

class ResetPasswordUseCase {
  final AuthRepository repository;

  ResetPasswordUseCase(this.repository);

  Future<void> call(String password, String confirmPassword) async {
    return await repository.resetPassword(password, confirmPassword);
  }
}
