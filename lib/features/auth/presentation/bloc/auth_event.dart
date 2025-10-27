
import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  SignInEvent(this.email, this.password);
}
class SignUpEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String phone;
  final String address;
  final String image;

  SignUpEvent(this.name, this.email, this.password, this.phone, this.address, this.image);
}


class ForgetPasswordEvent extends AuthEvent {
  final String email;

  ForgetPasswordEvent(this.email);
}
