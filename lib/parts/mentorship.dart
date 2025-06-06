import 'package:flutter/material.dart';

class MentorshipScreen extends StatefulWidget {
  const MentorshipScreen({super.key});

  @override
  State<MentorshipScreen> createState() => _MentorshipScreenState();
}

class _MentorshipScreenState extends State<MentorshipScreen> {
  final List<Map<String, String>> _mentors = [
    {'name': 'Jane Doe', 'expertise': 'Java, VB.NET, Python'},
    {'name': 'John Smith', 'expertise': 'Python, C#'},
    {'name': 'Emily Johnson', 'expertise': 'VB.NET, Java'},
    {'name': 'Michael Brown', 'expertise': 'Java, C#'},
    {'name': 'Sophia Lee', 'expertise': 'C#, Python'},
  ];

  String _searchQuery = '';

  List<Map<String, String>> get _filteredMentors {
    return _mentors.where((mentor) {
      final nameLower = mentor['name']!.toLowerCase();
      final expertiseLower = mentor['expertise']!.toLowerCase();
      final queryLower = _searchQuery.toLowerCase();
      return nameLower.contains(queryLower) || expertiseLower.contains(queryLower);
    }).toList();
  }

  void _openChat(BuildContext context, String mentorName) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChatScreen(mentorName: mentorName)),
    );
  }

  void _startVideoCall(BuildContext context, String mentorName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Video call feature with $mentorName coming soon!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mentorship'), backgroundColor: Colors.indigo),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search mentors...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _filteredMentors.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final mentor = _filteredMentors[index];
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.indigo,
                            child: Text(mentor['name']![0]),
                          ),
                          title: Text(
                            mentor['name']!,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            mentor['expertise']!,
                            style: const TextStyle(color: Colors.grey),
                            softWrap: true,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () => _openChat(context, mentor['name']!),
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                              child: const Text("Chat", style: TextStyle(color: Colors.white),),
                            ),
                            ElevatedButton(
                              onPressed: () => _startVideoCall(context, mentor['name']!),
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                              child: const Text('Video Call',style: TextStyle(color: Colors.white),),
                            ),
                            ElevatedButton(
                              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Mentorship request sent to ${mentor['name']}!')),
                              ),
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
                              child: const Text('Request',style: TextStyle(color: Colors.white),),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// 🔥 **Merged Chat Feature for Direct Mentor-Mentee Conversations**
class ChatScreen extends StatefulWidget {
  final String mentorName;
  const ChatScreen({super.key, required this.mentorName});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String, String>> _messages = [];
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _messages.add({"sender": "You", "message": _controller.text});
      });
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat with ${widget.mentorName}"),
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            icon: const Icon(Icons.video_call),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Video call feature coming soon!")),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isMe = message["sender"] == "You";
                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: isMe ? Colors.blueAccent : Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      message["message"]!,
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Type a message...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _sendMessage,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
                  child: const Text("Send",style: TextStyle(color: Colors.white),),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}