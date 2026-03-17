import 'package:flutter/material.dart';

class VibeGame extends StatelessWidget {
  const VibeGame({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Vibe Game")),
      body: const Center(
        child: Text("First impression game", style: TextStyle(fontSize: 22)),
      ),
    );
  }
}
