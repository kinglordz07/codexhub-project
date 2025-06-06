import 'package:flutter/material.dart';

class FriendList extends StatefulWidget {
  const FriendList({super.key});

  @override
  State<FriendList> createState() => _FriendListState();
}

class _FriendListState extends State<FriendList> {
  final List<Map<String, dynamic>> _allFriends = [
    {'name': 'Alice', 'online': true},
    {'name': 'Bob', 'online': false},
    {'name': 'Charlie', 'online': true},
  ];

  final List<Map<String, dynamic>> _nonFriends = [
    {'name': 'Sophia', 'online': true},
    {'name': 'Michael', 'online': false},
    {'name': 'David', 'online': true},
  ];

  final List<Map<String, dynamic>> _friendRequests = [];

  String _searchQuery = '';

  List<Map<String, dynamic>> get _filteredFriends {
    return _allFriends.where((friend) =>
        friend['name'].toLowerCase().contains(_searchQuery.toLowerCase())).toList();
  }

  List<Map<String, dynamic>> get _filteredNonFriends {
    return _nonFriends.where((user) =>
        user['name'].toLowerCase().contains(_searchQuery.toLowerCase())).toList();
  }

  void _sendFriendRequest(Map<String, dynamic> user) {
    setState(() {
      _friendRequests.add(user);
      _nonFriends.remove(user);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Friend request sent to ${user['name']}!')),
    );
  }

  void _acceptFriendRequest(Map<String, dynamic> request) {
    setState(() {
      _allFriends.add(request);
      _friendRequests.remove(request);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${request['name']} is now your friend!')),
    );
  }

  void _rejectFriendRequest(Map<String, dynamic> request) {
    setState(() {
      _friendRequests.remove(request);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Friend request from ${request['name']} rejected.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Friends & Requests'),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search friends...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
          ),
          
          /// 🔹 Incoming Friend Requests Section
          if (_friendRequests.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Friend Requests', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ..._friendRequests.map((request) => Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue,
                            child: Text(request['name'][0]),
                          ),
                          title: Text(request['name']),
                          subtitle: Text(request['online'] ? 'Online' : 'Offline'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.check, color: Colors.green),
                                tooltip: 'Accept Friend Request',
                                onPressed: () => _acceptFriendRequest(request),
                              ),
                              IconButton(
                                icon: const Icon(Icons.close, color: Colors.red),
                                tooltip: 'Reject Friend Request',
                                onPressed: () => _rejectFriendRequest(request),
                              ),
                            ],
                          ),
                        ),
                      )),
                ],
              ),
            ),

          /// 🔹 Friend List Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Your Friends', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ..._filteredFriends.map((friend) => Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: Text(friend['name'][0]),
                        ),
                        title: Text(friend['name']),
                        subtitle: Text(friend['online'] ? 'Online' : 'Offline'),
                      ),
                    )),
              ],
            ),
          ),

          /// 🔹 Add Friend Section (People You May Know)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('People You May Know', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ..._filteredNonFriends.map((user) => Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: Text(user['name'][0]),
                        ),
                        title: Text(user['name']),
                        subtitle: Text(user['online'] ? 'Online' : 'Offline'),
                        trailing: IconButton(
                          icon: const Icon(Icons.person_add, color: Colors.green),
                          tooltip: 'Send Friend Request',
                          onPressed: () => _sendFriendRequest(user),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}