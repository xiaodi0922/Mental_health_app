import 'package:flutter/material.dart';

class InsightStyle extends StatelessWidget {
  final String imagePath;
   // Function to handle clicks

  const InsightStyle({
    super.key,
    required this.imagePath,
   // Require a function for navigation
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16), // Rounded corners
      child: Image.asset(
        imagePath,
        height: 150, // Adjust the size as needed
        width: 150,
        fit: BoxFit.cover, // Ensures the image covers the box
      ),
    );
  }
}
