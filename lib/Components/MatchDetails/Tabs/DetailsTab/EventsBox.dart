import 'package:betgram_app/Controllers/LiveController.dart';
import 'package:betgram_app/Models/MatchInfo/Details/FixtureEvent.dart';
import 'package:betgram_app/Utility/Costants.dart';
import 'package:betgram_app/Utility/TextFacility.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class EventBox extends StatelessWidget {
  EventBox({super.key});
  final LiveController _liveController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var events = _liveController.matchDetails.value.details?.events ?? [];
      _liveController.matchDetails.value.details?.events?.forEach((element) {});
      return Column(
        children: [
          Center(
            child: Container(
                width: Get.width,
                decoration: BoxDecoration(
                    color: Get.theme.cardColor,
                    borderRadius: const BorderRadius.all(Radius.circular(6))),
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: events.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var event = events[index];
                      return IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: _positionEvent(event),
                          children: [
                            event.isHome == null
                                ? _retrieveTimeEvent(event)
                                : !_isHome(event)
                                    ? _retrieveInfoEvent(event)
                                    : const Text(""),
                            event.isHome == false
                                ? const Padding(
                                    padding: EdgeInsets.only(
                                        top: 10.0, bottom: 10.0),
                                    child: VerticalDivider(
                                      color: Color.fromARGB(255, 81, 81, 81),
                                      thickness: 1,
                                    ),
                                  )
                                : const Text(""),
                            if (event.isHome != null)
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 10, left: 2, right: 2, bottom: 8),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 30,
                                      child: _retrieveImageTypeEvent(event),
                                    ),
                                    _retrieveMinuteEvent(event),
                                  ],
                                ),
                              ),
                            _isHome(event)
                                ? const Padding(
                                    padding: EdgeInsets.only(
                                        top: 10.0, bottom: 10.0),
                                    child: VerticalDivider(
                                      color: Color.fromARGB(255, 81, 81, 81),
                                      thickness: 1,
                                    ),
                                  )
                                : const Text(""),
                            _isHome(event)
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _retrieveInfoEvent(event),
                                    ],
                                  )
                                : const Text("")
                          ],
                        ),
                      );
                    })),
          )
        ],
      );
    });
  }

  _isHome(FixtureEvent? event) {
    if (event != null && event.isHome != null) {
      return event.isHome;
    }
    return false;
  }

  _positionEvent(FixtureEvent? event) {
    if (event?.isHome == true) {
      return MainAxisAlignment.start;
    } else if (event?.isHome == false) {
      return MainAxisAlignment.end;
    } else {
      return MainAxisAlignment.center;
    }
  }

  _retrieveMinuteEvent(FixtureEvent? event) {
    if (event == null) return;

    return event.overloadTime != null && event.overloadTime! > 0
        ? Text("${event.time}' + ${event.overloadTime}'",
            style: const TextStyle(
                color: Color.fromARGB(255, 164, 163, 163), fontSize: 11))
        : Text("${event.time}'",
            style: const TextStyle(
                color: Color.fromARGB(255, 164, 163, 163), fontSize: 14));
  }

  Image _retrieveImageTypeEvent(FixtureEvent? event) {
    switch (event?.type) {
      case "VAR":
        return Image.asset(
          'assets/Images/var.png',
          width: 30,
          height: 35,
          color: Colors.green,
        );
      case "Goal":
        if (event?.goalDescriptionKey == "penalty") {
          return Image.asset(
            'assets/Images/penalty.png',
            width: 35,
            height: 35,
          );
        }
        if (event?.ownGoal ?? false) {
          return Image.asset(
            'assets/Images/goal.png',
            width: 35,
            height: 35,
            color: Colors.red,
          );
        } else {
          return Image.asset(
            'assets/Images/goal.png',
            width: 35,
            height: 35,
            color: Colors.white,
          );
        }
      case "Substitution":
        return Image.asset('assets/Images/substitution.png',
            width: 33, height: 33);
      case "MissedPenalty":
          return Image.asset(
            'assets/Images/missed-penalty.png',
            width: 35,
            height: 35,
          );
      case "Card":
        if (event?.card == "Yellow") {
          return Image.asset(
            'assets/Images/yellow-card.png',
            width: 25,
            height: 25,
          );
        } else if (event?.card == "Red") {
          return Image.asset(
            'assets/Images/red-card.png',
            width: 25,
            height: 25,
          );
        } else if (event?.card == "YellowRed") {
          return Image.asset(
            'assets/Images/yellow-red-card.png',
            width: 25,
            height: 25,
          );
        }
        return Image.network(Costants.URL_NA_IMAGE);
      default:
        return Image.network(
          Costants.URL_NA_IMAGE,
          width: 1,
          height: 1,
        );
    }
  }

  _retrieveInfoEvent(FixtureEvent? event) {
    if (event == null) return;
    return event.type == "Substitution"
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${event.subsitutionPlayerNameIN}",
                style: const TextStyle(color: Colors.white),
              ),
              Text(event.subsitutionPlayerNameOUT ?? "",
                  style: const TextStyle(
                      color: Color.fromARGB(255, 113, 113, 113))),
            ],
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${event.playerName}",
                style: TextStyle(color: Get.theme.primaryColorDark),
              ),
              if (event.assistInput != null)
                Text(event.assistInput ?? "",
                    style: const TextStyle(
                        color: Color.fromARGB(255, 113, 113, 113))),
            ],
          );
  }

  _retrieveTimeEvent(FixtureEvent? event) {
    if (event?.type == "AddedTime") {
      return Column(
        children: [
          Text(
            "${event?.minutesAddedInput.toString() ?? ""} Minuti di Recupero ",
            style: TextFacility.getBoldStyleSubText(15),
          ),
        ],
      );
    } else if (event?.type == "Half") {
      return Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Column(
          children: [
            Container(
              height: 17,
              width: Get.width - 80,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 114, 114, 114),
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              child: Center(child: Text(event?.halfStrShort ?? "", style: TextFacility.getBoldStyleText(13))),
            ),
          ],
        ),
      );
    }
  }
}
