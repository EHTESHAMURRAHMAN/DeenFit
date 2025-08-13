import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData darkmode() => ThemeData(
  primaryColor: Color(0xffB8A474),
  canvasColor: Color(0xff1A1B20),
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Color(0xff191814),
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xff191814),
    ),
    backgroundColor: Color(0xff191814),
    titleTextStyle: TextStyle(
      color: Color(0xffB8A474),
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  scaffoldBackgroundColor: Color(0xff191814),
  listTileTheme: ListTileThemeData(
    iconColor: Colors.white,
    textColor: Colors.white,
    tileColor: Color(0xff1A1B20),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),

  textTheme: TextTheme(
    displayLarge: TextStyle(color: Colors.white),
    displayMedium: TextStyle(color: Colors.white),
    displaySmall: TextStyle(color: Colors.white),
    headlineLarge: TextStyle(color: Colors.white),
    headlineMedium: TextStyle(color: Colors.white),
    headlineSmall: TextStyle(color: Colors.white),
    titleLarge: TextStyle(color: Colors.white),
    titleMedium: TextStyle(color: Colors.white),
    titleSmall: TextStyle(color: Colors.white),
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white),
    bodySmall: TextStyle(color: Colors.white),
    labelLarge: TextStyle(color: Colors.white),
    labelMedium: TextStyle(color: Colors.white),
    labelSmall: TextStyle(color: Colors.white),
  ),
);

ThemeData lightmode() => ThemeData(
  primaryColor: Color(0xFF4CAF50), // Green
  canvasColor: Color(0xFFF8F8F8), // Off-white background
  scaffoldBackgroundColor: Color(0xFFF8F8F8),

  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFFF8F8F8),
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Color(0xFFF8F8F8),
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Color(0xFFF8F8F8),
    ),
    titleTextStyle: TextStyle(
      color: Color(0xFF4CAF50),
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(color: Colors.black),
  ),

  listTileTheme: ListTileThemeData(
    iconColor: Colors.black87,
    textColor: Colors.black87,
    tileColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),

  textTheme: TextTheme(
    displayLarge: TextStyle(color: Colors.black87),
    displayMedium: TextStyle(color: Colors.black87),
    displaySmall: TextStyle(color: Colors.black87),
    headlineLarge: TextStyle(color: Colors.black87),
    headlineMedium: TextStyle(color: Colors.black87),
    headlineSmall: TextStyle(color: Colors.black87),
    titleLarge: TextStyle(color: Colors.black87),
    titleMedium: TextStyle(color: Colors.black87),
    titleSmall: TextStyle(color: Colors.black87),
    bodyLarge: TextStyle(color: Colors.black87),
    bodyMedium: TextStyle(color: Colors.black87),
    bodySmall: TextStyle(color: Colors.black87),
    labelLarge: TextStyle(color: Colors.black87),
    labelMedium: TextStyle(color: Colors.black87),
    labelSmall: TextStyle(color: Colors.black87),
  ),
);
