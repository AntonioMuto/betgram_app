import 'package:betgram_app/Components/MatchDetails/MatchInfo.dart';
import 'package:betgram_app/Controllers/LiveController.dart';
import 'package:betgram_app/Controllers/SettingsControllers.dart';
import 'package:betgram_app/Models/MatchList/ShortInfoFixture.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Models/MatchList/ShortInfoTeam.dart';
import '../../Utility/TextFacility.dart';

class CustomMatchTile extends StatelessWidget {
  final ShortInfoFixture match;
  final SettingsController settingController = Get.find();
  final LiveController liveController = Get.find();
  CustomMatchTile({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Usa il colore dal controller
      final cardColor =
          settingController.settings.value.isDarkMode.value == true
              ? const Color.fromARGB(255, 12, 12, 12)
              : Colors.white;

      return GestureDetector(
        onTap: () async {
          Get.to(() => MatchInfo(match: match));
          await liveController.setMatchDetails(match.id);
        },
        child: Card(
          color: cardColor,
          margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
          child: Padding(
            padding: const EdgeInsets.only(left: 4, right: 4),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildTeamInfo(match.home, true),
                    _buildScore(),
                    _buildTeamInfo(match.away, false),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildTeamInfo(ShortInfoTeam team, bool isHome) {
    return Expanded(
        child: isHome
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    imageUrl:
                        "https://images.fotmob.com/image_resources/logo/teamlogo/${team.id}.png",
                    width: 20,
                    height: 20,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.sports_soccer),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      team.name,
                      style: TextFacility.getBoldStyleText(15),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      team.name,
                      style: TextFacility.getBoldStyleText(15),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                  ),
                  const SizedBox(width: 4),
                  CachedNetworkImage(
                    imageUrl:
                        "https://images.fotmob.com/image_resources/logo/teamlogo/${team.id}.png",
                    width: 25,
                    height: 25,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.sports_soccer),
                  ),
                ],
              ));
  }

  Widget _buildScore() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            match.status?.scoreStr ?? '-',
            style: match.status?.ongoing == true
                ? TextFacility.getBoldStyleTextColor(15, Colors.red)
                : TextFacility.getBoldStyleText(15),
          ),
          const SizedBox(height: 2),
          Text(
            _retrieveStatus(match),
            style: match.status?.ongoing == true
                ? TextFacility.getBoldStyleTextColor(15, Colors.red)
                : TextFacility.getBoldStyleText(15),
          ),
        ],
      ),
    );
  }

  String _retrieveStatus(ShortInfoFixture match) {
    if (match.status != null && match.status?.ongoing == true) {
      return "${match.liveTime?.short}";
    }
    if (match.status != null && match.status?.finished == true) {
      return "FT";
    }
    return match.time.split(' ')[1];
  }
}
