import 'package:flutter/material.dart';
import 'package:vibematch/widgets/custom_appbar.dart'; // 👈 import this

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<Map<String, String>> matches = const [
    {"name": "Emma", "message": "Hey 👋"},
    {"name": "Liam", "message": "Let’s play the vibe game"},
    {"name": "Sophia", "message": "How are you?"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Column(
          children: [
            /// 🔥 Global AppBar
            const CustomAppBar(title: "VibeMatch"),

            /// 🔥 Your existing list
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 100), // 👈 important
                itemCount: matches.length,
                itemBuilder: (context, index) {
                  final user = matches[index];

                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      leading: const CircleAvatar(
                        radius: 24,
                        child: Icon(Icons.person),
                      ),
                      title: Text(user["name"]!),
                      subtitle: Text(user["message"]!),
                      trailing: const Icon(Icons.favorite, color: Colors.red),
                      onTap: () {
                        Navigator.pushNamed(context, "/chat");
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}