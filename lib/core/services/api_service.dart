import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  // Replace with your backend URL
  static const String baseUrl = 'http://10.0.0.0:8000';

  // Login
  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse("$baseUrl/api/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    final data = jsonDecode(response.body);
    print("LOGIN RESPONSE: $data");

    if (response.statusCode == 200) {
      return data;
    } else {
      throw Exception(data["detail"] ?? "Login failed");
    }
  }

  // Signup
  static Future<Map<String, dynamic>> signup(
    String username,
    String email,
    String password,
    String dob,
  ) async {
    final response = await http.post(
      Uri.parse("$baseUrl/api/signup"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "username": username,
        "email": email,
        "password": password,
        "dob": dob,
      }),
    );
    return jsonDecode(response.body);
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

  static Future<List<dynamic>> discoverUsers(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/discover'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load users");
    }
  }

  static Future likeUser(String token, int userId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/like'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({"liked_user_id": userId}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to like user");
    }
  }

  static Future<void> uploadProfileMedia(
    String token,
    File file,
    String type,
  ) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/profile/upload'),
    );

    request.headers['Authorization'] = 'Bearer$token';
    request.fields['type'] = type;

    request.files.add(await http.MultipartFile.fromPath('file', file.path));
    var response = await request.send();

    if (response.statusCode != 200) {
      throw Exception("Upload failed");
    }
  }
  static Future<void> removeProfileMedia(String token) async {
  final response = await http.delete(
    Uri.parse('$baseUrl/profile/media'),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode != 200) {
    throw Exception("Remove failed");
  }
}
}
