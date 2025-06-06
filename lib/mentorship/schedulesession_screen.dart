import 'package:flutter/material.dart';

class ScheduleSessionScreen extends StatefulWidget {
  const ScheduleSessionScreen({super.key});

  @override
  ScheduleSessionScreenState createState() => ScheduleSessionScreenState();
}

class ScheduleSessionScreenState extends State<ScheduleSessionScreen> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String selectedSessionType = 'One-on-One Mentorship';
  final List<String> sessionTypes = ['One-on-One Mentorship', 'Group Session', 'Live Code Review'];
  final TextEditingController notesController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() => selectedDate = pickedDate);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() => selectedTime = pickedTime);
    }
  }

  void _scheduleSession() {
    String scheduledDetails =
        "Session Type: $selectedSessionType\nDate: ${selectedDate.toLocal().toString().split(' ')[0]}\nTime: ${selectedTime.format(context)}\nNotes: ${notesController.text}";

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Session Scheduled!\n$scheduledDetails")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Schedule Mentorship Session'), backgroundColor: Colors.indigo),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Session Type Dropdown
            DropdownButtonFormField<String>(
              value: selectedSessionType,
              items: sessionTypes.map((type) {
                return DropdownMenuItem(value: type, child: Text(type));
              }).toList(),
              onChanged: (newValue) {
                setState(() => selectedSessionType = newValue!);
              },
              decoration: InputDecoration(labelText: "Select Session Type"),
            ),
            SizedBox(height: 12),

            // Date Picker
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text("Select Date: ${selectedDate.toLocal().toString().split(' ')[0]}"),
            ),
            SizedBox(height: 12),

            // Time Picker
            ElevatedButton(
              onPressed: () => _selectTime(context),
              child: Text("Select Time: ${selectedTime.format(context)}"),
            ),
            SizedBox(height: 12),

            // Mentor Notes
            TextField(
              controller: notesController,
              decoration: InputDecoration(labelText: "Add Notes (Optional)", border: OutlineInputBorder()),
              maxLines: 3,
            ),
            SizedBox(height: 20),

            // Schedule Button
            ElevatedButton(
              onPressed: _scheduleSession,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Text("Confirm & Schedule",style: TextStyle(color: const Color.fromARGB(229, 255, 255, 255)),),
            ),
          ],
        ),
      ),
    );
  }
}