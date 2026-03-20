import 'package:flutter/material.dart';
import '../../core/services/api_service.dart';
import '../../core/utils/token_storage.dart';

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
  void dispose(){
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

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (userData == null) {
      return const Center(child: Text("Failed to load profile"));
    }
    return Scaffold(
      appBar: AppBar(title: const Text("profile")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [

    const SizedBox(height: 20),

    TextField(
      controller: nameController,
      decoration: const InputDecoration(
        labelText: "Name",
      ),
    ),

    const SizedBox(height: 15),

    Text(
      "Email: ${userData!["email"]}",
      style: const TextStyle(fontSize: 18),
    ),

    const SizedBox(height: 15),

    TextField(
      controller: bioController,
      decoration: const InputDecoration(
        labelText: "Bio",
      ),
    ),

    const SizedBox(height: 30),

    ElevatedButton(
      onPressed: updateProfile,
      child: const Text("Update Profile"),
    ),

    ],
  )
      ),
    );
  }
}
