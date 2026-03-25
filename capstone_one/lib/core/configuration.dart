import 'package:capstone_one/services/added_medicines_service.dart';
import 'package:capstone_one/services/auth_service.dart';
import 'package:get_it/get_it.dart';

//! GetIt
// Create a global instance
final getIt = GetIt.instance;

abstract class Configuration {
  //! GetIt #2
  // Register them at app startup
  static void configureDependencies() {
    getIt.registerSingleton<AuthService>(AuthService());

    getIt.registerSingleton<AddedMedicinesService>(AddedMedicinesService());
  }
}
