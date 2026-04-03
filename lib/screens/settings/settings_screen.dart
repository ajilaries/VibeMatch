import 'package:flutter/material.dart';
import 'package:vibematch/screens/settings/snap_settings_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),

      body: ListView(
        children: [
          const ListTile(
            leading: Icon(Icons.notifications),
            title: Text("Notifications"),
          ),

          const ListTile(
            leading: Icon(Icons.lock),
            title: Text("Privacy"),
          ),

          /// 👻 Snap Privacy (NEW FEATURE)
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text("Snap Privacy"),
            subtitle: const Text("Control who can see your snaps"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SnapSettingsScreen(),
                ),
              );
            },
          ),

          const ListTile(
            leading: Icon(Icons.help),
            title: Text("Help & Support"),
          ),

          const ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
          ),
        ],
      ),
    );
  }
}