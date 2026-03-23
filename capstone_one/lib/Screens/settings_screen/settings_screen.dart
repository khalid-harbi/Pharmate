import 'package:capstone_one/core/routes/route_keys.dart';
import 'package:capstone_one/core/themes/bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsPadding: EdgeInsets.all(16),
        actions: [
          IconButton(
            onPressed: () {
              context.go(RouteKeys.signInScreen);
            },
            icon: Icon(Icons.logout, color: Colors.redAccent),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: .spaceEvenly,
            children: [
              // BlocBuilder to get themeData.brightness value
              BlocBuilder<ThemeBloc, ThemeState>(
                builder: (context, state) {
                  final isDarkMode =
                      state.themeData.brightness == Brightness.dark;
                  return Row(
                    mainAxisAlignment: .center,
                    children: [
                      Switch(
                        value: isDarkMode,
                        onChanged: (value) {
                          //! Theme #1
                          // We can access ThemeBloc anywhere because we wrapped
                          // the whole app with BlocProvider
                          context.read<ThemeBloc>().add(ToggleThemeEvent());
                        },
                      ),
                      Gap(8),
                      Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
