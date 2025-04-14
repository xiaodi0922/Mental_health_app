import 'package:flutter/material.dart';

class InsightStyle extends StatelessWidget {
  final String imagePath;
  final String title;
   // Function to handle clicks

  const InsightStyle({
    super.key,
    required this.imagePath,
    required this.title,
   // Require a function for navigation
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16), // Rounded corners
          child: Image.asset(
            imagePath,
            height: 250, // Adjust the size as needed
            width: 180,
            fit: BoxFit.cover, // Ensures the image covers the box
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600, // Text color
          ),
        ),
      ],
    );
  }
}
