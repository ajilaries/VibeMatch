import 'package:flutter/material.dart';
import '../../core/services/api_service.dart';
import '../../core/utils/token_storage.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  List users = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  Future<void> loadUsers() async {
    try {
      String? token = await TokenStorage.getToken();

      if (token == null) return;

      var data = await ApiService.getDiscoverUsers();

      setState(() {
        users = data;
        isLoading = false;
      });
    } catch (e) {
      print("Discover error: $e");

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (users.isEmpty) {
      return const Center(child: Text("No users found"));
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Discover")),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          var user = users[index];

          return Card(
            margin: const EdgeInsets.all(12),
            child: ListTile(
              title: Text(user["username"]??"unknown"),

              subtitle: Text(user["bio"] ?? "No bio yet"),

              trailing: IconButton(
                icon: const Icon(Icons.favorite, color: Colors.red),

                onPressed: () async {
                  try {
                    String? token = await TokenStorage.getToken();

                    if (token == null) return;

                    var result = await ApiService.likeUser(token, user["id"]);
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(result["message"])));
                  } catch (e) {
                    print("like error:$e");
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

///initState() loads the users when screen opens
