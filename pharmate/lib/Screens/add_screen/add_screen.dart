import 'package:capstone_one/Screens/add_screen/bloc/add_bloc.dart';
import 'package:capstone_one/Screens/home_screen/bloc/home_bloc.dart';
import 'package:capstone_one/core/routes/route_keys.dart';
import 'package:capstone_one/core/themes/bloc/theme_bloc.dart';
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

    // To save Time and Frequency values, doesn't get removed with UI rebuild
    // values are needed to be saved to display them on UI
    final selectedTime = useState<TimeOfDay?>(TimeOfDay.now());
    final selectedFrequency = useState<String>('Daily');

    // State variables to hold the specific reset days
    final selectedDayOfWeek = useState<String>('Sunday');
    final selectedDayOfMonth = useState<int>(1);

    final formKey = useMemoized(() => GlobalKey<FormState>());
    final loadingKey = GlobalKey();

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
                    Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        children: [
                          Icon(
                            Icons.medication_liquid,
                            size: 32,
                            color: Colors.redAccent.withAlpha(240),
                          ),
                          Gap(8),
                          Text(
                            brandName,
                            textAlign: .center,
                            style: TextStyle(fontWeight: .bold, fontSize: 24),
                          ),
                        ],
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
                                Icon(
                                  Icons.info_outline,
                                  color: Colors.blueAccent,
                                ),
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
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 16,
                                right: 16,
                                top: 8,
                                bottom: 16,
                              ),
                              //! I had to search for this
                              child: InkWell(
                                // async because TimeOfDay is Future
                                onTap: () async {
                                  final time = await showTimePicker(
                                    context: context,
                                    initialTime:
                                        selectedTime.value ?? TimeOfDay.now(),
                                  );
                                  selectedTime.value = time;
                                },

                                // Match other fields style
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
                                      BlocBuilder<ThemeBloc, ThemeState>(
                                        builder: (context, state) {
                                          return Text(
                                            // display time in proper format
                                            selectedTime.value!.format(context),
                                            style: TextStyle(
                                              color:
                                                  state.themeData.brightness ==
                                                      Brightness.light
                                                  ? Color(0xFF0F3A4C)
                                                  : Color(0xFFEEF5F9),
                                              fontSize: 16,
                                            ),
                                          );
                                        },
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

                              // Dropdown field input
                              child: DropdownButtonFormField<String>(
                                initialValue: selectedFrequency.value,
                                icon: Padding(
                                  padding: EdgeInsets.only(right: 16),
                                  child: Icon(Icons.arrow_drop_down),
                                ),

                                // loop through Dropdown field values and creates and option for each
                                items: ['Daily', 'Weekly', 'Monthly'].map(
                                  (String value) {
                                    // One option inside the dropdown list
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  },
                                ).toList(), // items parameter expects a list of items
                                onChanged: (newValue) {
                                  if (newValue != null) {
                                    selectedFrequency.value = newValue;
                                  }
                                },
                              ),
                            ),

                            //! I had to search for this
                            // Conditional UI for Weekly
                            // ... [ ] means if the condition is true
                            // add the widgets inside the list to the column
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
                                  icon: Padding(
                                    padding: EdgeInsets.only(right: 16),
                                    child: Icon(Icons.arrow_drop_down),
                                  ),
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
                            // ... [] means if the condition is true
                            // add the widgets inside the list to the column
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
                                  icon: Padding(
                                    padding: EdgeInsets.only(right: 16),
                                    child: Icon(Icons.arrow_drop_down),
                                  ),
                                  // Generates numbers 1 through 31
                                  // 31 is the length , value is index + 1
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
