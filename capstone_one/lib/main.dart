import 'package:capstone_one/core/configuration.dart';
import 'package:capstone_one/core/routes/route_app.dart';
import 'package:capstone_one/core/themes/bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  // Required if there are any running code before runApp()
  WidgetsFlutterBinding.ensureInitialized();
  // This runs GetIt setup
  Configuration.configureDependencies();
  runApp(
    // Required for the theme for initial state
    // Purpose: Provide or create the bloc
    BlocProvider(create: (context) => ThemeBloc(), child: const MainApp()),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Required for the theme
    // Purpose: Rebuild UI when state changes
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        // Check and apply theme state every time it changes
        return MaterialApp.router(
          routerConfig: RouteApp.routes,
          //! Theme #5
          theme: state.themeData,
        );
      },
    );
  }
}
