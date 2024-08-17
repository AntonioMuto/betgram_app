import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Components/MatchDetails/Tabs/DetailsTab/TabsDetails.dart';

class MatchInfoController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  var tabs = [
    const Tab(text: 'DETTAGLI'),
    const Tab(text: 'STATISTICHE'),
    const Tab(text: 'FORMAZIONE'),
    const Tab(text: 'CLASSIFICA'),
  ];

  List<Widget> tabViews = [
    const TabsDetails(),
    const Center(child: Text("Contenuto del Tab 2")),
    const Center(child: Text("Contenuto del Tab 3")),
    const Center(child: Text("Contenuto del Tab 4")),
  ];

  @override
  Future<void> onInit() async {
    tabController = TabController(vsync: this, length: 4);
  }
}