part of 'forgot_password_bloc.dart';

@immutable
sealed class ForgotPasswordState {}

final class ForgotPasswordInitial extends ForgotPasswordState {}

final class LoadingState extends ForgotPasswordState {}

final class SuccessState extends ForgotPasswordState {
  final String message;

  SuccessState({required this.message});
}

final class ErrorState extends ForgotPasswordState {
  final String message;

  ErrorState({required this.message});
}
