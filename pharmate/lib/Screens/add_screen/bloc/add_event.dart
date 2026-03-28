part of 'add_bloc.dart';

@immutable
sealed class AddEvent {}

class AddMedicineEvent extends AddEvent {
  final String brandName;
  final String assignedTo;
  final String numberOfPills;
  final String frequency;
  final ValueNotifier<TimeOfDay?> selectedTime;
  final String? dayOfWeek;
  final int? dayOfMonth;

  AddMedicineEvent({
    required this.brandName,
    required this.assignedTo,
    required this.numberOfPills,
    required this.frequency,
    required this.selectedTime,
    this.dayOfWeek,
    this.dayOfMonth,
  });
}
