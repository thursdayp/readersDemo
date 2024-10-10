import 'package:flutter/material.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({Key? key}) : super(key: key);

  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {


  final int booksInProgress = 3;
  final int booksCompleted = 12;
  final int readingGoal = 25;



  @override
  Widget build(BuildContext context) {
    double progress = booksCompleted / readingGoal;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reading Stats'),
         backgroundColor: const Color(0xFFFFE5E5),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Overall Reading Stats',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Placeholder สำหรับกราฟ สามารถเพิ่มการใช้งานแพ็คเกจ fl_chart ได้ในอนาคต
            Container(
              height: 200,
              color: Colors.grey[300],
              child: const Center(
                child: Text(
                  'Graph Placeholder',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // แสดงข้อมูลสถิติการอ่าน
            Text(
              'Books in Progress: $booksInProgress',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Books Completed: $booksCompleted',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            // ตัวบ่งชี้ความคืบหน้า
            Text(
              'Reading Goal: $readingGoal Books',
              style: const TextStyle(fontSize: 18),
            ),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey,
              color: Colors.blue,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // แสดงสถิติแบบละเอียด
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Detailed Stats'),
                      content: const Text('Here are your detailed stats.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('View Detailed Stats'),
            ),
          ],
        ),
      ),

    );
  }
}
