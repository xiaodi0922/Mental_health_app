import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

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
              icon:  Icon(Icons.logout),
            ),

          ],
        ),
    );
  }
}
