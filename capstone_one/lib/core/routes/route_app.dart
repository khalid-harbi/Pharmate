import 'package:capstone_one/Models/medicine_details_model.dart';
import 'package:capstone_one/Screens/add_screen/add_screen.dart';
import 'package:capstone_one/Screens/medicine_details_screen/medicine_details_screen.dart';
import 'package:capstone_one/Screens/search_screen/search_screen.dart';
import 'package:capstone_one/Screens/cabinet_screen/cabinet_screen.dart';
import 'package:capstone_one/Screens/forgot_password_screen/bloc/forgot_password_bloc.dart';
import 'package:capstone_one/Screens/forgot_password_screen/forgot_password_screen.dart';
import 'package:capstone_one/Screens/home_screen/home_screen.dart';
import 'package:capstone_one/Screens/main_screen/main_screen.dart';
import 'package:capstone_one/Screens/settings_screen/settings_screen.dart';
import 'package:capstone_one/Screens/sign_in_screen/bloc/sign_in_bloc.dart';
import 'package:capstone_one/Screens/sign_in_screen/sign_in_screen.dart';
import 'package:capstone_one/Screens/sign_up_screen/bloc/sign_up_bloc.dart';
import 'package:capstone_one/Screens/sign_up_screen/sign_up_screen.dart';
import 'package:capstone_one/core/configuration.dart';
import 'package:capstone_one/core/routes/route_keys.dart';
import 'package:capstone_one/services/auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RouteApp {
  RouteApp._();

  static final routes = GoRouter(
    initialLocation: RouteKeys.signInScreen,

    // -------------------------
    // -------------------------
    routes: [
      // -------------------------
      // -------------------------
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          // navigationShell manages tab switching and state
          // Starts with holding Branch 0
          return MainScreen(navigationShell: navigationShell);
        },

        // -------------------------
        // -------------------------
        branches: [
          // Branch 0
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteKeys.homeScreen,
                builder: (context, state) {
                  return HomeScreen();
                },
              ),
            ],
          ),

          // Branch 1
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteKeys.cabinetScreen,
                builder: (context, state) {
                  return CabinetScreen();
                },
              ),
            ],
          ),

          // Branch 2
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteKeys.settingsScreen,
                builder: (context, state) {
                  return SettingsScreen();
                },
              ),
            ],
          ),
        ],
      ),

      // -------------------------
      // -------------------------
      // -------------------------
      GoRoute(
        path: RouteKeys.signInScreen,
        builder: (context, state) {
          // Purpose: Provide or create the bloc
          // makes the bloc available to widgets below it in the widget tree
          return BlocProvider(
            //! GetIt #3
            // Access from anywhere
            create: (context) => SignInBloc(authService: getIt<AuthService>()),
            child: SignInScreen(),
          );
        },
      ),
      GoRoute(
        path: RouteKeys.signUpScreen,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => SignUpBloc(authService: getIt<AuthService>()),
            child: SignUpScreen(),
          );
        },
      ),
      GoRoute(
        path: RouteKeys.forgotPasswordScreen,
        builder: (context, state) {
          return BlocProvider(
            create: (context) =>
                ForgotPasswordBloc(authService: getIt<AuthService>()),
            child: ForgotPasswordScreen(),
          );
        },
      ),
      GoRoute(
        path: RouteKeys.searchScreen,
        builder: (context, state) {
          return SearchScreen();
        },
      ),
      GoRoute(
        path: RouteKeys.medicineDetailsScreen,
        builder: (context, state) {
          // Receive more than one extra
          final data = GoRouterState.of(context).extra as Map;
          final passedMedicineDetails = data['details'] as MedicineDetailsModel;
          final passedBrandName = data['brandName'] as String;

          return MedicineDetailsScreen(
            medicineDetails: passedMedicineDetails,
            brandName: passedBrandName,
          );
        },
      ),
      GoRoute(
        path: RouteKeys.addScreen,
        builder: (context, state) {
          final passedBrandName = state.extra as String;
          return AddScreen(brandName: passedBrandName);
        },
      ),
    ],
  );
}
