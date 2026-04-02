import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/theme/theme_provider.dart';

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
                if (value == "dark") {
                  ref.read(themeProvider.notifier).toggleTheme();
                }
              },
              itemBuilder: (context) => const [
                PopupMenuItem(
                  value: "dark",
                  child: Text("Toggle Dark Mode"),
                ),
                PopupMenuItem(
                  value: "saved",
                  child: Text("Saved"),
                ),
              ],
            ),
        ],
      ),
    );
  }
}