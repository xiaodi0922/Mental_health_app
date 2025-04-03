import 'package:flutter/material.dart';
import 'package:mental_heatlh_app/pages/insight/insight_data.dart';

class SelfCare extends StatelessWidget {
  final Insight insight; // Now accepts an Insight object

  const SelfCare({
    super.key,
    required this.insight,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(insight.title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section (Fixed Size)
            Image.asset(
              insight.imagePath,
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.3, // 30% of screen height
              fit: BoxFit.cover,
            ),
            // Scrollable Text Section (With Paragraph Spacing)
            // ✅ Scrollable Text Section
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: insight.description.map((paragraph) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16), // Space between paragraphs
                    child: Text(
                      paragraph,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87,
                        height: 1.6, // Line spacing
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
