part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

class LoadAddedMedicinesState extends HomeState {
  final List<NewMedicineModel> todaysMedicines;
  final List<NewMedicineModel> upcomingMedicines;
  LoadAddedMedicinesState({
    required this.todaysMedicines,
    required this.upcomingMedicines,
  });
}
