import 'package:flutter/material.dart';

class CustomThemeData{

  static ThemeData build(Color seedColor) {
    return ThemeData(
        textTheme: TextTheme(
          displayLarge: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          displayMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          displaySmall: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.light
          )
      );
  }

}