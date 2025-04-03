import 'package:flutter/material.dart';

class Insight {
  final String imagePath;
  final String title;
  final List<String> description;

  Insight({
    required this.imagePath,
    required this.title,
    required this.description,
  });
}

// List of insights
final List<Insight> insights = [
  Insight(
    imagePath: 'assets/images/test.png',
    title: 'Self Care',
    description: [
      "Self-care is an important part of maintaining mental and physical health. It includes activities that help reduce stress and promote well-being.",
      "Practicing self-care can involve small daily habits like proper sleep, a balanced diet, and setting boundaries in your personal and professional life.",
      "Engaging in hobbies, exercising, and seeking social support are also effective self-care strategies that contribute to overall happiness and well-being.",
      "Techniques such as meditation, breathing exercises, and physical activities like yoga can help in reducing stress.",
      "Taking breaks, practicing mindfulness, and engaging in enjoyable activities are great ways to manage daily stress effectively."
    ],
  ),
  Insight(
    imagePath: 'assets/images/google.png',
    title: 'Stress Management',
    description: [
      "Managing stress is essential for mental health and well-being. Stress can be caused by various factors, including work pressure, relationships, and personal expectations.",
      "Techniques such as meditation, breathing exercises, and physical activities like yoga can help in reducing stress.",
      "Taking breaks, practicing mindfulness, and engaging in enjoyable activities are great ways to manage daily stress effectively."
    ],
  ),
  // Add more insights here...
];
