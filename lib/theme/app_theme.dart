import 'package:flutter/material.dart';

class AppTheme {
  static const Color sage = Color(0xFF9DB08B);
  static const Color beige = Color(0xFFF9F7F2);
  static const Color textDark = Color(0xFF4A4A4A);

  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: beige,
      primaryColor: sage,
      colorScheme: ColorScheme.fromSeed(seedColor: sage, primary: sage),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: textDark),
        titleLarge: TextStyle(color: sage, fontWeight: FontWeight.bold),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: sage,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );
  }
}