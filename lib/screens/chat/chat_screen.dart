import 'package:flutter/material.dart';
import '../../core/services/chat_service.dart';

class ChatScreen extends StatefulWidget {
  final int userId;
  final int receiverId;

  const ChatScreen({super.key, required this.userId, required this.receiverId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController = TextEditingController();

  List<String> messages = [];

  @override
  void initState() {
    super.initState();

    ChatService.connect(widget.userId);

    ChatService.channel.stream.listen((data) {
      setState(() {
        messages.add(data.toString());
      });
    });
  }

  void sendMessage() {
    if (messageController.text.isEmpty) return;

    ChatService.sendMessage(widget.receiverId, messageController.text);

    setState(() {
      messages.add("Me:${messageController.text}");
    });
    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chat")),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ListTile(title: Text(messages[index]));
              },
            ),
          ),

          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: messageController,
                  decoration: const InputDecoration(hintText: "Type a message"),
                ),
              ),

              IconButton(icon: const Icon(Icons.send), onPressed: sendMessage),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    ChatService.channel.sink.close();
    messageController.dispose();
    super.dispose();
  }
}
