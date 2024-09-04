import 'package:betgram_app/Components/MatchDetails/Tabs/StatisticsTab/TabStatistics.dart';
import 'package:betgram_app/Models/MatchInfo/Statistics/StatsDetails.dart';
import 'package:betgram_app/Services/MatchDetailsServices/MatchDetailsServices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Components/MatchDetails/Tabs/DetailsTab/TabsDetails.dart';

class MatchInfoController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  var statistics = StatsDetails().obs;
  var statsLoaded = false.obs;
  var loadingStats = false.obs;
  var matchId = 0.obs;
  var statsFilter = 0.obs;

  var tabs = [
    const Tab(text: 'DETTAGLI'),
    const Tab(text: 'STATISTICHE'),
    const Tab(text: 'FORMAZIONE'),
    const Tab(text: 'CLASSIFICA'),
  ];

  List<Widget> tabViews = [
    const TabsDetails(),
    TabStatistics(),
    const Center(child: Text("Contenuto del Tab 3")),
    const Center(child: Text("Contenuto del Tab 4")),
  ];

  @override
  Future<void> onInit() async {
    super.onInit();
    statsFilter.value = 0;
    tabController = TabController(vsync: this, length: 4);
    tabController.addListener(() async {
      // if(!statsLoaded.value && tabController.index == 1){
      if(!statsLoaded.value && tabController.index == 1){
        print("STATISTICS");
        loadingStats.value = true;
        statistics.value = await matchDetailsServices.retrieveMatchStats(matchId.value);
        statsLoaded.value = true;
      }
    });
  }

  reset(){
    statsLoaded.value = false;
    statsFilter.value = 0;
    tabController.index = 0;
  }
}