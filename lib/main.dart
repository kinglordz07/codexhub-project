import 'package:flutter/material.dart';
import 'package:codexhub01/parts/code_editor.dart';
import 'package:codexhub01/parts/collaboration.dart';
import 'package:codexhub01/parts/friendlist.dart';
import 'package:codexhub01/parts/intro_screen.dart';
import 'package:codexhub01/parts/learning_tools.dart';
import 'package:codexhub01/parts/mentorship.dart';
import 'package:codexhub01/parts/profilescreen.dart';

void main() {
  runApp(CodeHubApp());
}

class CodeHubApp extends StatelessWidget {
  const CodeHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CodeXHub Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: IntroScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  final List<Map<String, dynamic>> menuItems = [
    {'title': 'Collaboration', 'icon': Icons.group_work, 'route': CollaborationScreen()},
    {'title': 'Mentorship', 'icon': Icons.support_agent, 'route': MentorshipScreen()},
    {'title': 'Code Editor', 'icon': Icons.code, 'route': CodeEditorScreen()},
    {'title': 'User Profile', 'icon': Icons.account_circle, 'route': ProfileScreen()},
    {'title': 'Friend List', 'icon': Icons.smart_toy_outlined, 'route': FriendList()},
    {'title': 'Learning Tools', 'icon': Icons.book_outlined, 'route': Learningtools()},
  ];

  DashboardScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CodeXHub Dashboard'),
        centerTitle: true,
        elevation: 4,
        backgroundColor: Colors.indigo,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded( // Dashboard GridView section
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                itemCount: menuItems.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  return DashboardTile(
                    title: menuItems[index]['title'],
                    iconData: menuItems[index]['icon'],
                    screen: menuItems[index]['route'],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DashboardTile extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Widget screen;

  const DashboardTile({
    super.key,
    required this.title,
    required this.iconData,
    required this.screen,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(iconData, size: 50, color: Colors.indigo),
              SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}