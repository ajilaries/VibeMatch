import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibematch/core/services/api_service.dart';
import 'package:vibematch/core/utils/token_storage.dart';
import 'package:vibematch/screens/snap/select_users_screen.dart';
import 'package:vibematch/core/utils/snap_storage.dart';
import 'package:vibematch/models/snap_model.dart';

class SnapPreviewScreen extends StatelessWidget {
  final File imageFile;

  const SnapPreviewScreen({super.key, required this.imageFile});

  /// 🔥 Get Privacy
  Future<String> getSnapPrivacy() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("snap_privacy") ?? "everyone";
  }

  /// 🔥 Filter Users (fallback)
  Future<List> getFilteredUsers(String privacy) async {
    String? token = await TokenStorage.getToken();
    if (token == null) return [];

    final users = await ApiService.discoverUsers(token);

    if (privacy == "everyone") {
      return users;
    } else if (privacy == "matches") {
      return users.where((user) => user["isMatched"] == true).toList();
    } else {
      return [];
    }
  }

  String getFileType(String path) {
    if (path.endsWith(".mp4") || path.endsWith(".mov")) {
      return "video";
    }
    return "image";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: Stack(
        children: [
          /// 📸 Image Preview
          Center(child: Image.file(imageFile,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,)),

          /// 🔙 Back Button
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          /// 📤 Send Button
          Positioned(
            bottom: 30,
            right: 20,
            child: FloatingActionButton(
              backgroundColor: Colors.pink,
              onPressed: () async {
                /// 👤 Step 1: Select Users
                final selectedUsers = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SelectUsersScreen()),
                );

                List finalUsers = [];

                /// 🔥 If user selected manually → use that
                if (selectedUsers != null && selectedUsers.isNotEmpty) {
                  finalUsers = selectedUsers;
                } else {
                  /// 🔥 Fallback → use privacy setting
                  final privacy = await getSnapPrivacy();
                  finalUsers = await getFilteredUsers(privacy);
                }

                /// ❌ No users
                if (finalUsers.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("No users to send snap 😢")),
                  );
                  return;
                }

                /// 🔥 Simulate sending
                for (var user in finalUsers) {
                  print("Sending snap to: ${user["username"]}");
                }

                /// 👻 SAVE SNAP TO STORIES
                SnapStorage.addSnap(
                  SnapModel(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    imagePath: imageFile.path,
                    username: "You",
                    timestamp: DateTime.now(),
                    type: getFileType(imageFile.path),
                    viewDuration: 5, // 👈 since you added this in model
                  ),
                );
                /// ✅ Success UI
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Snap sent to ${finalUsers.length} users 🚀"),
                  ),
                );

                /// 🔙 Go back after sending
                Navigator.pop(context);
              },
              child: const Icon(Icons.send),
            ),
          ),
        ],
      ),
    );
  }
}
