import 'package:capstone_one/core/routes/route_keys.dart';
import 'package:capstone_one/core/themes/bloc/theme_bloc.dart';
import 'package:capstone_one/widgets/settings_widget.dart';
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
        title: Text('Settings', style: TextStyle(fontWeight: .w600)),
        actionsPadding: EdgeInsets.all(16),
        actions: [
          // BlocBuilder to get themeData.brightness value
          BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              // for icon switch
              final isDarkMode = state.themeData.brightness == Brightness.dark;
              return IconButton(
                onPressed: () {
                  //! Theme #1
                  // We can access ThemeBloc anywhere because we wrapped
                  // the whole app with BlocProvider
                  context.read<ThemeBloc>().add(ToggleThemeEvent());
                },
                icon: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Gap(32),
                SettingsWidget(icon: Icons.person_outline, title: 'Account'),
                SettingsWidget(
                  icon: Icons.notifications_none,
                  title: 'Notifications',
                ),
                SettingsWidget(
                  icon: Icons.lock_outline,
                  title: 'Privacy & Security',
                ),
                SettingsWidget(
                  icon: Icons.headphones_outlined,
                  title: 'Help & Support',
                ),
                SettingsWidget(icon: Icons.help_outline, title: 'About'),
                Gap(52),
                TextButton(
                  onPressed: () {
                    context.go(RouteKeys.signInScreen);
                  },
                  child: Text(
                    'Sign out',
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: .w500,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
