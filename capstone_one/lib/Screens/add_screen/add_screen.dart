import 'package:capstone_one/Screens/add_screen/bloc/add_bloc.dart';
import 'package:capstone_one/Screens/home_screen/bloc/home_bloc.dart';
import 'package:capstone_one/core/routes/route_keys.dart';
import 'package:capstone_one/widgets/input_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

    // NEW: State variables to hold the specific reset days
    final selectedDayOfWeek = useState<String>('Sunday');
    final selectedDayOfMonth = useState<int>(1);

    final formKey = useMemoized(() => GlobalKey<FormState>());
    final loadingKey = useMemoized(() => GlobalKey());

    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Medicine', style: TextStyle(fontWeight: .w600)),
        centerTitle: false,
      ),
      body: BlocListener<AddBloc, AddState>(
        listener: (context, state) {
          // To handle loadingIndicator
          if (loadingKey.currentContext != null &&
              // .mounted means triggered currently on the screen
              loadingKey.currentContext!.mounted) {
            // Remove from screen
            context.pop();
          }

          // Determine search state
          switch (state) {
            case AddInitial _:
              break;
            case AddLoadingState _:
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) =>
                    // Set loadingKey to this Center widget
                    Center(key: loadingKey, child: CircularProgressIndicator()),
              );
              break;
            case AddSuccessfulState _:
              // Refresh the addMedicines list in home screen
              context.read<HomeBloc>().add(LoadAddedMedicinesEvent());
              context.go(RouteKeys.homeScreen);
              break;
            case AddFailedState _:
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Failed to Add'),
                  content: Text(state.message),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Align(
                      alignment: .center,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          brandName,
                          textAlign: .center,
                          style: TextStyle(fontWeight: .bold, fontSize: 24),
                        ),
                      ),
                    ),
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
                            // Align(
                            //   alignment: .center,
                            //   child: Text(
                            //     brandName,
                            //     style: TextStyle(
                            //       fontWeight: .bold,
                            //       fontSize: 24,
                            //     ),
                            //   ),
                            // ),
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
                            Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Text(
                                'Reminder Time',
                                style: TextStyle(fontWeight: .bold),
                              ),
                            ),
                            //! I had to search for this
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 16,
                                right: 16,
                                top: 8,
                                bottom: 16,
                              ),
                              child: InkWell(
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
                            ),
                            Gap(16),
                            Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Text(
                                'Frequency',
                                style: TextStyle(fontWeight: .bold),
                              ),
                            ),
                            //! I had to search for this
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 16,
                                right: 16,
                                top: 8,
                                bottom: 16,
                              ),
                              child: DropdownButtonFormField<String>(
                                initialValue: selectedFrequency.value,
                                icon: Padding(
                                  padding: EdgeInsets.only(right: 16),
                                  child: Icon(Icons.arrow_drop_down),
                                ),
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
                            ),

                            //! I had to search for this
                            // Conditional UI for Weekly
                            if (selectedFrequency.value == 'Weekly') ...[
                              const Gap(16),
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: const Text(
                                  'Day of the Week',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              const Gap(8),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 16,
                                  right: 16,
                                  top: 0,
                                  bottom: 16,
                                ),
                                child: DropdownButtonFormField<String>(
                                  initialValue: selectedDayOfWeek.value,
                                  items:
                                      [
                                            'Sunday',
                                            'Monday',
                                            'Tuesday',
                                            'Wednesday',
                                            'Thursday',
                                            'Friday',
                                            'Saturday',
                                          ]
                                          .map(
                                            (day) => DropdownMenuItem(
                                              value: day,
                                              child: Text(day),
                                            ),
                                          )
                                          .toList(),
                                  onChanged: (newValue) {
                                    if (newValue != null) {
                                      selectedDayOfWeek.value = newValue;
                                    }
                                  },
                                ),
                              ),
                            ],

                            //! I had to search for this
                            // Conditional UI for Monthly
                            if (selectedFrequency.value == 'Monthly') ...[
                              Gap(16),
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Text(
                                  'Day of the Month',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Gap(8),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 16,
                                  right: 16,
                                  top: 0,
                                  bottom: 16,
                                ),
                                child: DropdownButtonFormField<int>(
                                  initialValue: selectedDayOfMonth.value,
                                  // Generates numbers 1 through 31
                                  items: List.generate(31, (index) => index + 1)
                                      .map(
                                        (day) => DropdownMenuItem(
                                          value: day,
                                          child: Text(day.toString()),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (newValue) {
                                    if (newValue != null) {
                                      selectedDayOfMonth.value = newValue;
                                    }
                                  },
                                ),
                              ),
                            ],
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
                            //! I had to search for this
                            if (selectedTime.value == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Please select a reminder time',
                                  ),
                                ),
                              );
                              return;
                            }
                            context.read<AddBloc>().add(
                              AddMedicineEvent(
                                brandName: brandName,
                                assignedTo: assignedToController.text,
                                numberOfPills: numberOfPillsController.text,
                                frequency: selectedFrequency.value,
                                selectedTime: selectedTime,
                                dayOfWeek: selectedFrequency.value == 'Weekly'
                                    ? selectedDayOfWeek.value
                                    : null,
                                dayOfMonth: selectedFrequency.value == 'Monthly'
                                    ? selectedDayOfMonth.value
                                    : null,
                              ),
                            );
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
      ),
    );
  }
}
