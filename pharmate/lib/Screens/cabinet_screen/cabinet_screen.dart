import 'package:capstone_one/Models/new_medicine_model.dart';
import 'package:capstone_one/Screens/home_screen/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CabinetScreen extends StatelessWidget {
  const CabinetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<NewMedicineModel> addedMedicines;

    return Scaffold(
      appBar: AppBar(
        title: Text('Cabinet', style: TextStyle(fontWeight: .w600)),
      ),
      // Wrapped with home builder for addedMedicines List refreshing
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          switch (state) {
            case HomeInitial _:
              break;
            case LoadAddedMedicinesState _:

              // Merge two lists
              addedMedicines = [
                ...state.todaysMedicines,
                ...state.upcomingMedicines,
              ];
              if (addedMedicines.isEmpty) {
                return const Center(child: Text('No medicines added yet'));
              }
              return Padding(
                padding: const EdgeInsets.all(32),
                child: SafeArea(
                  child: Center(
                    child: Column(
                      children: [
                        Expanded(
                          child: GridView.builder(
                            itemCount: addedMedicines.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                ),
                            itemBuilder: (context, index) {
                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    mainAxisAlignment: .spaceAround,
                                    children: [
                                      Icon(
                                        Icons.medication_liquid,
                                        color: Colors.redAccent.withAlpha(240),
                                        size: 32,
                                      ),
                                      Text(
                                        addedMedicines[index].brandName,
                                        textAlign: .center,
                                        style: TextStyle(fontWeight: .bold),
                                      ),
                                      Text(
                                        '${addedMedicines[index].numberOfPills} pills left',
                                      ),
                                    ],
                                  ),
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
    );
  }
}
