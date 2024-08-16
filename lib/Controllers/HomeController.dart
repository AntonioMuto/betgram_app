import 'dart:async';
import 'package:get/get.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

    }