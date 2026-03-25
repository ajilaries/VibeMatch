import 'package:flutter/material.dart';
import 'package:vibematch/core/utils/token_storage.dart';
import '../../core/services/api_service.dart';
import '../../features/navigation/main_navigation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // 1️⃣ Add controllers for text fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false; // optional: show a loading indicator

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // 2️⃣ Function to handle login

  Future<void> handleLogin() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter email and password")),
      );
      return;
    }
    setState(() {
      isLoading = true;
    });
    try {
      var result = await ApiService.login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      String? token = result["access_token"];

      if (token == null) {
        throw Exception("Login failed. Token not received");
      }

      //save token locally

      await TokenStorage.saveToken(token);

      print("Token saved:$token");

      //navigate to main navigation

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainNavigation()),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Login failed $e")));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: emailController, // attach controller
              decoration: const InputDecoration(labelText: "Email"),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: passwordController, // attach controller
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: isLoading ? null : handleLogin, // call function
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}


///1.TextEditingController which is used to controls the text inside the textfields 
///2.dispose() method which is called when the widget is removed from the widget tree , Used to clean up resources like TexteditionControllers
/// which is used to prevent the memory leaks
///3. Async/ Await which makes HTTP call non-blocking. lets you wait for API responnse before updating UI