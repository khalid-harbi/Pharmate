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
    List<NewMedicineModel> addedMedicines;
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          switch (state) {
            case HomeInitial _:
              break;
            case LoadAddedMedicinesState _:
              addedMedicines = state.addedMedicines;
              if (addedMedicines.isEmpty) {
                return Center(child: Text('No medicines added yet.'));
              }
              return Padding(
                padding: const EdgeInsets.all(16),
                child: SafeArea(
                  child: Center(
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: addedMedicines.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: Checkbox(
                                  // Take the value from the model
                                  value: addedMedicines[index].isTaken,
                                  onChanged: (bool? newValue) {
                                    context.read<HomeBloc>().add(
                                      MedicineTakenEvent(
                                        // Send current index to update each tile individually
                                        index: index,
                                        // Value after clicking will be sent too
                                        newValue: newValue ?? false,
                                      ),
                                    );
                                  },
                                ),
                                title: Row(
                                  children: [
                                    const Icon(Icons.medication, size: 20),
                                    const Gap(8),
                                    Text(addedMedicines[index].brandName),
                                  ],
                                ),
                                subtitle: Row(
                                  children: [
                                    Icon(Icons.person_outline_rounded),
                                    Gap(8),
                                    Text(addedMedicines[index].assignedTo),
                                  ],
                                ),
                                trailing: Column(
                                  children: [
                                    Text(addedMedicines[index].time),
                                    Text(addedMedicines[index].frequency),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
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
