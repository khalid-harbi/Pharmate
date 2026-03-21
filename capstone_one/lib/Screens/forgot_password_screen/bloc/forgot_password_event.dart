part of 'forgot_password_bloc.dart';

@immutable
sealed class ForgotPasswordEvent {}

class ForgotPasswordRequestEvent extends ForgotPasswordEvent {
  final String email;

  ForgotPasswordRequestEvent({required this.email});
}
