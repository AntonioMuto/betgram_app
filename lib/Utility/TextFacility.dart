import 'dart:ui';

import 'package:betgram_app/Controllers/SettingsControllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextFacility {
  static SettingsController settingsController = Get.find();
  
  static TextStyle getBoldStyleText(double size) {
    return TextStyle(
        color: Get.theme.primaryColorDark,
        fontSize: size,
        fontWeight: FontWeight.bold,
        fontFamily: "Poppins",
        decoration: TextDecoration.none);
  }

  static TextStyle getStyleTextWhite(double size) {
    return TextStyle(
        color: Colors.white,
        fontSize: size,
        fontFamily: "Poppins",
        decoration: TextDecoration.none);
  }

  static TextStyle getBoldStyleTextColor(double size, Color color) {
    return TextStyle(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.bold,
        fontFamily: "Poppins",
        decoration: TextDecoration.none);
  }

  static TextStyle getBoldStyleTextWhite(double size) {
    return TextStyle(
        color: Colors.white,
        fontSize: size,
        fontWeight: FontWeight.bold,
        fontFamily: "Poppins",
        decoration: TextDecoration.none);
  }

  static TextStyle getBoldStyleSubText(double size) {
    return TextStyle(
        color: Color.fromARGB(255, 153, 153, 153),
        fontSize: size,
        fontWeight: FontWeight.bold,
        fontFamily: "Poppins",
        decoration: TextDecoration.none);
  }

  static TextStyle getStyleText(double size) {
    return TextStyle(
        color: Colors.white,
        fontSize: size,
        fontFamily: "Poppins",
        decoration: TextDecoration.none);
  }
}
