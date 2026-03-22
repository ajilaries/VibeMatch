import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Replace with your backend URL
  static const String baseUrl = 'http://10.0.2.2:8000';

  // Login
  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'), // your login endpoint
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Login failed: ${response.body}');
    }
  }

  // Signup
  static Future<Map<String, dynamic>> signup(
    String name,
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/signup'), // your signup endpoint
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'email': email, 'password': password}),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Signup failed: ${response.body}');
    }
  }

  // Example: Get user profile
  static Future<Map<String, dynamic>> getProfile(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/profile'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch profile');
    }
  }

  static Future<Map<String, dynamic>> updateProfile(
    String token,
    String name,
    String bio,
  ) async {
    final response = await http.put(
      Uri.parse('$baseUrl/api/update-profile'),
      headers: {
        'content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({"name": name, "bio": bio}),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("profile update failed");
    }
  }

  // static Future<List<dynamic>> discoverUsers(String token) async {
  //   final response = await http.get(
  //     Uri.parse('$baseUrl/api/discover'),
  //     headers: {'Authorization': 'Bearer$token'},
  //   );
  //   if (response.statusCode == 200) {
  //     return jsonDecode(response.body);
  //   } else {
  //     throw Exception("failed to load users");
  //   }
  // }

static Future<List<dynamic>> getDiscoverUsers() async {

  final response = await http.get(
    Uri.parse("http://127.0.0.1:8000/api/discover")
  );

  return jsonDecode(response.body);
}
  static Future likeUser(String token, int userId) async {

  final response = await http.post(
    Uri.parse('$baseUrl/api/like'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    },
    body: jsonEncode({
      "liked_user_id": userId
    }),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception("Failed to like user");
  }
}
}
