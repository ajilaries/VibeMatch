import 'package:flutter/material.dart';
import 'matches_screen.dart';
import 'chats_screen.dart';
import 'requests_screen.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Messages"),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Matches"),
              Tab(text: "Chats"),
              Tab(text: "Requests"),
            ],
          ),
        ),

        body: const TabBarView(
          children: [MatchesScreen(), ChatsScreen(), RequestsScreen()],
        ),
      ),
    );
  }
}
