import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/core/theme/theme_state.dart';

/// 🎨 Enum instead of string (safer)
enum AppThemeType {
  pink,
  blue,
  purple,
}

/// 🔥 Provider
final themeProvider =
    StateNotifierProvider<ThemeNotifier, ThemeState>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<ThemeState> {
  ThemeNotifier()
      : super(
          ThemeState(
            mode: ThemeMode.system,
            themeType: AppThemeType.pink,
          ),
        ) {
    loadTheme();
  }

  /// 🌗 Change Light / Dark / System
  Future<void> setThemeMode(ThemeMode mode) async {
    state = state.copyWith(mode: mode);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeMode', mode.name);
  }

  /// 🎨 Change Color Theme
  Future<void> setTheme(AppThemeType type) async {
    state = state.copyWith(themeType: type);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeColor', type.name);
  }

  /// 💾 Load saved theme
  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();

    final modeString = prefs.getString('themeMode');
    final themeString = prefs.getString('themeColor');

    ThemeMode mode = ThemeMode.system;
    AppThemeType type = AppThemeType.pink;

    if (modeString != null) {
      mode = ThemeMode.values.firstWhere(
        (e) => e.name == modeString,
        orElse: () => ThemeMode.system,
      );
    }

    if (themeString != null) {
      type = AppThemeType.values.firstWhere(
        (e) => e.name == themeString,
        orElse: () => AppThemeType.pink,
      );
    }

    state = ThemeState(
      mode: mode,
      themeType: type,
    );
  }
}