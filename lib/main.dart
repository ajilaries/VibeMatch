import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'core/providers/theme_provider.dart';
import 'screens/splash/splash_screen.dart';

void main() {
  runApp(const ProviderScope(child: VibeMatchApp()));
}

class VibeMatchApp extends ConsumerWidget {
  const VibeMatchApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);

    return MaterialApp(
      title: "Vibematch",
      debugShowCheckedModeBanner: false,

      //dynamic theme based on selected color
      theme: AppTheme.getLightTheme(themeState.themeType),
      darkTheme: AppTheme.getDarkTheme(themeState.themeType),

      themeMode: themeState.mode,

      home: const SplashScreen(),
    );
  }
}
