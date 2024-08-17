import 'dart:convert';

import 'FixtureEvent.dart';
import 'Stadium.dart';
import 'TeamForm.dart';

class FixtureInfoDetails{
  List<FixtureEvent>? events;
  int? leagueId;
  String? leagueName;
  String? round;
  String? selectedSeason;
  Stadium? stadium;
  TeamForm? teamForm;

  FixtureInfoDetails({this.events, this.leagueId, this.leagueName, this.round, this.selectedSeason, this.stadium, this.teamForm});

  factory FixtureInfoDetails.fromMap(Map<String, dynamic> map) {
    FixtureInfoDetails x = FixtureInfoDetails(
    events: map['events']['events'] != null ? (map['events']['events'] as List).map((x) => FixtureEvent.fromMap(x)).toList() : null,
    leagueId: map['infoBox']['Tournament']['id'],
    leagueName: map['infoBox']['Tournament']['leagueName'],
    round: map['infoBox']['Tournament']['round'],
    selectedSeason: map['infoBox']['Tournament']['selectedSeason'],
    stadium: map['stadium'] != null ? Stadium.fromMap(map['stadium']) : null,
    teamForm: map['teamForm'] != null ? TeamForm.fromMap(map['teamForm']) : null,
    );
    return x;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'events': events?.map((x) => x.toMap()).toList(),
      'leagueId': leagueId,
      'leagueName': leagueName,
      'round': round,
      'selectedSeason': selectedSeason,
      'stadium': stadium?.toMap(),
      'teamForm': teamForm
    };
  }

  String toJson() => json.encode(toMap());

  factory FixtureInfoDetails.fromJson(String source) => FixtureInfoDetails.fromMap(json.decode(source) as Map<String, dynamic>);

      

}