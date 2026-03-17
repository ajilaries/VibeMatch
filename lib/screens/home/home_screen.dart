import 'package:flutter/material.dart';
import '../chat/chat_screen.dart';
import '../game/vibe_game.dart';
import '../profile/profile_screen.dart';
import 'discover_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int currentIndex = 0;

  final List<Widget> screens = const [
    DiscoverScreen(),
    VibeGame(),
    ChatScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: screens[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        type: BottomNavigationBarType.fixed,

        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: "Discover",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.videogame_asset),
            label: "Game",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: "Chat",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),

        ],
      ),
    );
  }
}