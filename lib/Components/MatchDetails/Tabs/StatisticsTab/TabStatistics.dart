import 'package:betgram_app/Controllers/LiveController.dart';
import 'package:betgram_app/Controllers/MatchInfoController.dart';
import 'package:betgram_app/Controllers/SettingsControllers.dart';
import 'package:betgram_app/Models/MatchInfo/Statistics/Statistics.dart';
import 'package:betgram_app/Utility/TextFacility.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../UtilityComponents/Loading.dart';
import 'StatisticRow.dart';

class TabStatistics extends StatelessWidget {
  TabStatistics({super.key});
  static final MatchInfoController matchInfoController = Get.find();
  final SettingsController _settingsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var theme = _settingsController.theme.value;
      var stats = matchInfoController.statistics.value.all;
      if(matchInfoController.statsFilter.value == 0) {
        stats = matchInfoController.statistics.value.all;
      } else if(matchInfoController.statsFilter.value == 1) {
        stats = matchInfoController.statistics.value.firstHalf;
      } else if(matchInfoController.statsFilter.value == 2) {
        stats = matchInfoController.statistics.value.secondHalf;
      }
      return (matchInfoController.loadingStats.value && matchInfoController.statistics.value.all != null) ? const Loading() : Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 9.0, top: 8.0),
                child: SizedBox(
                  height: 35,
                  width: Get.width * 0.27,
                  child: ElevatedButton(
                    onPressed: () {
                      matchInfoController.statsFilter.value = 0;
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            matchInfoController.statsFilter.value == 0
                                ? Colors.green
                                : theme.cardColor)),
                    child: Text(
                      "TUTTO",
                      style: TextFacility.getBoldStyleText(12),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 9.0, top: 8.0),
                child: SizedBox(
                  height: 35,
                  width: Get.width * 0.27,
                  child: ElevatedButton(
                    onPressed: () {
                      matchInfoController.statsFilter.value = 1;
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            matchInfoController.statsFilter.value == 1
                                ? Colors.green
                                : theme.cardColor)),
                    child: Text(
                      "1° TEMPO",
                      style: TextFacility.getBoldStyleText(11),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 9.0, top: 8.0),
                child: SizedBox(
                  height: 35,
                  width: Get.width * 0.27,
                  child: ElevatedButton(
                    onPressed: () {
                      matchInfoController.statsFilter.value = 2;
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            matchInfoController.statsFilter.value == 2
                                ? Colors.green
                                : theme.cardColor)),
                    child: Text(
                      "2° TEMPO",
                      style: TextFacility.getBoldStyleText(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: stats?.length,
              itemBuilder: (context, index) {
                final stat = stats?[index] ?? Statistics();
                return StatisticRow(stat: stat);
              },
            ),
          )
        ],
      );
    });
  }
}
