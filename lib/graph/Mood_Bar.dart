import 'package:flutter/material.dart';

class MoodBar extends StatelessWidget {
  final Map<String, int> moodCounts;

  const MoodBar({super.key, required this.moodCounts});

  @override
  Widget build(BuildContext context) {
    final total = moodCounts.values.fold(0, (sum, val) => sum + val);

    // Avoid divide by zero
    final moodPercentages = total > 0
        ? moodCounts.map((key, value) => MapEntry(key, (value / total)))
        : moodCounts.map((key, _) => MapEntry(key, 0.0));

    final moodOrder = [
      "assets/images/Great.png",
      "assets/images/Good.png",
      "assets/images/Neutral.png",
      "assets/images/Sad.png",
      "assets/images/Awful.png",
    ];

    final colorMap = {
      "assets/images/Awful.png": const Color.fromARGB(255, 255, 36, 0),
      "assets/images/Sad.png": const Color.fromARGB(255, 255, 143, 0),
      "assets/images/Neutral.png": const Color.fromARGB(255, 255, 200, 42),
      "assets/images/Good.png": const Color.fromARGB(255, 111, 176, 69),
      "assets/images/Great.png": const Color.fromARGB(255, 70, 175, 80),
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Emoji Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: moodOrder.map((mood) {
            return Image.asset(mood, width: 30, height: 30);
          }).toList(),
        ),
        const SizedBox(height: 5),

        // Percentage Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: moodOrder.map((mood) {
            final percent = (moodPercentages[mood]! * 100).toStringAsFixed(0);
            return Text(
              "$percent%",
              style: const TextStyle(fontWeight: FontWeight.bold),
            );
          }).toList(),
        ),
        const SizedBox(height: 8),

        // Mood Bar
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Row(
            children: moodOrder.map((mood) {
              final flex = (moodPercentages[mood]! * 100).round();
              return Expanded(
                flex: flex > 0 ? flex : 1,
                child: Container(
                  height: 20,
                  color: colorMap[mood],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}