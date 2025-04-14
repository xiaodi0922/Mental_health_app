import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../graph/EmojiBarChart.dart';

class ReportPage extends StatelessWidget {
    ReportPage({super.key});

  final user = FirebaseAuth.instance.currentUser;
  final Map <String, int> moodCounts={
    "assets/images/Awful.png":2,
    "assets/images/Sad.png":3,
    "assets/images/Neutral.png":1,
    "assets/images/Good.png":1,
    "assets/images/Great.png":5
  };

  void signUserOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
          title: const Text(
            'Report',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: signUserOut,
              icon:  Icon(Icons.logout),
            ),
          ],
        ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.black45,
                    child: Icon(
                      Icons.person,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    user?.email ?? 'No user',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
      // Emoji bar chart
      Padding(
          padding: const EdgeInsets.all(20),
          child: EmojiBarChart(moodCounts: moodCounts),
      ),
          ]
        ),
      ),
    );
  }
}
