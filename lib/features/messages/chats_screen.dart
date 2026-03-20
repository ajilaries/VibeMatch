import 'package:flutter/material.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [

        ListTile(
          leading: CircleAvatar(child: Icon(Icons.person)),
          title: Text("Sarah"),
          subtitle: Text("Hey how are you?"),
        ),

        ListTile(
          leading: CircleAvatar(child: Icon(Icons.person)),
          title: Text("Mike"),
          subtitle: Text("Let's talk later"),
        ),

      ],
    );
  }
}