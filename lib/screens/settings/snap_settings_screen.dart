import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SnapSettingsScreen extends StatefulWidget {
  const SnapSettingsScreen({super.key});

  @override
  State<SnapSettingsScreen> createState() => _SnapSettingsScreenState();
}

class _SnapSettingsScreenState extends State<SnapSettingsScreen> {
  String selectedOption = "everyone";

  @override
  void initState() {
    super.initState();
    loadPreference();
  }

  /// 🔥 Load saved option
  Future<void> loadPreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedOption = prefs.getString("snap_privacy") ?? "everyone";
    });
  }

  /// 🔥 Save option
  Future<void> savePreference(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("snap_privacy", value);

    setState(() {
      selectedOption = value;
    });
  }

  Widget buildOption(String title, String value) {
    return RadioListTile(
      value: value,
      groupValue: selectedOption,
      onChanged: (val) {
        savePreference(val.toString());
      },
      title: Text(title),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Snap Privacy")),

      body: Column(
        children: [
          buildOption("Everyone 🌍", "everyone"),
          buildOption("Matches 💘", "matches"),
          buildOption("Only Me 🔒", "private"),
        ],
      ),
    );
  }
}