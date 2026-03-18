import 'package:flutter/material.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {

  String question = "Choose quickly";

  String option1 = "Pizza 🍕";
  String option2 = "Burger 🍔";

  String? selected;

  void selectAnswer(String answer) {
    setState(() {
      selected = answer;
    });

    Future.delayed(const Duration(seconds: 1), () {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Answer saved!")),
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Discover")),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            Text(
              question,
              style: const TextStyle(fontSize: 22),
            ),

            const SizedBox(height: 40),

            ElevatedButton(
              onPressed: () => selectAnswer(option1),
              child: Text(option1),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () => selectAnswer(option2),
              child: Text(option2),
            ),

            const SizedBox(height: 30),

            if (selected != null)
              Text("You chose: $selected"),
          ],
        ),
      ),
    );
  }
}