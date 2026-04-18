// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:vibematch/core/utils/snap_storage.dart';
import 'package:vibematch/screens/snap/story_viewer_screen.dart';

class SnapChatScreen extends StatelessWidget {
  final String username;

  const SnapChatScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    final snaps = SnapStorage.getSnaps();

    return Scaffold(
      appBar: AppBar(title: Text(username)),

      body: Column(
        children: [
          const SizedBox(height: 10),

          /// 👻 STORY BUTTON
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => StoryViewerScreen(
                    snaps: snaps,
                    initialIndex: 0,
                  ),
                ),
              );
            },
            child: const Text("View Snaps 👀"),
          ),

          const SizedBox(height: 20),

          /// 💬 CHAT PLACEHOLDER
          const Text("Chat + replies coming soon 💬"),
        ],
      ),
    );
  }
}