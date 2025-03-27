import 'package:flutter/material.dart';
import 'package:mental_heatlh_app/pages/motivation_page.dart';
import 'package:mental_heatlh_app/pages/soundcape_page.dart';

import '../components/activity_section.dart';
import 'insight/insight_page.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: const Text('Activities ',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),

      body: Padding(

        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),

            ActivitySection(
              title: 'Sound cape',
              imagePaths: 'assets/images/test.png',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context){
                      return const SoundscapePage();
                    }));
              },
            ),
            const SizedBox(height: 30),

            ActivitySection(
              title: 'Insight',
              imagePaths: 'assets/images/test.png',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context){
                      return const InsightPage();
                    }));
              },
            ),
            const SizedBox(height: 30),

            ActivitySection(
              title: 'Motivation',
              imagePaths: 'assets/images/test.png',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context){
                      return MotivationPage();
                    }));
              },
            ),
          ],
        ),
      ),

    );
  }
}
