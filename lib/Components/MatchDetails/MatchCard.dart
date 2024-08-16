import 'package:betgram_app/Utility/Costants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../Controllers/LiveController.dart';
import '../../Models/MatchList/ShortInfoFixture.dart';

class MatchCard extends StatelessWidget {
  final ShortInfoFixture match;
  const MatchCard({super.key, required this.match});
  static final LiveController _liveController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx((){
    var header = _liveController.matchDetails.value.header;
    return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0,top: 15),
                  child: _buildTeamInfo(header?.teams[0].imageUrl ?? Costants.URL_NA_IMAGE, header?.teams[0].name ?? Costants.URL_NA_IMAGE),
                ),
                Column(
                  children: [
                    Text(
                      header?.status?.scoreStr ?? "CIAO",
                      style: TextStyle(
                        color: header?.status?.ongoing == true ? Colors.red : Get.theme.primaryColorDark,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      header?.status?.short ?? "CIAO",
                      style: TextStyle(
                        color: header?.status?.ongoing == true ? Colors.red : Get.theme.primaryColorDark,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0,top: 15),
                  child: _buildTeamInfo(header?.teams[1].imageUrl ?? Costants.URL_NA_IMAGE, header?.teams[1].name ?? Costants.URL_NA_IMAGE),
                ),
              ],
            ),
          ],
    );
    });
  }

  Widget _buildTeamInfo(String flagUrl, String teamName) {
    return Container(
      width: Get.width * 0.30,
      child: Column(
        children: [
          Image.network(
            flagUrl,
            height: 50,
            width: 50,
          ),
          const SizedBox(height: 10),
          Text(
            teamName,
            style: TextStyle(
              color: Get.theme.primaryColorDark,
              fontSize: 15,
            ),
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
