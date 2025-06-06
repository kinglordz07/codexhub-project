import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class CodeEditorScreen extends StatefulWidget {
  const CodeEditorScreen({super.key});

  @override
  State<CodeEditorScreen> createState() => _CodeEditorScreenState();
}

class _CodeEditorScreenState extends State<CodeEditorScreen> {
  String selectedLanguage = 'C#';
  final TextEditingController codeController = TextEditingController();

  final Map<String, String> languageSnippets = {
    'C#': '''using System;
class Program {
    static void Main() {
        Console.WriteLine("Hello, World!");
    }
}''',
    'Python': '''def main():
    print("Hello, World!")

if __name__ == "__main__":
    main()''',
    'VB.NET': '''Module Module1
    Sub Main()
        Console.WriteLine("Hello, World!")
    End Sub
End Module''',
    'Java': '''public class Main {
    public static void main(String[] args) {
        System.out.println("Hello, World!");
    }
}''',
  };

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  Future<void> _saveCodeToFile() async {
  try {
    final directory = await getApplicationDocumentsDirectory(); // Sa halip na external storage // Try external storage
    final file = File('${directory.path}/code_$selectedLanguage.txt');

    await file.writeAsString(codeController.text);
    debugPrint("File saved successfully at ${file.path}");

    if (!mounted) return; // Ensure widget is still active before updating UI
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Code saved at: ${file.path}')),
    );
  } catch (e) {
    debugPrint("Error saving file: $e");
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to save code: $e')),
    );
  }
}

  void _insertSnippet(String language) {
    setState(() {
      codeController.text = languageSnippets[language]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Code Editor'),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Write, save, and run your code!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                const Text('Language: ', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  value: selectedLanguage,
                  items: languageSnippets.keys.map((lang) => DropdownMenuItem(
                        value: lang,
                        child: Text(lang),
                      )).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        selectedLanguage = value;
                      });
                      _insertSnippet(value); // Insert code snippet
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),

            Expanded(
              child: TextField(
                controller: codeController,
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  hintText: 'Type your $selectedLanguage code here...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
                style: const TextStyle(fontFamily: 'monospace', fontSize: 14),
              ),
            ),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Running $selectedLanguage code...')),
                    );
                  },
                  icon: const Icon(Icons.play_arrow),
  label: const Text('Run Code', style: TextStyle(color: Colors.white)),
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.indigo,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  ),
),

                ElevatedButton.icon(
  onPressed: _saveCodeToFile, // Save function
  icon: const Icon(Icons.save),
  label: const Text('Save Code', style: TextStyle(color: Colors.white)),
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.green,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  ),
),

              ],
            ),
          ],
        ),
      ),
    );
  }
}