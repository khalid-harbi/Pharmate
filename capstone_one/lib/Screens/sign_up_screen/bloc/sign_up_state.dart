part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpState {}

final class SignUpInitial extends SignUpState {}

final class LoadingState extends SignUpState {}

final class SuccessState extends SignUpState {
  final String message;

  SuccessState({required this.message});
}

final class ErrorState extends SignUpState {
  final String message;

  ErrorState({required this.message});
}
