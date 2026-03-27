import 'package:bloc/bloc.dart';
import 'package:capstone_one/Models/new_medicine_model.dart';
import 'package:capstone_one/core/configuration.dart';
import 'package:capstone_one/services/medicines_management_service.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

//! I got help for most of this homeBloc file
//! ---------------------------------------------------
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<LoadAddedMedicinesEvent>((event, emit) {
      final List<NewMedicineModel> addedMedicines =
          getIt<MedicinesManagementService>().addedMedicines;

      // Current date and time
      final DateTime now = DateTime.now();

      // loop through addedMedicines to reset checkbox
      for (var medicine in addedMedicines) {
        // Skip if checkbox is already unchecked
        if (!medicine.isTaken) continue;

        bool shouldReset = false;

        // Check if we already reset today
        bool alreadyResetToday =
            medicine.lastResetDate != null &&
            medicine.lastResetDate!.year == now.year &&
            medicine.lastResetDate!.month == now.month &&
            medicine.lastResetDate!.day == now.day;

        // 1. Time Parsing Logic
        final parsedTime = DateFormat("hh:mm a").parse(medicine.time);

        // 2. Convert both to total minutes since midnight for easy comparison
        final medicineTimeInMinutes =
            (parsedTime.hour * 60) + parsedTime.minute;
        final nowInMinutes = (now.hour * 60) + now.minute;

        // 3. True if the current time is exactly at, or past, the reminder time
        bool hasTimePassed = nowInMinutes >= medicineTimeInMinutes;

        // Daily Logic
        if (medicine.frequency == 'Daily') {
          if (!alreadyResetToday && hasTimePassed) {
            shouldReset = true;
          }
        }
        // Weekly Logic
        else if (medicine.frequency == 'Weekly') {
          String todayString = DateFormat('EEEE').format(now);
          if (todayString == medicine.dayOfWeek &&
              !alreadyResetToday &&
              hasTimePassed) {
            shouldReset = true;
          }
        }
        // Monthly Logic
        else if (medicine.frequency == 'Monthly') {
          if (now.day == medicine.dayOfMonth &&
              !alreadyResetToday &&
              hasTimePassed) {
            shouldReset = true;
          }
        }
        // Reset Logic
        if (shouldReset) {
          medicine.isTaken = false;
          medicine.lastResetDate = now;
        }
      }

      // Sorting Logic
      List<NewMedicineModel> todaysList = [];
      List<NewMedicineModel> upcomingList = [];

      final String todayString = DateFormat('EEEE').format(now);
      final int todayDate = now.day;
      for (var medicine in addedMedicines) {
        bool isToday = false;

        if (medicine.frequency == 'Daily') {
          isToday = true;
        } else if (medicine.frequency == 'Weekly' &&
            medicine.dayOfWeek == todayString) {
          isToday = true;
        } else if (medicine.frequency == 'Monthly' &&
            medicine.dayOfMonth == todayDate) {
          isToday = true;
        }

        if (isToday) {
          todaysList.add(medicine);
        } else {
          upcomingList.add(medicine);
        }
      }
      emit(
        LoadAddedMedicinesState(
          todaysMedicines: List.from(todaysList),
          upcomingMedicines: List.from(upcomingList),
        ),
      );
    });

    on<MedicineTakenEvent>((event, emit) {
      // Update isTaken value based on the newValue
      event.medicine.isTaken = event.newValue;
      // Subtract from the pills inventory every time the user checks the box
      int pills = int.parse(event.medicine.numberOfPills) - 1;
      event.medicine.numberOfPills = pills.toString();
      // Refresh
      add(LoadAddedMedicinesEvent());
    });
  }
}

//! ---------------------------------------------------
