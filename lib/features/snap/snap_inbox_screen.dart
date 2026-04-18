import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SnapInboxScreen extends StatefulWidget {
  const SnapInboxScreen({super.key});

  @override
  State<SnapInboxScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<SnapInboxScreen> {
  List<File> posts = [];

  /// 📸 PICK IMAGE
  Future<void> pickPost() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    setState(() {
      posts.add(File(image.path));
    });
  }

  /// 👀 OPEN FULL POST
  void openPost(File image) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(backgroundColor: Colors.black),
          body: Center(
            child: Image.file(image),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Posts"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: pickPost,
          ),
        ],
      ),

      body: posts.isEmpty
          ? const Center(
              child: Text(
                "No posts yet 😢\nTap + to add",
                textAlign: TextAlign.center,
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];

                return GestureDetector(
                  onTap: () => openPost(post),
                  child: Image.file(
                    post,
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
    );
  }
}