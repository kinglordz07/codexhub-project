import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Learningtools extends StatefulWidget {
  const Learningtools({super.key});

  @override
  State<Learningtools> createState() => _LearningtoolsState();
}

class _LearningtoolsState extends State<Learningtools> {
  int _currentQuestionIndex = 0;
  int _score = 0;

  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'Which keyword is used to define a function in Python?',
      'options': ['function', 'def', 'fun', 'define'],
      'answer': 'def',
    },
    {
      'question': 'Which language is known for JVM?',
      'options': ['Java', 'Python', 'VB.NET', 'C#'],
      'answer': 'Java',
    },
    {
      'question': 'sino gumawa ng code?',
      'options': ['arveeh', 'jude', 'grace', 'lahat'],
      'answer': 'arveeh',
    },
    {
      'question': 'sino gumawa ng research?',
      'options': ['arveeh & jude', 'jude & grace', 'grace & arveeh', 'lahat'],
      'answer': 'jude & grace',
    },
  ];

  void _checkAnswer(String selected) {
    if (selected == _questions[_currentQuestionIndex]['answer']) {
      _score++;
    }

    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() => _currentQuestionIndex++);
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Quiz Completed!'),
          content: Text('Your score: $_score / ${_questions.length}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _currentQuestionIndex = 0;
                  _score = 0;
                });
              },
              child: Text('Restart'),
            ),
          ],
        ),
      );
    }
  }

  final Map<String, String> _videoIds = {
    'Java': 'grEKMHGYyns',
    'Python': 'rfscVS0vtbw',
    'C#': 'GhQdlIFylQ8',
    'VB.NET': 'm3g8Ma0Tye0',
  };

  @override
  Widget build(BuildContext context) {
    double progress = (_currentQuestionIndex / _questions.length);

    return Scaffold(
      appBar: AppBar(
        title: Text('Learning Tools'),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Articles:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              _buildArticle('Java', 'Java is a versatile, object-oriented language...'),
              _buildArticle('Python', 'Python is a high-level scripting language...'),
              _buildArticle('C#', 'C# is a modern object-oriented language developed by Microsoft...'),
              _buildArticle('VB.NET', 'VB.NET is a simple, modern language based on BASIC...'),
              SizedBox(height: 20),
              Text('Video Tutorials:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ..._videoIds.entries.map((entry) => _buildVideo(entry.key, entry.value)),
              SizedBox(height: 20),
              Text('Mini Quiz:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              _buildQuizSection(),
              SizedBox(height: 20),
              Text('Progress Tracker:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              LinearProgressIndicator(value: progress),
              SizedBox(height: 5),
              Text('${(progress * 100).round()}% Completed'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildArticle(String title, String content) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(content),
      ),
    );
  }

  Widget _buildVideo(String title, String videoId) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$title Tutorial', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        YoutubePlayer(
          controller: YoutubePlayerController(
            initialVideoId: videoId,
            flags: YoutubePlayerFlags(autoPlay: false, mute: false),
          ),
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.red,
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildQuizSection() {
    final question = _questions[_currentQuestionIndex];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(question['question'], style: TextStyle(fontSize: 16)),
        ...question['options'].map<Widget>((option) {
          return ListTile(
            title: Text(option),
            leading: Radio<String>(
              value: option,
              groupValue: null,
              onChanged: (_) => _checkAnswer(option),
            ),
          );
        }).toList(),
      ],
    );
  }
}
