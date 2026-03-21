part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpEvent {}

class SignUpRequestEvent extends SignUpEvent {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;

  SignUpRequestEvent({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
}
