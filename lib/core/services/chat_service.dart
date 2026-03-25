import 'package:web_socket_channel/web_socket_channel.dart';

class ChatService {
  static late WebSocketChannel channel;

  static void connect(int userId) {
    channel = WebSocketChannel.connect(
      Uri.parse("ws://127.0.0.1:8000/ws/$userId"),
    );
  }

  static void sendMessage(int receiverId, String message) {
    channel.sink.add("$receiverId | $message");
  }
}
