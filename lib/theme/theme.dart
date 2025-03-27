import 'package:flutter/material.dart';

class AppTheme {


  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: const Color.fromRGBO(255, 244, 230, 1), // Set background colo
    colorScheme: const ColorScheme.light(
    primary: Color.fromRGBO(75, 56, 50, 1), // Set primary color
    secondary: Colors.blue,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0, // Remove shadow if needed
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: Colors.black), // Ensure back button is visible
    ),
    //Theme for text fields
    /*inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(
        fontSize: 16,
        color: Colors.grey[500],
      ),
      prefixIconColor: const Color.fromRGBO(119, 119, 119, 1),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 34,
        color: Colors.black,
      ),
      titleMedium: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: Colors.black,
      ),
      bodyMedium: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: Colors.black,
      ),
      bodySmall: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: Colors.black54,
      ),
    ),*/
  );
}
