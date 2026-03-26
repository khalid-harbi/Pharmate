import 'package:capstone_one/core/configuration.dart';
import 'package:capstone_one/core/routes/route_keys.dart';
import 'package:capstone_one/services/medicines_management_service.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final addedMedicines = getIt<MedicinesManagementService>().addedMedicines;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    //TODO: needs to be wrabbed with bloc builder to refresh the state
                    itemCount: addedMedicines.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(Icons.medication),
                        title: Text(addedMedicines[index].brandName),
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
