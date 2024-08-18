import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../Models/Utility/Settings.dart';
import '../Utility/Themes.dart';

class SettingsController extends GetxController  with GetSingleTickerProviderStateMixin {
  var settings = Settings(isDarkMode: true.obs).obs;
  var theme = darkappThemeData.obs;

  toggleDarkMode() {
    settings.value.isDarkMode.value = !settings.value.isDarkMode.value;
    theme.value = settings.value.isDarkMode.value
        ? darkappThemeData
        : appThemeData;
    Get.changeTheme(theme.value);
  }

  getTheme(){
    return Get.theme;
  }
}
