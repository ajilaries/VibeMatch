import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/core/providers/theme_provider.dart';

class CustomAppBar extends ConsumerWidget {
  final String title;
  final bool showMenu;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showMenu = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// 🔥 Title
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          /// 🔥 Menu
          if (showMenu)
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              onSelected: (value) {
                if (value == "toggle") {
                  final isDark = themeState.mode == ThemeMode.dark;

                  ref.read(themeProvider.notifier).setThemeMode(
                        isDark ? ThemeMode.light : ThemeMode.dark,
                      );
                }

                if (value == "pink") {
                  ref.read(themeProvider.notifier)
                      .setTheme(AppThemeType.pink);
                }

                if (value == "blue") {
                  ref.read(themeProvider.notifier)
                      .setTheme(AppThemeType.blue);
                }

                if (value == "purple") {
                  ref.read(themeProvider.notifier)
                      .setTheme(AppThemeType.purple);
                }
              },
              itemBuilder: (context) => const [
                PopupMenuItem(
                  value: "toggle",
                  child: Text("Toggle Dark Mode"),
                ),
                PopupMenuItem(
                  value: "pink",
                  child: Text("Pink Theme"),
                ),
                PopupMenuItem(
                  value: "blue",
                  child: Text("Blue Theme"),
                ),
                PopupMenuItem(
                  value: "purple",
                  child: Text("Purple Theme"),
                ),
              ],
            ),
        ],
      ),
    );
  }
}