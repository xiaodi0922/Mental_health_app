import 'package:flutter/material.dart';

class AppTheme {


  static ThemeData lightTheme = ThemeData(
    fontFamily: 'Poppins',
    scaffoldBackgroundColor: const Color.fromRGBO(243, 242, 238, 1), // Set background colo
    //scaffoldBackgroundColor: const Color.fromRGBO(190, 186, 172, 1),
    //scaffoldBackgroundColor: const Color.fromRGBO(232, 231, 223, 1),
    colorScheme: const ColorScheme.light(
    //primary: Color.fromRGBO(147, 197, 114, 1),
      primary: Color.fromRGBO(111, 176, 69, 1),
    secondary: Colors.blue,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0, // Remove shadow if needed
      centerTitle: true,

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
