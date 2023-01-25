import 'package:flutter/material.dart';

import 'Screens/HomePage.dart';

void main() {
  runApp(
    MaterialApp(
      home: const HomePage(),
      theme: ThemeData(
        splashFactory: NoSplash.splashFactory,
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          bodyText2: TextStyle(
            fontFamily: "Poppins",
          ),
        ),
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.black,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
            fontSize: 20,
          ),
        ),
        brightness: Brightness.light,
      ),
    ),
  );
}
