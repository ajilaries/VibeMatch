import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeProvider =
    StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.light) {
    loadTheme(); // 🔥 load on start
  }

  /// 🔥 Toggle Theme
  void toggleTheme() async {
    final newTheme =
        state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;

    state = newTheme;

    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', newTheme == ThemeMode.dark);
  }

  /// 🔥 Load Theme from storage
  void loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('isDarkMode') ?? false;

    state = isDark ? ThemeMode.dark : ThemeMode.light;
  }
}