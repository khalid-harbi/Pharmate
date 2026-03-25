import 'package:flutter/material.dart';

class AppThemes {
  //* Define colors
  static const Color _paleGreen = Color(0xFFE4FAD9);
  static const Color _teal = Color(0xFF1DA286);
  static const Color _darkBlue = Color(0xFF116484);
  static const Color _lightBlue = Color(0xFFCCE9EA);
  static const Color _iceWhite = Color(0xFFEEF5F9);
  static const Color _deepNavy = Color(0xFF082D3D);

  //! Light Theme
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: _iceWhite,
    primaryColor: _teal,

    //* colorScheme
    colorScheme: const ColorScheme.light(
      primary: _teal,
      secondary: _darkBlue,
      surface: _iceWhite,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: _darkBlue,
    ),

    //* appBar
    appBarTheme: const AppBarTheme(
      backgroundColor: _iceWhite,
      foregroundColor: _darkBlue,
      elevation: 0,
      centerTitle: true,
    ),

    //* floatingActionButton
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: _teal,
      foregroundColor: Colors.white,
    ),

    //* card
    cardTheme: CardThemeData(
      color: Colors.white,
      surfaceTintColor: _lightBlue,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    //* inputDecoration
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: _darkBlue.withAlpha(150)),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _teal, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
    ),

    //* filledButtonTheme
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: _teal,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
  );

  //------------------------------------
  //------------------------------------
  //------------------------------------

  //! Dark Theme
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: _deepNavy,
    primaryColor: _teal,

    //* colorScheme
    colorScheme: const ColorScheme.dark(
      primary: _teal,
      secondary: _paleGreen,
      surface: _deepNavy,
      onPrimary: Colors.white,
      onSecondary: _deepNavy,
      onSurface: _iceWhite,
    ),

    //* appBar
    appBarTheme: const AppBarTheme(
      backgroundColor: _deepNavy,
      foregroundColor: _iceWhite,
      elevation: 0,
      centerTitle: true,
    ),

    //* floatingActionButton
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: _paleGreen,
      foregroundColor: _deepNavy,
    ),

    //* card
    cardTheme: CardThemeData(
      color: _darkBlue,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    //* inputDecoration
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: _darkBlue.withAlpha(150)),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _paleGreen),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _teal),
        borderRadius: BorderRadius.circular(12),
      ),
    ),

    //* filledButtonTheme
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: _paleGreen,
        foregroundColor: _deepNavy,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
  );
}
