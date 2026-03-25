import 'package:flutter/material.dart';

class MatchesScreen extends StatelessWidget {
  const MatchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: CircleAvatar(child: Icon(Icons.person)),
          title: Text("Jimmy"),
          subtitle: Text("You matched with jimmy"),
        ),
        ListTile(
          leading: CircleAvatar(child: Icon(Icons.person)),
          title: Text("Drish"),
          subtitle: Text("You matched with drish"),
        ),
      ],
    );
  }
}
