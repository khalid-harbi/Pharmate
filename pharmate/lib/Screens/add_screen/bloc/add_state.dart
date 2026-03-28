part of 'add_bloc.dart';

@immutable
sealed class AddState {}

final class AddInitial extends AddState {}

class AddSuccessfulState extends AddState {}

final class AddLoadingState extends AddState {}

final class AddFailedState extends AddState {
  final String message;

  AddFailedState({required this.message});
}
