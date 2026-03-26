import 'package:capstone_one/Models/medicine_details_model.dart';
import 'package:capstone_one/Models/medicine_model.dart';
import 'package:capstone_one/Models/new_medicine_model.dart';
import 'package:capstone_one/core/network/network_method.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

class MedicinesManagementService {
  List<MedicineModel> medicines = [];
  List<NewMedicineModel> addedMedicines = [];

  // ---------------------
  // ---------------------
  // ---------------------

  void addNewMedicine(NewMedicineModel medicine) {
    addedMedicines.add(medicine);
  }

  // ---------------------
  // ---------------------
  // ---------------------

  Future<Either<String, List<MedicineModel>>> search({
    required String searchText,
  }) async {
    try {
      final api = NetworkMethod(medicineName: searchText);
      medicines = await api.getAllSearchResults();
      if (medicines.isNotEmpty && medicines != []) {
        // Success! (Because it's a Right)
        return Either.right(medicines);
      }

      // Fail! (Because it's a Left)
      return Either.left('Error loading medicines');
    } catch (error) {
      return Either.left("Something went wrong. Please try again.");
    }
  }

  // ---------------------
  // ---------------------
  // ---------------------

  Future<Either<String, MedicineDetailsModel>> details({
    required String brandName,
  }) async {
    try {
      final api = NetworkMethod(medicineName: brandName);

      // Create the Medicine Object
      final MedicineDetailsModel? medicineDetails = await api
          .getMedicineDetails();
      if (medicineDetails != null) {
        // Success! (Because it's a Right)
        return Either.right(medicineDetails);
      }

      // Fail! (Because it's a Left)
      return Either.left('Error loading medicine details');
    } catch (error) {
      return Either.left("Something went wrong. Please try again.");
    }
  }

  // ---------------------
  // ---------------------
  // ---------------------

  Future<Either<String, String>> add({
    required ValueNotifier<TimeOfDay?> selectedTime,
    required String brandName,
    required String assignedTo,
    //TODO: change to int later
    required String numberOfPills,
    required String frequency,
  }) async {
    try {
      //! I had to search for this
      // Format TimeOfDay to a String for easier storage/notifications
      final timeString =
          '${selectedTime.value!.hour.toString().padLeft(2, '0')}:${selectedTime.value!.minute.toString().padLeft(2, '0')}';

      final NewMedicineModel newMedicine = NewMedicineModel(
        brandName: brandName,
        assignedTo: assignedTo,
        numberOfPills: numberOfPills,
        time: timeString,
        frequency: frequency,
      );
      addedMedicines.add(newMedicine);

      if (addedMedicines.contains(newMedicine)) {
        // Success! (Because it's a Right)
        return Either.right('');
      }

      // Fail! (Because it's a Left)
      return Either.left('Error adding medicine');
    } catch (error) {
      return Either.left("Something went wrong. Please try again.");
    }
  }
}
