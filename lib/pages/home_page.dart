import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mental_heatlh_app/pages/activity_page.dart';
import 'package:mental_heatlh_app/pages/calendar_page.dart';
import 'package:mental_heatlh_app/pages/report_page.dart';

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
    ReportPage()

  ];

  void signUserOut() async {
    await FirebaseAuth.instance.signOut();
  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: signUserOut,
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          color: Colors.white,
          child: GNav(
              gap: 8,
              backgroundColor: Colors.white,
              color: Colors.grey[800],
              activeColor: Colors.white,
              tabBackgroundColor: Colors.blue,
            padding: const EdgeInsets.all(16),
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.list,
                  text: 'Activity',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Profile',
                ),
              ],
            selectedIndex: _currentIndex,
            onTabChange: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),

      );
    }
  }

