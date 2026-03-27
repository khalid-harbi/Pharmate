part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

class LoadAddedMedicinesState extends HomeState {
  final List<NewMedicineModel> addedMedicines;
  LoadAddedMedicinesState(this.addedMedicines);
}
