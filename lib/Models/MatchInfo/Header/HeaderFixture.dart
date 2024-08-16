import 'dart:convert';

import 'package:betgram_app/Models/MatchList/Status.dart';

import 'HeaderFixtureEvents.dart';
import 'HeaderInfoTeam.dart';

class HeaderFixture {

  List<HeaderInfoTeam> teams;
  Status? status;
  HeaderFixtureEvents? events;

  HeaderFixture({required this.teams, this.status, this.events});

  factory HeaderFixture.fromMap(Map<String, dynamic> json) {
    return HeaderFixture(
      teams: (json['teams'] as List<dynamic>).map<HeaderInfoTeam>((x) => HeaderInfoTeam.fromMap(x as Map<String, dynamic>)).toList(),
      status: json["status"] == null ? null : Status.fromMap(json["status"] as Map<String, dynamic>),
      events: json["events"] == null ? null : HeaderFixtureEvents.fromMap(json["events"]),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'teams': teams.map((x) => x.toMap()).toList(),
      'status': status?.toMap(),
      'events': events?.toMap(),
    };
  }

  String toJson() => json.encode(toMap());

  factory HeaderFixture.fromJson(String source) => HeaderFixture.fromMap(json.decode(source) as Map<String, dynamic>);

}