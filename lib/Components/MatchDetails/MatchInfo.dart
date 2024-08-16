import 'package:betgram_app/Components/MatchDetails/MatchCard.dart';
import 'package:betgram_app/Controllers/LiveController.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../Controllers/SettingsControllers.dart';
import '../../Models/MatchList/ShortInfoFixture.dart';
import '../../Utility/TextFacility.dart';

class MatchInfo extends StatelessWidget {
  final ShortInfoFixture match;
  MatchInfo({super.key, required this.match});

  final LiveController liveController = Get.find();
  final SettingsController settingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return  Obx((){ return Scaffold(
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
        body: liveController.loadingMatchDetails.value == true ? const Center(child: CircularProgressIndicator(color: Colors.white,)) : MatchCard(match: match)
    );
  });
  }
}
