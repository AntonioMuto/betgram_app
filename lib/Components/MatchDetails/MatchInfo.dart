import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controllers/SettingsControllers.dart';
import '../../Controllers/LiveController.dart';
import '../../Controllers/MatchInfoController.dart';
import '../../Models/MatchList/ShortInfoFixture.dart';
import '../../Utility/TextFacility.dart';
import 'MatchCard.dart';

class MatchInfo extends StatelessWidget {
  final ShortInfoFixture match;
  MatchInfo({super.key, required this.match});

  final LiveController liveController = Get.find();
  final SettingsController settingController = Get.find();
  final MatchInfoController matchInfoController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final cardColor = Get.theme.cardColor;
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 30,
              color: Get.theme.primaryColorDark,
            ),
            onPressed: () {
              liveController.stopTimerMatchDetails();
              liveController.startTimer();
              liveController.retrieveLiveMatchListData();
              Get.back();
            },
          ),
          title: Text(
            "Dettagli",
            style: TextFacility.getBoldStyleText(20),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Row(
                children: [
                  Container(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber[800]),
                      onPressed: () {
                        settingController.toggleDarkMode();
                      },
                      child: Obx(() => Text(
                          settingController.settings.value.isDarkMode.value
                              ? "Dark Mode"
                              : "Light Mode")),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        body: liveController.loadingMatchDetails.value == true || liveController.loadingMatchFirstLiveDetails.value == true
            ? const Center(
                child: CircularProgressIndicator(
                color: Colors.white,
              ))
            : Container(
              margin: const EdgeInsets.only(left: 10.0, right: 10.0), 
              child: Column(
                  children: [
                    MatchCard(match: match),
                    const SizedBox(height: 10),
                    Container(
                      height: kToolbarHeight - 2.0,
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TabBar(
                        dividerHeight: 0.1,
                        dividerColor: const Color.fromARGB(0, 76, 175, 79),
                        tabAlignment: TabAlignment.start,
                        isScrollable: true,
                        controller: matchInfoController.tabController,
                        indicator: const UnderlineTabIndicator(
                          borderSide: BorderSide(
                            width: 4,
                            color: Color.fromARGB(255, 111, 203, 74),
                          ),
                        ),
                        labelColor: Get.theme.primaryColorDark,
                        unselectedLabelColor: Get.theme.primaryColorDark,
                        tabs: matchInfoController.tabs,
                      ),
                    ),
                    Container(
                      height: 8,
                      decoration: BoxDecoration(
                      color: Colors.transparent,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    // Aggiungi un Expanded per il contenuto del TabBarView
                    Expanded(
                      child: TabBarView(
                        controller: matchInfoController.tabController,
                        children: matchInfoController.tabViews,
                      ),
                    )
                  ],
                ),
            ),
      );
    });
  }
}
