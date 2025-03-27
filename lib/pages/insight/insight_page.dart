import 'package:flutter/material.dart';
import 'package:mental_heatlh_app/components/insight_style.dart';
import 'package:mental_heatlh_app/pages/insight/self_care.dart';
import 'package:mental_heatlh_app/pages/insight/insight_data.dart';

import '../activity_page.dart';


class InsightPage extends StatelessWidget {
  const InsightPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Insight",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),  // Back icon
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.65,
          ),
          itemCount: insights.length, // Use the list from insight_data.dart
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelfCare(
                      insight: insights[index],
                    ),
                  ),
                );
              },
              child: InsightStyle(
                imagePath: insights[index].imagePath,
              ),
            );
          },
        ),
      ),
    );
  }
}
