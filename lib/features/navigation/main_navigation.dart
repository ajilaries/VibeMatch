import 'package:flutter/material.dart';
import 'package:vibematch/features/messages/message_screen.dart';
import '/screens/home/home_screen.dart';
import '/screens/home/discover_screen.dart';
import '/screens/profile/profile_screen.dart';
import '/screens/settings/settings_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int currentIndex = 0;
  final List<Widget> screens = [
    HomeScreen(),
    DiscoverScreen(),
    MessageScreen(),
    ProfileScreen(),
    SettingsScreen(),
  ];

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: currentIndex, children: screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTabTapped,
        type: BottomNavigationBarType.fixed,

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: "Discover"),
          BottomNavigationBarItem(icon: Icon(Icons.chat),label:"Chat" ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "profile"),
          BottomNavigationBarItem(icon: Icon(Icons.settings),label: "Settings",
          ),
        ],
      ),
    );
  }
}
