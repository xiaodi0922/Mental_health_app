import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:mental_heatlh_app/pages/activity_page.dart';
import 'package:mental_heatlh_app/pages/calendar_page.dart';
import 'package:mental_heatlh_app/pages/moodDetection_page.dart';
import 'package:mental_heatlh_app/pages/report_page.dart';
import 'ai_assistant_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; // Track the current page index

  // List of pages
  final List<Widget> _pages = [
    CalendarPage(),
    ActivityPage(),
    AiAssistantPage(),
    ReportPage()
  ];

  void signUserOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon:  Icon(Icons.logout),
          ),
        ],
      ),*/
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        height: 60.0,
        color: Theme.of(context).colorScheme.primary,
        backgroundColor: Colors.white,
        animationDuration: Duration(milliseconds: 300),
        items: <Widget>[
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.list, size: 30, color: Colors.white),
          Icon(Icons.chat, size: 30, color: Colors.white),
          Icon(Icons.person, size: 30, color: Colors.white),
        ],
      ),
    );
  }
}
