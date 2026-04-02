import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';
import 'screens/splash/splash_screen.dart';

void main() {
  runApp(const ProviderScope(child: VibeMatchApp()));
}

class VibeMatchApp extends ConsumerWidget {
  const VibeMatchApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      title: "VibeMatch",
      debugShowCheckedModeBanner: false,

      /// 🔥 Light + Dark Theme
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,

      /// 🔥 Controlled by Riverpod
      themeMode: themeMode,

      home: const SplashScreen(),
    );
  }
}