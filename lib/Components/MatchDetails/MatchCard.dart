import 'dart:math';

import 'package:betgram_app/Utility/Costants.dart';
import 'package:betgram_app/Utility/TextFacility.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../Controllers/LiveController.dart';
import '../../Models/MatchInfo/Header/GoalEvent.dart';
import '../../Models/MatchList/ShortInfoFixture.dart';

class MatchCard extends StatelessWidget {
  final ShortInfoFixture match;
  const MatchCard({super.key, required this.match});
  static final LiveController _liveController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var header = _liveController.matchDetails.value.header;
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 15),
                child: _buildTeamInfo(
                    header?.teams[0].imageUrl ?? Costants.URL_NA_IMAGE,
                    header?.teams[0].name ?? Costants.URL_NA_IMAGE,
                    true),
              ),
              Column(
                children: [
                  Text(
                    header?.status?.scoreStr ?? "CIAO",
                    style: TextStyle(
                      color: header?.status?.ongoing == true
                          ? Colors.red
                          : Get.theme.primaryColorDark,
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
                      color: header?.status?.ongoing == true
                          ? Colors.red
                          : Get.theme.primaryColorDark,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0, top: 15),
                child: _buildTeamInfo(
                    header?.teams[1].imageUrl ?? Costants.URL_NA_IMAGE,
                    header?.teams[1].name ?? Costants.URL_NA_IMAGE,
                    false),
              ),
            ],
          ),
        ],
      );
    });
  }

  Widget _buildTeamInfo(String flagUrl, String teamName, bool isHome) {
  return Container(
    width: Get.width * 0.30,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CachedNetworkImage(
          imageUrl: flagUrl,
          width: 50,
          height: 50,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error, size: 40),
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
        // Avvolgi ListView.builder in un widget che limita la sua altezza
        Container(
          height: (_retrieveMaxEventsTeam() ?? 0) * 20.0,  // Imposta un'altezza fissa per il ListView
          child: ListView.builder(
            itemCount: isHome
                ? _liveController.matchDetails.value.header?.events?.homeTeamGoals.length
                : _liveController.matchDetails.value.header?.events?.awayTeamGoals.length,
            itemBuilder: (context, index) {
              var events = isHome
                  ? _liveController.matchDetails.value.header?.events?.homeTeamGoals
                  : _liveController.matchDetails.value.header?.events?.awayTeamGoals;
              String key = events!.keys.elementAt(index);
              final event = events[key];
              return Text(_retrieveValueGoal(event), style: TextFacility.getBoldStyleSubText(10), textAlign: TextAlign.center);
            },
          ),
        )
      ],
    ),
  );
}

  String _retrieveValueGoal(List<GoalEvent>? events) {
  if (events != null && events.isNotEmpty) {
    // Se c'è un solo evento, restituisci la stringa "name, time"
    if (events.length == 1) {
      final goal = events.first;
      return "${goal.playerName}, ${goal.time}";
    } 
    
    // Se ci sono più eventi, concatenare i tempi in una stringa
    else {
      final goal = events.first; // prendi il primo evento per il nome
      final times = events.map((event) => event.time).join(" ");
      return "${goal.playerName}, $times";
    }
  }
  
  // Restituisce una stringa vuota se l'elenco degli eventi è nullo o vuoto
  return "";
}

  _retrieveMaxEventsTeam() {
    double awayGoalsLength = _liveController.matchDetails.value.header?.events?.awayTeamGoals?.length.toDouble() ?? 0.0;
    double homeGoalsLength = _liveController.matchDetails.value.header?.events?.homeTeamGoals?.length.toDouble() ?? 0.0;
    return max(awayGoalsLength, homeGoalsLength);
  }

}