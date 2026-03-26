import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:capstone_one/Models/medicine_details_model.dart';
import 'package:capstone_one/Models/medicine_model.dart';
import 'package:capstone_one/services/medicines_management_service.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final MedicinesManagementService medicineService;

  List<MedicineModel> medicines = [];
  SearchBloc({required this.medicineService}) : super(SearchInitial()) {
    on<SearchEvent>((event, emit) {});
    on<SearchRequestEvent>(searchMethod);
    on<DetailsRequestEvent>(detailsMethod);
  }

  FutureOr<void> searchMethod(
    // Take event from SearchRequestEvent
    SearchRequestEvent event,
    // Take emit from SearchState
    Emitter<SearchState> emit,
  ) async {
    // This will be implemented always
    emit(MedicinesLoadingState());
    // Call fp dart MedicinesManagementService search method
    (await medicineService.search(searchText: event.searchText)).fold(
      // Check returned results from fp dart MedicinesManagementService search method
      (onLeft) {
        emit(MedicinesLoadingFailedState(message: onLeft));
      },
      (onRight) {
        emit(MedicinesFetchingSuccessfulState(medicines: onRight));
      },
    );
  }

  FutureOr<void> detailsMethod(
    // Take event from DetailsRequestEvent
    DetailsRequestEvent event,
    // Take emit from SearchState
    Emitter<SearchState> emit,
  ) async {
    // This will be implemented always
    emit(MedicineDetailsLoadingState());
    // Call fp dart MedicinesManagementService detail method
    (await medicineService.details(brandName: event.brandName)).fold(
      // Check returned results from fp dart MedicinesManagementService details method
      (onLeft) {
        emit(MedicineDetailsFailedState(message: onLeft));
      },
      (onRight) {
        emit(MedicineDetailsSuccessfulState(medicineDetails: onRight));
      },
    );
  }
}
