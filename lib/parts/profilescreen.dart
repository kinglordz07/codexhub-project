import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:codexhub01/parts/log_in.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isDarkMode = false;
  bool notificationsEnabled = true;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('isDarkMode') ?? false;
      notificationsEnabled = prefs.getBool('notificationsEnabled') ?? true;
    });
  }

  Future<void> _toggleDarkMode(bool value) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isDarkMode', value);

  if (!mounted) return; // Ensure widget is still active
  setState(() => isDarkMode = value);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(value ? "Dark Mode Enabled" : "Dark Mode Disabled")),
  );
}

Future<void> _toggleNotifications(bool value) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('notificationsEnabled', value);

  if (!mounted) return; // Ensure widget is still active
  setState(() => notificationsEnabled = value);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(value ? "Notifications Enabled" : "Notifications Disabled")),
  );
}

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text("Confirm Logout"),
          content: const Text("Are you sure you want to log out?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                _logout(context);
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  void _logout(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SignIn()),
    );
  }

  void _editProfile() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Edit Profile feature coming soon!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String userName = "John Doe";
    final String email = "johndoe@example.com";
    final String profileImageUrl = "https://i.pravatar.cc/150?img=3";

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings & Profile'),
        backgroundColor: Colors.indigo,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(profileImageUrl),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(userName, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  Text(email, style: const TextStyle(fontSize: 16, color: Colors.grey)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.dark_mode),
            title: const Text("Dark Mode"),
            trailing: Switch(value: isDarkMode, onChanged: _toggleDarkMode),
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text("Notifications"),
            trailing: Switch(value: notificationsEnabled, onChanged: _toggleNotifications),
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text("Edit Profile"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: _editProfile,
          ),
          const Divider(),
         ElevatedButton.icon(
  onPressed: () => _confirmLogout(context),
  icon: const Icon(Icons.logout),
  label: const Text("Log Out", style: TextStyle(color: Color.fromARGB(255, 246, 244, 247))),
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color.fromARGB(255, 96, 47, 145),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
  ),
),

        ],
      ),
    );
  }
}