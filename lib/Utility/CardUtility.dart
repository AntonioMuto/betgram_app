import 'package:betgram_app/Controllers/SettingsControllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardUtility {
  static SettingsController _settingController = Get.find();
  
  static getCardContainer(Widget child) {
      return Container(
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.all(10),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: _settingController.getTheme().cardColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Get.theme.primaryColorDark.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 2), // Offset della ombra
            ),
          ],
        ),
        child: child,
      );
  }
}
