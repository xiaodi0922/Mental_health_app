import 'package:flutter/material.dart';

class Selection extends StatelessWidget {
  final String title;
  final Widget subtitle;
  final Function()? onTap;

  const Selection({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          )
        ),
        const SizedBox(height: 5),

        // Subtitle and Add Icon in Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: subtitle, // Now supports any widget like Wrap, Text, etc.
            ),
            GestureDetector(
              onTap: onTap,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                    Icons.add,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
