class NewMedicineModel {
  final String brandName;
  final String assignedTo;
  final String numberOfPills;
  final String time;
  final String frequency;

  NewMedicineModel({
    required this.assignedTo,
    required this.numberOfPills,
    required this.time,
    required this.frequency, required this.brandName,
  });
}
