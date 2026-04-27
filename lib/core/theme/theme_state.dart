import 'package:flutter/material.dart';
import '/core/providers/theme_provider.dart';

class ThemeState {
  final ThemeMode mode;
  final AppThemeType themeType;

  const ThemeState({
    required this.mode,
    required this.themeType,
  });

  ThemeState copyWith({
    ThemeMode? mode,
    AppThemeType? themeType,
  }) {
    return ThemeState(
      mode: mode ?? this.mode,
      themeType: themeType ?? this.themeType,
    );
  }

  /// 🧠 Optional (helps debugging/logging)
  @override
  String toString() {
    return 'ThemeState(mode: $mode, themeType: $themeType)';
  }

  /// ⚡ Optional (good for comparisons)
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ThemeState &&
        other.mode == mode &&
        other.themeType == themeType;
  }

  @override
  int get hashCode => mode.hashCode ^ themeType.hashCode;
}