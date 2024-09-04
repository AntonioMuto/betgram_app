import 'package:betgram_app/Controllers/SettingsControllers.dart';
import 'package:betgram_app/Models/MatchInfo/Statistics/Statistics.dart';
import 'package:betgram_app/Utility/TextFacility.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class StatisticRow extends StatelessWidget {
  final Statistics stat;
  StatisticRow({super.key, required this.stat});
  var animationDurationFirstLoad = true;
  final SettingsController _settingsController = Get.find();

  @override
  Widget build(BuildContext context) {

    return Obx(() {
    var theme = _settingsController.theme.value;
    // Calcola la percentuale per la barra di avanzamento.
    double total = double.parse(stat.statsHome ?? "0") +
        double.parse(stat.statsAway ?? "0");

    double teamAPercent =
        total != 0 ? (double.parse(stat.statsHome ?? "0") / total * 100) : 0.0;
    double teamBPercent =
        total != 0 ? (double.parse(stat.statsAway ?? "0") / total * 100) : 0.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Dati del Team A
          Text(
            "${stat.stats?[0] ?? ""}",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          // Nome della statistica
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: Get.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: Text(stat.statsHome.toString(),
                            style: TextFacility.getBoldStyleTextColor(13, teamAPercent > teamBPercent ?  theme.primaryColorDark : const Color.fromARGB(255, 173, 173, 173))),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(stat.title ?? "",
                            style: TextFacility.getBoldStyleTextColor(15, const Color.fromARGB(255, 173, 173, 173))),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 3),
                        child: Text(
                          stat.statsAway.toString(),
                          style: TextFacility.getBoldStyleTextColor(13, teamBPercent > teamAPercent ?  theme.primaryColorDark : const Color.fromARGB(255, 173, 173, 173)),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 7.0, bottom: 4.0, left: 1),
                      child: Transform.flip(
                        flipX: true,
                        child: LinearPercentIndicator(
                          width: Get.width / 2.12,
                          animation: true,
                          lineHeight: 7.0,
                          animationDuration: _getAnimationDuration(),
                          barRadius: const Radius.circular(10),
                          percent: _getSafePercent(teamBPercent, teamAPercent),
                          progressColor: const Color.fromARGB(255, 3, 177, 9),
                          backgroundColor: Color.fromARGB(23, 4, 243, 12),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 7.0, bottom: 4.0, right: 1),
                      child: LinearPercentIndicator(
                        width: Get.width / 2.12,
                        animation: true,
                        lineHeight: 7.0,
                        animationDuration: _getAnimationDuration(),
                        barRadius: const Radius.circular(10),
                        percent: _getSafePercent(teamAPercent, teamBPercent),
                        progressColor: Colors.red,
                        backgroundColor: Color.fromARGB(54, 239, 72, 72),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Dati del Team B
          Text(
            "${stat.stats?[1] ?? ""}",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
    });
  }

  _getAnimationDuration() {
    if (animationDurationFirstLoad) {
      return 1400;
    } else {
      return 0;
    }
  }

  double _getSafePercent(double? home, double? away) {
    if (home == null || away == null || (home + away) == 0) {
      return 0.0;
    }
    return away / (home + away);
  }
}
