import 'package:flutter/material.dart';

final ThemeData darkappThemeData = ThemeData(
  useMaterial3: true,
  primaryColor: Colors.black,
  primaryColorDark: Colors.white,
  splashColor: Colors.transparent,
  colorScheme: const ColorScheme(brightness: Brightness.dark, primary: Colors.black, onPrimary: Colors.black, secondary: Colors.black, onSecondary: Colors.black, error: Colors.red, onError: Colors.red, background: Color.fromRGBO(23, 24, 39, 100), onBackground: Color.fromRGBO(23, 24, 39, 100), surface: Colors.amber, onSurface: Colors.amber),
  canvasColor: Colors.transparent,
  cardColor: Color.fromARGB(255, 30, 30, 44)
);

final ThemeData appThemeData = ThemeData(
  useMaterial3: true,
  primaryColorDark: Colors.black,
  splashColor: Colors.transparent,
  primaryColor: Colors.white,
  colorScheme: const ColorScheme(brightness: Brightness.light, primary: Colors.black, onPrimary: Colors.black, secondary: Colors.black, onSecondary: Colors.black, error: Colors.red, onError: Colors.red, background: Colors.white, onBackground: Colors.white, surface: Colors.amber, onSurface: Colors.amber),
  canvasColor: Colors.transparent,
  cardColor: Color.fromARGB(255, 236, 235, 235)
);