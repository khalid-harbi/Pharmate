class NewMedicineModel {
  final String brandName;
  final String assignedTo;
  String numberOfPills;
  final String time;
  final String frequency;
  bool isTaken;

  NewMedicineModel({
    required this.assignedTo,
    required this.numberOfPills,
    required this.time,
    required this.frequency,
    required this.brandName,
    required this.isTaken,
  });
}
