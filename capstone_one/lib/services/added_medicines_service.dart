import 'package:capstone_one/Models/new_medicine_model.dart';

class AddedMedicinesService {
  List<NewMedicineModel> addedMedicines = [];

  void addNewMedicine(NewMedicineModel medicine) {
    addedMedicines.add(medicine);
  }
}
