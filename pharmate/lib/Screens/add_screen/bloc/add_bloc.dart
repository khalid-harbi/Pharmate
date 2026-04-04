import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:capstone_one/services/medicines_management_service.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'add_event.dart';
part 'add_state.dart';

class AddBloc extends Bloc<AddEvent, AddState> {
  final MedicinesManagementService medicineService;

  AddBloc({required this.medicineService}) : super(AddInitial()) {
    on<AddMedicineEvent>(addMethod);
  }

  FutureOr<void> addMethod(
    // Take event from DetailsRequestEvent
    AddMedicineEvent event,
    // Take emit from SearchState
    Emitter<AddState> emit,
  ) async {
    // This will be implemented always
    emit(AddLoadingState());
    // Call fp dart MedicinesManagementService detail method
    (await medicineService.add(
      selectedTime: event.selectedTime,
      brandName: event.brandName,
      assignedTo: event.assignedTo,
      numberOfPills: event.numberOfPills,
      frequency: event.frequency,
      dayOfWeek: event.dayOfWeek,
      dayOfMonth: event.dayOfMonth,
    )).fold(
      // Check returned results from fp dart MedicinesManagementService details method
      (onLeft) {
        emit(AddFailedState(message: onLeft));
      },
      (onRight) {
        emit(AddSuccessfulState());
      },
    );
  }
}
