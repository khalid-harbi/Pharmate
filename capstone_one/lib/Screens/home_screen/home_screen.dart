import 'package:capstone_one/Models/new_medicine_model.dart';
import 'package:capstone_one/Screens/home_screen/bloc/home_bloc.dart';
import 'package:capstone_one/core/routes/route_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          switch (state) {
            case HomeInitial _:
              break;
            case LoadAddedMedicinesState _:
              final List<NewMedicineModel> todaysMedicines =
                  state.todaysMedicines;
              final List<NewMedicineModel> upcomingMedicines =
                  state.upcomingMedicines;

              if (todaysMedicines.isEmpty && upcomingMedicines.isEmpty) {
                return const Center(child: Text('No medicines added yet.'));
              }
              return Padding(
                padding: const EdgeInsets.all(16),
                child: SafeArea(
                  child: ListView(
                    children: [
                      // TODAY'S MEDICINES
                      //! I had to search for this
                      if (todaysMedicines.isNotEmpty) ...[
                        const Text(
                          "Today's Medicines",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Gap(8),
                        ...todaysMedicines.map(
                          (medicine) => ListTile(
                            leading: Checkbox(
                              value: medicine.isTaken,
                              onChanged: medicine.isTaken
                                  // greys out checkbox if value is true
                                  ? null
                                  : (bool? newValue) {
                                      context.read<HomeBloc>().add(
                                        MedicineTakenEvent(
                                          medicine: medicine,
                                          newValue: newValue ?? false,
                                        ),
                                      );
                                    },
                            ),
                            title: Row(
                              children: [
                                const Icon(Icons.medication, size: 20),
                                const Gap(8),
                                Expanded(
                                  child: Text(
                                    medicine.brandName,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Row(
                              children: [
                                const Icon(
                                  Icons.person_outline_rounded,
                                  size: 16,
                                ),
                                const Gap(8),
                                Text(medicine.assignedTo),
                              ],
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(medicine.time),
                                Text(medicine.frequency),
                              ],
                            ),
                          ),
                        ),
                        const Gap(24),
                      ],

                      // UPCOMING MEDICINES
                      //! I had to search for this
                      if (upcomingMedicines.isNotEmpty) ...[
                        const Text(
                          "Upcoming Medicines",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        const Gap(8),
                        ...upcomingMedicines.map(
                          (medicine) => ListTile(
                            // Checkbox is hidden for upcoming medicines
                            leading: const SizedBox(width: 40, height: 40),
                            title: Row(
                              children: [
                                const Icon(
                                  Icons.medication,
                                  size: 20,
                                  color: Colors.grey,
                                ),
                                const Gap(8),
                                Expanded(
                                  child: Text(
                                    medicine.brandName,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Row(
                              children: [
                                const Icon(
                                  Icons.person_outline_rounded,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                                const Gap(8),
                                Text(
                                  medicine.assignedTo,
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  medicine.time,
                                  style: const TextStyle(color: Colors.grey),
                                ),
                                Text(
                                  medicine.frequency,
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: Padding(
        padding: EdgeInsetsGeometry.only(right: 8, bottom: 16),
        child: FloatingActionButton.large(
          onPressed: () {
            context.push(RouteKeys.searchScreen);
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
