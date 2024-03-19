import 'package:flutter/material.dart';


//question: How to set background colors?
final ThemeData custom_theme = ThemeData(
  primarySwatch: Colors.red,
  scaffoldBackgroundColor: Colors.white70,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.green,
    ),

  textTheme: const TextTheme(
    //titleMedium: 'MightySouly',
    titleLarge: TextStyle(fontFamily: 'MightySouly'),
    bodySmall: TextStyle(fontFamily: 'MightySouly'),
    bodyMedium: TextStyle(fontFamily: 'MightySouly'),
    bodyLarge: TextStyle(fontFamily: 'MightySouly'),
    headlineSmall: TextStyle(fontFamily: 'MightySouly'),
    headlineMedium: TextStyle(fontFamily: 'MightySouly'),
    headlineLarge: TextStyle(fontFamily: 'MightySouly'),
  ),
);