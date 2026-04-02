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
      backgroundColor: Colors.white,

      body: Stack(
        children: [
          //keeps state of all screens
          IndexedStack(index: currentIndex, children: screens),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: _buildFloatingNavBar(),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingNavBar() {
    return Container(
      height: 65,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 12,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(Icons.home, 0),
          _navItem(Icons.explore, 1),
          _navItem(Icons.chat, 2),
          _navItem(Icons.person, 3),
          _navItem(Icons.settings, 4),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, int index) {
    final isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () => onTabTapped(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.pink : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}
