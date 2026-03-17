part of 'sign_in_bloc.dart';

@immutable
sealed class SignInState {}

final class SignInInitial extends SignInState {}

final class SuccessState extends SignInState {}

final class LoadingState extends SignInState {}

final class ErrorState extends SignInState {
  final String message;

  ErrorState({required this.message});
}
