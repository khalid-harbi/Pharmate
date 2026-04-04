import 'package:capstone_one/Screens/home_screen/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends StatelessWidget {
  // navigationShell holds the current tab screen and branch index
  final StatefulNavigationShell navigationShell;
  const MainScreen({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          // Displays the current tab screen
          body: navigationShell,
          bottomNavigationBar: BottomNavigationBar(
            // Highlights the active tab
            // Branch index is used for highlighting and tab switching
            currentIndex: navigationShell.currentIndex,

            // Pass the index (branch) of the tapped item for switching
            onTap: (index) {
              navigationShell.goBranch(index);
              // Refresh the AddedMedicines checkbox
              context.read<HomeBloc>().add(LoadAddedMedicinesEvent());
            },

            items: [
              // Branch 0
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),

              // Branch 1
              BottomNavigationBarItem(
                icon: Icon(Icons.local_pharmacy),
                label: 'Cabinet',
              ),

              // Branch 2
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}
