import 'package:flutter/material.dart';

class MenteeMessagingScreen extends StatefulWidget {
  const MenteeMessagingScreen({super.key});

  @override
  MenteeMessagingScreenState createState() => MenteeMessagingScreenState();
}

class MenteeMessagingScreenState extends State<MenteeMessagingScreen> {
  final List<Map<String, dynamic>> messages = [
    {'sender': 'Juan', 'message': 'Sir, paano po ito?', 'time': '10:30 AM', 'isMentor': false},
    {'sender': 'Mentor', 'message': 'I-check mo ang syntax mo.', 'time': '10:32 AM', 'isMentor': true},
  ];
  final TextEditingController messageController = TextEditingController();

  void _sendMessage() {
    if (messageController.text.isNotEmpty) {
      setState(() {
        messages.add({
          'sender': 'Mentor',
          'message': messageController.text,
          'time': TimeOfDay.now().format(context),
          'isMentor': true,
        });
        messageController.clear();
      });
    }
  }

  void _startVideoCall() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => VideoCallScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mentee Messaging'),
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: _startVideoCall,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                bool isMentor = messages[index]['isMentor'];
                return Align(
                  alignment: isMentor ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isMentor ? Colors.indigo[300] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(messages[index]['message'], style: TextStyle(fontSize: 16, color: isMentor ? Colors.white : Colors.black)),
                        SizedBox(height: 5),
                        Text(messages[index]['time'], style: TextStyle(fontSize: 12, color: Colors.black54)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _sendMessage,
                  style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 243, 244, 247)),
                  child: Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class VideoCallScreen extends StatelessWidget {
  const VideoCallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Video Call'), backgroundColor: Colors.indigo),
      body: Center(
        child: Text("Video Call Interface Here", style: TextStyle(fontSize: 18)),
      ),
    );
  }
}