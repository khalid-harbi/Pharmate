import 'package:bloc/bloc.dart';
import 'package:capstone_one/Models/new_medicine_model.dart';
import 'package:capstone_one/core/configuration.dart';
import 'package:capstone_one/services/medicines_management_service.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<LoadAddedMedicinesEvent>((event, emit) {
      final List<NewMedicineModel> addedMedicines =
          getIt<MedicinesManagementService>().addedMedicines;
      // Refresh
      emit(LoadAddedMedicinesState(addedMedicines));
    });
    on<MedicineTakenEvent>((event, emit) {
      final List<NewMedicineModel> addedMedicines =
          getIt<MedicinesManagementService>().addedMedicines;
      // Update isTaken value based on the newValue
      addedMedicines[event.index].isTaken = event.newValue;

      // Subtract from the pills inventory every time the user checks the box
      int pills = int.parse(addedMedicines[event.index].numberOfPills) - 1;
      addedMedicines[event.index].numberOfPills = pills.toString();

      // Refresh
      emit(LoadAddedMedicinesState(addedMedicines));
    });
  }
}
