import 'package:capstone_one/core/themes/bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              //! Theme #1
              // We can access ThemeBloc because we wrapped
              // the whole app with BlocProvider
              context.read<ThemeBloc>().add(ToggleThemeEvent());
            },
            // Purpose: Rebuild UI when state changes
            icon: BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) {
                return Icon(
                  state.themeData.brightness == Brightness.light
                      ? Icons.dark_mode
                      : Icons.light_mode,
                );
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(child: Column(children: [Text('Hi!')])),
      ),
    );
  }
}
