import 'package:flutter/material.dart';
import '/core/providers/theme_provider.dart';

class AppTheme {
  /// 🌞 Light Theme
  static ThemeData getLightTheme(AppThemeType type) {
    Color primaryColor;

    switch (type) {
      case AppThemeType.blue:
        primaryColor = Colors.blue;
        break;
      case AppThemeType.purple:
        primaryColor = Colors.purple;
        break;
      default:
        primaryColor = Colors.pink;
    }

    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,

      colorScheme: ColorScheme.light(
        primary: primaryColor,
      ),

      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  /// 🌙 Dark Theme
  static ThemeData getDarkTheme(AppThemeType type) {
    Color primaryColor;

    switch (type) {
      case AppThemeType.blue:
        primaryColor = Colors.blue;
        break;
      case AppThemeType.purple:
        primaryColor = Colors.purple;
        break;
      default:
        primaryColor = Colors.pink;
    }

    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.black,

      colorScheme: ColorScheme.dark(
        primary: primaryColor,
      ),

      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}