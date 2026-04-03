import 'package:flutter/material.dart';
import 'package:vibematch/core/services/api_service.dart';
import 'package:vibematch/core/utils/token_storage.dart';

class SelectUsersScreen extends StatefulWidget {
  const SelectUsersScreen({super.key});

  @override
  State<SelectUsersScreen> createState() => _SelectUsersScreenState();
}

class _SelectUsersScreenState extends State<SelectUsersScreen> {
  List users = [];
  List selectedUsers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  Future<void> loadUsers() async {
    String? token = await TokenStorage.getToken();
    if (token == null) return;

    final data = await ApiService.discoverUsers(token);

    setState(() {
      users = data;
      isLoading = false;
    });
  }

  void toggleSelection(user) {
    setState(() {
      if (selectedUsers.contains(user)) {
        selectedUsers.remove(user);
      } else {
        selectedUsers.add(user);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Users"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, selectedUsers);
            },
            child: const Text("Send"),
          ),
        ],
      ),

      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          final isSelected = selectedUsers.contains(user);

          return ListTile(
            title: Text(user["username"] ?? "unknown"),

            trailing: Icon(
              isSelected ? Icons.check_circle : Icons.circle_outlined,
              color: isSelected ? Colors.green : null,
            ),

            onTap: () => toggleSelection(user),
          );
        },
      ),
    );
  }
}