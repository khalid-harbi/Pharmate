import 'package:capstone_one/Models/new_medicine_model.dart';
import 'package:capstone_one/core/configuration.dart';
import 'package:capstone_one/core/routes/route_keys.dart';
import 'package:capstone_one/services/added_medicines_service.dart';
import 'package:capstone_one/widgets/input_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class AddScreen extends HookWidget {
  final String brandName;
  const AddScreen({super.key, required this.brandName});

  @override
  Widget build(BuildContext context) {
    final assignedToController = useTextEditingController();
    final numberOfPillsController = useTextEditingController();

    // To save Time and Frequency values
    final selectedTime = useState<TimeOfDay?>(null);
    final selectedFrequency = useState<String>('Daily');

    final formKey = useMemoized(() => GlobalKey<FormState>());

    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Medicine', style: TextStyle(fontWeight: .w600)),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.search),
                              Gap(8),
                              Text(
                                'Medicine Information',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: .w500,
                                ),
                              ),
                            ],
                          ),
                          Gap(16),
                          Text('Medicine: $brandName'),
                          InputFormWidget(
                            title: 'Assigned To',
                            hint: 'Who is taking the pills',
                            controller: assignedToController,
                          ),
                          InputFormWidget(
                            title: 'Number of Pills',
                            hint: 'Enter the number of pills',
                            controller: numberOfPillsController,
                          ),
                          Text(
                            'Reminder Time',
                            style: TextStyle(fontWeight: .bold),
                          ),
                          Gap(8),
                          //! I had to search for this
                          InkWell(
                            // async because TimeOfDay is Future
                            onTap: () async {
                              final time = await showTimePicker(
                                context: context,
                                initialTime:
                                    selectedTime.value ?? TimeOfDay.now(),
                              );
                              if (time != null) {
                                selectedTime.value = time;
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 16,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 0.5,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                // Icon at the end right
                                mainAxisAlignment: .spaceBetween,
                                children: [
                                  Text(
                                    selectedTime.value?.format(context) ??
                                        'Select Time',
                                    style: TextStyle(
                                      color: selectedTime.value == null
                                          ? Color(0xFF116484).withAlpha(150)
                                          : Color(0xFF116484),
                                      fontSize: 16,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.access_time,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Gap(16),
                          Text(
                            'Frequency',
                            style: TextStyle(fontWeight: .bold),
                          ),
                          const Gap(8),
                          DropdownButtonFormField<String>(
                            initialValue: selectedFrequency.value,
                            items: ['Daily', 'Weekly', 'Monthly'].map((
                              String value,
                            ) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              if (newValue != null) {
                                selectedFrequency.value = newValue;
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        minimumSize: Size(400, 50),
                        padding: EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(12),
                        ),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          if (selectedTime.value == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please select a reminder time'),
                              ),
                            );
                            return;
                          }
                          //TODO: Move to bloc later

                          // Format TimeOfDay to a String for easier storage/notifications
                          //! I had to search for this
                          final timeString =
                              '${selectedTime.value!.hour.toString().padLeft(2, '0')}:${selectedTime.value!.minute.toString().padLeft(2, '0')}';

                          final NewMedicineModel newMedicine = NewMedicineModel(
                            brandName: brandName,
                            assignedTo: assignedToController.text,
                            numberOfPills: numberOfPillsController.text,
                            time: timeString,
                            frequency: selectedFrequency.value,
                          );
                          getIt<AddedMedicinesService>().addNewMedicine(
                            newMedicine,
                          );

                          context.go(RouteKeys.homeScreen);
                        }
                      },
                      child: Text(
                        'Add Medicine',
                        style: TextStyle(fontSize: 16, fontWeight: .bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
