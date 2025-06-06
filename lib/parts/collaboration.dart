import 'package:flutter/material.dart';

class CollaborationScreen extends StatefulWidget {
  const CollaborationScreen({super.key});

  @override
  State<CollaborationScreen> createState() => _CollaborationScreenState();
}

class _CollaborationScreenState extends State<CollaborationScreen> {
  final List<Map<String, String>> _collaborators = [
    {'name': 'Alice Johnson', 'status': 'Online'},
    {'name': 'Brian Lee', 'status': 'Offline'},
    {'name': 'Cara Smith', 'status': 'Online'},
    {'name': 'David Kim', 'status': 'Busy'},
  ];

  final List<Map<String, String>> _collaborationRequests = [
    {'name': 'Sophia Lee'},
    {'name': 'Michael Scott'},
  ];

  final List<Map<String, String>> _availableCollaborations = [
    {'group': 'AI Developers Hub', 'members': '5 members'},
    {'group': 'Flutter Coders', 'members': '8 members'},
    {'group': 'Python Enthusiasts', 'members': '4 members'},
  ];

  final List<String> _chatMessages = [];
  final TextEditingController _messageController = TextEditingController();
  bool isInCollaboration = false;

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        _chatMessages.add("You: ${_messageController.text}");
      });
      _messageController.clear();
    }
  }

  void _startCollaboration() {
    setState(() {
      isInCollaboration = true;
      _chatMessages.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('You have started a collaboration session!'),
      ),
    );
  }

  void _leaveCollaboration() {
    setState(() {
      isInCollaboration = false;
      _chatMessages.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('You left the collaboration. Find a new group!'),
      ),
    );
  }

  // ignore: unused_element
  void _acceptRequest(Map<String, String> request) {
    setState(() {
      _collaborators.add({'name': request['name']!, 'status': 'Online'});
      _collaborationRequests.remove(request);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${request['name']} joined the collaboration!')),
    );
  }

  // ignore: unused_element
  void _rejectRequest(Map<String, String> request) {
    setState(() {
      _collaborationRequests.remove(request);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Collaboration request from ${request['name']} rejected.',
        ),
      ),
    );
  }

  void _joinNewCollaboration(Map<String, String> group) {
    setState(() {
      isInCollaboration = true;
      _chatMessages.clear();
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Joined ${group['group']}!')));
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Collaboration'),
        backgroundColor: Colors.indigo,
        automaticallyImplyLeading: !isInCollaboration,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child:
                isInCollaboration
                    ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                       ElevatedButton.icon(
  onPressed: _leaveCollaboration,
  icon: const Icon(Icons.exit_to_app),
  label: const Text('Leave Collaboration', style: TextStyle(color: Colors.white)),
  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
),

                      ],
                    )
                    : ElevatedButton.icon(
  onPressed: _startCollaboration,
  icon: const Icon(Icons.add),
  label: const Text('Start Collaboration', style: TextStyle(color: Colors.white)),
  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
),

          ),

          if (!isInCollaboration) ...[
            const Text(
              'Available Groups',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _availableCollaborations.length,
                itemBuilder: (context, index) {
                  final group = _availableCollaborations[index];
                  return Card(
                    child: ListTile(
                      title: Text(group['group']!),
                      subtitle: Text(group['members']!),
                      trailing: ElevatedButton(
                        onPressed: () => _joinNewCollaboration(group),
                        child: const Text("Join"),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],

          if (isInCollaboration) ...[
            const Text(
              'Collaboration Chat',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _chatMessages.length,
                itemBuilder:
                    (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        _chatMessages[index],
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        hintText: "Type a message...",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _sendMessage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      
                    ),
                    child: const Text("Send", style: TextStyle(color: Color.fromARGB(228, 248, 246, 246)),),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
