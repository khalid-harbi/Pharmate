part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class LoadAddedMedicinesEvent extends HomeEvent {}

class MedicineTakenEvent extends HomeEvent {
  final NewMedicineModel medicine;
  final bool newValue;

  MedicineTakenEvent({required this.newValue, required this.medicine});
}
