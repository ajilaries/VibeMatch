import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/services/api_service.dart';
import '../../core/utils/token_storage.dart';
import '../../screens/profile/edit_profile_screen.dart';
import 'package:vibematch/core/utils/snap_storage.dart';
import 'package:vibematch/screens/snap/story_viewer_screen.dart';
import 'package:vibematch/features/snap/snap_preview_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  Map<String, dynamic>? userData;
  bool isLoading = true;

  @override
  void dispose() {
    nameController.dispose();
    bioController.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    try {
      String? token = await TokenStorage.getToken();

      if (token == null) {
        throw Exception("No Token found");
      }
      var profile = await ApiService.getProfile(token);

      setState(() {
        userData = profile;
        nameController.text = profile['name'];
        bioController.text = profile['bio'];
        isLoading = false;
      });
    } catch (e) {
      print('Profile Error:$e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> updateProfile() async {
    try {
      String? token = await TokenStorage.getToken();

      if (token == null) return;
      await ApiService.updateProfile(
        token,
        nameController.text,
        bioController.text,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile updated sucessfully")),
      );
    } catch (e) {
      print("update error:$e");
    }
  }

  void showProfileOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.image),
              title: Text("Upload photo"),
              onTap: () {
                Navigator.pop(context);
                pickImage();
              },
            ),
            ListTile(
              leading: Icon(Icons.videocam),
              title: Text("Upload video"),
              onTap: () {
                Navigator.pop(context);
                pickVideo();
              },
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text("Remove"),
              onTap: () {
                Navigator.pop(context);
                removeProfileMedia();
              },
            ),
          ],
        );
      },
    );
  }

  void showProfileOtions() {}
  void pickImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    String? token = await TokenStorage.getToken();
    if (token == null) return;

    await ApiService.uploadProfileMedia(token, File(image.path), "image");
    loadProfile();
  }

  void pickVideo() async {
    //use image picker(video mode)
    final picker = ImagePicker();
    final XFile? video = await picker.pickVideo(source: ImageSource.gallery);

    if (video == null) return;
    String? token = await TokenStorage.getToken();
    if (token == null) return;

    await ApiService.uploadProfileMedia(token, File(video.path), "video");
    loadProfile();
  }

  void removeProfileMedia() async {
    //call api to remove
    String? token = await TokenStorage.getToken();
    if (token == null) return;

    await ApiService.removeProfileMedia(token);

    loadProfile();
  }

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

Widget buildMyStorySection() {
  final snaps = SnapStorage.getSnaps();

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        "My Story",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),

      const SizedBox(height: 10),

      Row(
        children: [
          /// ➕ Add Snap
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

          /// 👻 Snap List
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
                        backgroundImage:
                            FileImage(File(snap.imagePath)),
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
  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (userData == null) {
      return const Center(child: Text("Failed to load profile"));
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            Center(
              child: GestureDetector(
                onTap: () {
                  // 👇 If video → open player, else show options
                  if (userData!["profile_type"] == "video") {
                    // TODO: open video player screen
                  } else {
                    showProfileOptions();
                  }
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
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
                          : userData!["profile_type"] == "video"
                          ? const Icon(Icons.videocam, size: 40)
                          : null,
                    ),

                    // ▶ overlay for video
                    if (userData!["profile_type"] == "video")
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.black54,
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            //name
            Text(
              userData!["name"] ?? "No Name",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            //bio
            if (userData!["bio"] != null && userData!["bio"] != "")
              Text(
                userData!["bio"],
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            const SizedBox(height: 30),

            //editbutton
            ElevatedButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        EditProfileScreen(userData: userData!),
                  ),
                );

                loadProfile();
              },
              child: const Text("Edit profile"),
            ),
          ],
        ),
      ),
    );
  }
}
