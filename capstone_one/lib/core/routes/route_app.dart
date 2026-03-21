import 'package:capstone_one/Screens/home_screen/home_screen.dart';
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
    routes: [
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
        path: RouteKeys.homeScreen,
        builder: (context, state) {
          return HomeScreen();
        },
      ),
    ],
  );
}
