part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class LoadAddedMedicinesEvent extends HomeEvent {}

class MedicineTakenEvent extends HomeEvent {
  final int index;
  final bool newValue;

  MedicineTakenEvent({required this.index, required this.newValue});
}
