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
        backgroundColor: Colors.white,

        body: SafeArea(
          child: Column(
            children: [
              /// 🔥 Custom Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Messages",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    PopupMenuButton(
                      icon: const Icon(Icons.more_vert),
                      itemBuilder: (context) => const [
                        PopupMenuItem(child: Text("New Chat")),
                        PopupMenuItem(child: Text("Settings")),
                      ],
                    ),
                  ],
                ),
              ),

              /// 🔥 Styled TabBar
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TabBar(
                  indicator: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  tabs: const [
                    Tab(text: "Matches"),
                    Tab(text: "Chats"),
                    Tab(text: "Requests"),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              /// 🔥 Content
              Expanded(
                child: const Padding(
                  padding: EdgeInsets.only(bottom: 100), // for floating nav
                  child: TabBarView(
                    children: [
                      MatchesScreen(),
                      ChatsScreen(),
                      RequestsScreen(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}