import 'package:flutter/material.dart';

class RequestsScreen extends StatelessWidget {
  const RequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [

        ListTile(
          leading: const CircleAvatar(child: Icon(Icons.person)),
          title: const Text("David"),
          subtitle: const Text("Sent you a request"),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [

              IconButton(
                icon: const Icon(Icons.check, color: Colors.green),
                onPressed: () {},
              ),

              IconButton(
                icon: const Icon(Icons.close, color: Colors.red),
                onPressed: () {},
              ),

            ],
          ),
        ),

      ],
    );
  }
}