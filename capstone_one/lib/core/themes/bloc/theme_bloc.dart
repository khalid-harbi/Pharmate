import 'package:bloc/bloc.dart';
import 'package:capstone_one/core/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  // Start with the light theme as the initial state
  ThemeBloc() : super(ThemeState(themeData: AppThemes.lightTheme)) {
    //! Theme #3
    on<ToggleThemeEvent>((event, emit) {
      // Check the brightness of the current state's themeData
      // state here refers to the state of the base state class only
      if (state.themeData.brightness == Brightness.light) {
        emit(ThemeState(themeData: AppThemes.darkTheme));
      } else {
        emit(ThemeState(themeData: AppThemes.lightTheme));
      }
    });
  }
}
