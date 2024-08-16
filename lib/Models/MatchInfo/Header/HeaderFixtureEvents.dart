import 'dart:convert';

import 'GoalEvent.dart';

class HeaderFixtureEvents {
  
  final Map<String, List<GoalEvent>> homeTeamGoals;
  final Map<String, List<GoalEvent>> awayTeamGoals;


   HeaderFixtureEvents({
    required this.homeTeamGoals,
    required this.awayTeamGoals,
  });

  factory HeaderFixtureEvents.fromMap(Map<String, dynamic> json) {
    return HeaderFixtureEvents(
      homeTeamGoals: (json['homeTeamGoals'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(
          key,
          (value as List).map((e) => GoalEvent.fromJson(e)).toList(),
        ),
      ),
      awayTeamGoals: (json['awayTeamGoals'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(
          key,
          (value as List).map((e) => GoalEvent.fromJson(e)).toList(),
        ),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'homeTeamGoals': homeTeamGoals,
      'awayTeamGoals': awayTeamGoals,
    };
  }

  String toJson() => json.encode(toMap());

  factory HeaderFixtureEvents.fromJson(String source) => HeaderFixtureEvents.fromMap(json.decode(source) as Map<String, dynamic>);

}