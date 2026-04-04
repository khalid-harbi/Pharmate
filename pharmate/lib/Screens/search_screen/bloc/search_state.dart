part of 'search_bloc.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

//~ #14
class MedicinesFetchingSuccessfulState extends SearchState {
  final List<MedicineModel> medicines;

  MedicinesFetchingSuccessfulState({required this.medicines});
}

final class MedicinesLoadingState extends SearchState {}

final class MedicinesLoadingFailedState extends SearchState {
  final String message;

  MedicinesLoadingFailedState({required this.message});
}

// ------------------------
// ------------------------

class MedicineDetailsSuccessfulState extends SearchState {
  final MedicineDetailsModel medicineDetails;

  MedicineDetailsSuccessfulState({required this.medicineDetails});
}

final class MedicineDetailsLoadingState extends SearchState {}

final class MedicineDetailsFailedState extends SearchState {
  final String message;

  MedicineDetailsFailedState({required this.message});
}
