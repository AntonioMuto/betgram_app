import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../Models/Utility/Settings.dart';

class SettingsController extends GetxController  with GetSingleTickerProviderStateMixin {
  var settings = Settings(isDarkMode: true.obs).obs;

  toggleDarkMode() {
    settings.value.isDarkMode.value = !settings.value.isDarkMode.value;
  }

  getTheme(){
    return Get.theme;
  }
}
