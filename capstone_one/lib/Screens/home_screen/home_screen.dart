import 'package:capstone_one/core/routes/route_keys.dart';
import 'package:capstone_one/core/themes/bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsPadding: EdgeInsets.all(16),
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
          IconButton(
            onPressed: () {
              context.go(RouteKeys.signInScreen);
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          child: Center(child: Column(children: [Text('Hi!')])),
        ),
      ),
    );
  }
}
