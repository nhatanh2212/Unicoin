import "package:flutter/material.dart";

final ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.purple,
  brightness: Brightness.light,
  primaryColor: Colors.white,
  primaryColorLight: Colors.purple[700],
  dividerColor: Colors.grey[200],
  bottomAppBarColor: Colors.grey[200],
  iconTheme: const IconThemeData(color: Colors.white),
  primaryIconTheme: const IconThemeData(color: Colors.black),
  disabledColor: Colors.grey[500],
);

final ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.purple,
  brightness: Brightness.dark,
  primaryColor: const Color.fromRGBO(50, 50, 57, 1.0),
  primaryColorLight: Colors.deepPurpleAccent[100],
  iconTheme: const IconThemeData(color: Colors.white),
  cardColor: const Color.fromRGBO(55, 55, 55, 1.0),
  dividerColor: const Color.fromRGBO(60, 60, 60, 1.0),
  bottomAppBarColor: Colors.black26,
);

final ThemeData darkThemeOLED = ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color.fromRGBO(5, 5, 5, 1.0),
  backgroundColor: Colors.black,
  canvasColor: Colors.black,
  primaryColorLight: Colors.deepPurple[300],
  cardColor: const Color.fromRGBO(16, 16, 16, 1.0),
  dividerColor: const Color.fromRGBO(20, 20, 20, 1.0),
  bottomAppBarColor: const Color.fromRGBO(19, 19, 19, 1.0),
  dialogBackgroundColor: Colors.black,
  iconTheme: const IconThemeData(color: Colors.white),
);