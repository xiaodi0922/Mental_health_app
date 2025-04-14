import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:mental_heatlh_app/pages/activity_page.dart';
import 'package:mental_heatlh_app/pages/ai_assistant_page.dart';
import 'package:mental_heatlh_app/pages/calendar_page.dart';
import 'package:mental_heatlh_app/pages/home_page.dart';
import 'package:mental_heatlh_app/pages/insight/insight_page.dart';
import 'package:mental_heatlh_app/pages/insight/self_care.dart';

import 'package:mental_heatlh_app/pages/login%20&%20register/auth_page.dart';
import 'package:mental_heatlh_app/pages/moodDetection_page.dart';

import 'package:mental_heatlh_app/pages/soundcape_page.dart';
import 'package:mental_heatlh_app/pages/submit_page.dart';
import 'package:mental_heatlh_app/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main () async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,

      home:AuthPage(),
    );
  }
}

