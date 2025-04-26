import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class MotivationPage extends StatefulWidget {
  @override
  _MotivationPageState createState() => _MotivationPageState();
}

class _MotivationPageState extends State<MotivationPage> {
  final List<String> _challenges = [
    "Write down 3 things you're grateful for.",
    "Take 5 deep breaths.",
    "Compliment yourself today.",
    "Step outside and observe nature.",
    "Text a friend something kind.",
    "Spend 10 minutes reading something positive.",
    "Do a 1-minute stretch or exercise."
  ];

  final List<String> _quotes = [
    "Believe in yourself and all that you are.",
    "The only way to do great work is to love what you do.",
    "Success is not final, failure is not fatal: It is the courage to continue that counts.",
    "Your limitation—it’s only your imagination.",
    "Don’t stop when you’re tired. Stop when you’re done.",
    "Happiness is not by chance, but by choice.",
    "Small steps every day lead to big changes."
  ];


  bool _isCompleted = false;
  int _todayIndex = 0;
  bool isTesting = true;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now().toIso8601String().substring(0, 10);

    // Simulate a new day in test mode
    if (isTesting) {
      await prefs.setString('lastDate', ""); // force reset
    }

    final lastDate = prefs.getString('lastDate');

    if (lastDate != today) {
      await prefs.setString('lastDate', today);
      await prefs.setBool('completed', false);
      await prefs.setInt('dayIndex', ((prefs.getInt('dayIndex') ?? -1) + 1) % _challenges.length);
    }

    setState(() {
      _isCompleted = prefs.getBool('completed') ?? false;
      _todayIndex = prefs.getInt('dayIndex') ?? 0;
    });
  }

  Future<void> _completeChallenge() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('completed', true);

    setState(() {
      _isCompleted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String challenge = _challenges[_todayIndex];
    final String quote = _quotes[_todayIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
            "Daily Challenge",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            )
        ),

        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

      ),

      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Step Progress Indicator
            Row(
              children: List.generate(_challenges.length * 2 - 1, (index) {
                if (index.isEven) {
                  int stepIndex = index ~/ 2;
                  bool isCompleted = stepIndex < _todayIndex;
                  bool isCurrent = stepIndex == _todayIndex;

                  return Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isCompleted
                          ? Theme.of(context).colorScheme.primary
                          : isCurrent
                          ? Colors.white
                          : Colors.grey[300],
                      border: isCurrent
                          ? Border.all(color: Theme.of(context).colorScheme.primary, width: 2)
                          : null,
                    ),
                    child: Center(
                      child: isCompleted
                          ? Icon(Icons.check, size: 18, color: Colors.white)
                          : Text(
                        '${stepIndex + 1}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isCurrent
                              ? Theme.of(context).colorScheme.primary
                              : Colors.black.withOpacity(0.6),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Expanded(
                    child: Container(
                      height: 2,
                      color: index < _todayIndex * 2 - 1
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey[300],
                    ),
                  );
                }
              }),
            ),
            const SizedBox(height: 32),

            // Challenge Section
            Text(
              "Today's Challenge",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              challenge,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 30),
            _isCompleted
                ? Column(
              children: [
                Image.asset(
                  'assets/images/Great.png',
                  width: 100,
                  height: 100,
                ),
                const SizedBox(height: 30),
                Text(
                  "Great job! You've unlocked today’s quote:",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                Text(
                  '"$quote"',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                ),
              ],
            )
                : ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(300, 60),
                backgroundColor: Theme.of(context).colorScheme.primary,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: _completeChallenge,
              label: Text(
                  "Mark as Completed",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
