import 'package:betgram_app/Controllers/LiveController.dart';
import 'package:betgram_app/Controllers/SettingsControllers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import '../../../../Models/MatchInfo/Header/HeaderInfoTeam.dart';
import '../../../../Utility/TextFacility.dart';
import '../../MatchInfo.dart';

class TeamFormDetails extends StatelessWidget {
  final HeaderInfoTeam team;
  final bool isHome;
  TeamFormDetails({super.key, required this.team, required this.isHome});
  final LiveController _liveController = Get.find();
  final SettingsController _settingsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var cardColor = _settingsController.theme.value.cardColor;
      var primaryColorDark = _settingsController.theme.value.primaryColorDark;
      var fixtures = isHome
          ? _liveController.matchDetails.value.details?.teamForm?.fixtureHome
          : _liveController.matchDetails.value.details?.teamForm?.fixtureAway;
      return Column(
        children: [
          ExpansionTile(
            collapsedIconColor: primaryColorDark,
            iconColor: primaryColorDark,
            expansionAnimationStyle: AnimationStyle(duration: 0.5.seconds),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl: team.imageUrl,
                      width: 30,
                      height: 30,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          Icon(Icons.error, size: 40),
                    ),
                    SizedBox(width: 10),
                    Container(
                        width: Get.width * 0.25,
                        child: Text(
                          team.name,
                          style: TextFacility.getBoldStyleText(12),
                          maxLines: 2,
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(fixtures?.length ?? 0, (index) {
                    var match = fixtures?[index];
                    return Container(
                      width: 17,
                      height: 17,
                      margin: EdgeInsets.all(3),
                      color: _retrieveColorForm(match?.resultString ?? ""),
                      alignment: Alignment.center,
                      child: Text(
                        _retrieveValueTextForm(match?.resultString ?? ""),
                        style: TextFacility.getBoldStyleText(11),
                      ),
                    );
                  }),
                )
              ],
            ),
            children: fixtures?.map((match) {
                  return GestureDetector(
                    onTap: () async {
                      await _liveController.setMatchDetails(match.id ?? 0);
                    },
                    child: Card(
                      color: cardColor,
                      child: Padding(
                          padding: const EdgeInsets.only(left: 4, right: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildTeamInfo(match.homeTeamId ?? "",
                                  match.homeTeamName ?? "", true),
                              _buildScore(match.score ?? "",
                                  match.resultString ?? ""),
                              _buildTeamInfo(match.awayTeamId ?? "",
                                  match.awayTeamName ?? "", false),
                            ],
                          )),
                    ),
                  );
                }).toList() ??
                [],
          )
        ],
      );
    });
  }

  Widget _buildTeamInfo(String teamId, String teamName, bool isHome) {
    return isHome
        ? Expanded(
            child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: "${dotenv.env['IMAGE_FLAG_URL_TEAM']}$teamId.png",
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
                  teamName,
                  style: team.name.compareTo(teamName) == 0 ? TextFacility.getBoldStyleText(12) : TextFacility.getBoldStyleSubText(12),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
              ),
            ],
          ))
        : Expanded(
            child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  teamName,
                  style: team.name.compareTo(teamName) == 0 ? TextFacility.getBoldStyleText(12) : TextFacility.getBoldStyleSubText(12),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
              ),
              const SizedBox(width: 4),
              CachedNetworkImage(
                imageUrl: "${dotenv.env['IMAGE_FLAG_URL_TEAM']}$teamId.png",
                width: 20,
                height: 20,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.sports_soccer),
              ),
            ],
          ));
  }

  Widget _buildScore(String score, String resultString) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(score,
              style: TextStyle(
                  color: _retrieveColorForm(resultString),
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Poppins",
                  decoration: TextDecoration.none)),
        ],
      ),
    );
  }

  _retrieveColorForm(String result) {
    switch (result) {
      case "L":
        return Colors.red;
      case "W":
        return Colors.green;
      case "D":
        return Colors.amber;
      default:
    }
  }

  _retrieveValueTextForm(String result) {
    switch (result) {
      case "L":
        return "P";
      case "W":
        return "V";
      case "D":
        return "N";
      default:
    }
  }
}
