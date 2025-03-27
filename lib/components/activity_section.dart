import 'package:flutter/material.dart';

class ActivitySection extends StatelessWidget {
  final String title;
  final String imagePaths;
  final Function()? onTap;

  const ActivitySection({
    super.key,
    required this.title,
    required this.imagePaths,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
        style: TextStyle(
          fontSize: 20 ,
          fontWeight: FontWeight.bold,
        ),
    ),
        const SizedBox(height: 8,),
        GestureDetector(
          onTap: onTap ,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imagePaths,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        )
      ],
    );
  }
}
