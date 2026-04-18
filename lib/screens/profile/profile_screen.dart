import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/services/api_service.dart';
import '../../core/utils/token_storage.dart';
import '../../screens/profile/edit_profile_screen.dart';
import 'package:vibematch/core/utils/snap_storage.dart';
import 'package:vibematch/screens/snap/story_viewer_screen.dart';
import 'package:vibematch/features/snap/snap_preview_screen.dart';
import 'package:vibematch/features/post/post_screen.dart';
import 'package:vibematch/features/snap/snap_inbox_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? userData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    try {
      String? token = await TokenStorage.getToken();
      if (token == null) throw Exception("No Token");

      var profile = await ApiService.getProfile(token);

      setState(() {
        userData = profile;
        isLoading = false;
      });
    } catch (e) {
      debugPrint("Profile Error: $e");
      setState(() => isLoading = false);
    }
  }

  /// 📸 SNAP PICKER
  Future<void> pickSnap() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SnapPreviewScreen(imageFile: File(image.path)),
      ),
    );
  }

  /// 🚀 NAVIGATION
  void openPostsScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const PostScreen()),
    );
  }

  void openSnapScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SnapInboxScreen()),
    );
  }

  /// 👻 STORY ROW
  Widget buildMyStorySection() {
    final snaps = SnapStorage.getSnaps();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("My Story",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

        const SizedBox(height: 10),

        Row(
          children: [
            /// ➕ ADD SNAP
            GestureDetector(
              onTap: pickSnap,
              child: Column(
                children: [
                  Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.pink, width: 3),
                    ),
                    child: const Icon(Icons.add),
                  ),
                  const SizedBox(height: 5),
                  const Text("Add"),
                ],
              ),
            ),

            const SizedBox(width: 15),

            /// 👻 SNAP LIST
            Expanded(
              child: SizedBox(
                height: 90,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snaps.length,
                  itemBuilder: (context, index) {
                    final snap = snaps[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => StoryViewerScreen(
                              snaps: snaps,
                              initialIndex: index,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: FileImage(File(snap.imagePath)),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// 🔘 ACTION BUTTONS (Posts + Snaps)
  Widget buildActionSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        /// 🖼 POSTS
        GestureDetector(
          onTap: openPostsScreen,
          child: Column(
            children: const [
              Icon(Icons.grid_on, size: 28),
              SizedBox(height: 5),
              Text("Posts"),
            ],
          ),
        ),

        /// 👻 SNAPS
        GestureDetector(
          onTap: openSnapScreen,
          child: Column(
            children: const [
              Icon(Icons.flash_on, size: 28),
              SizedBox(height: 5),
              Text("Snaps"),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : userData == null
              ? const Center(child: Text("Failed to load profile"))
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),

                      /// 👤 PROFILE IMAGE
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey[300],
                        backgroundImage:
                            userData!["profile_type"] == "image" &&
                                    userData!["profile_url"] != null
                                ? NetworkImage(userData!["profile_url"])
                                : null,
                        child: userData!["profile_url"] == null
                            ? const Icon(Icons.person, size: 50)
                            : null,
                      ),

                      const SizedBox(height: 10),

                      /// 👤 NAME
                      Text(
                        userData!["name"] ?? "No Name",
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),

                      /// 📝 BIO
                      if (userData!["bio"] != null &&
                          userData!["bio"] != "")
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            userData!["bio"],
                            textAlign: TextAlign.center,
                          ),
                        ),

                      /// ✏️ EDIT BUTTON
                      ElevatedButton(
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  EditProfileScreen(userData: userData!),
                            ),
                          );
                          loadProfile();
                        },
                        child: const Text("Edit profile"),
                      ),

                      const SizedBox(height: 20),

                      /// 👻 STORY ROW
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: buildMyStorySection(),
                      ),

                      const SizedBox(height: 25),

                      /// 🔘 ACTION SECTION
                      buildActionSection(),

                      const SizedBox(height: 30),
                    ],
                  ),
                ),
    );
  }
}