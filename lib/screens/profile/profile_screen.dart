import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("My Profile")),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            const CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 50),
            ),

            const SizedBox(height: 20),

            TextField(
              decoration: const InputDecoration(
                labelText: "Name",
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              decoration: const InputDecoration(
                labelText: "Bio",
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {},
              child: const Text("Save Profile"),
            )
          ],
        ),
      ),
    );
  }
}