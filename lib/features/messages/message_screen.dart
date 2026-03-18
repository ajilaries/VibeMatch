import 'package:flutter/material.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Messages"),
      ),

      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {

          return ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.person),
            ),

            title: Text("User $index"),

            subtitle: const Text("Tap to chat"),

            onTap: () {
              Navigator.pushNamed(context, "/chat");
            },
          );
        },
      ),
    );
  }
}