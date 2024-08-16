import 'dart:convert';

import 'package:betgram_app/Models/MatchList/LiveTime.dart';
import 'package:betgram_app/Models/MatchList/ShortInfoTeam.dart';
import 'package:betgram_app/Models/MatchList/Status.dart';

class ShortInfoFixture {
  int id;
  int leagueId;
  String time;
  ShortInfoTeam home;
  ShortInfoTeam away;
  int? eliminatedId;
  int statusId;
  String tournamentStage;
  Status? status;
  LiveTime? liveTime;

  ShortInfoFixture({
    required this.id,
    required this.leagueId,
    required this.time,
    required this.home,
    required this.away,
    this.eliminatedId,
    required this.statusId,
    required this.tournamentStage,
    this.status,
    this.liveTime
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'leagueId': leagueId,
      'time': time,
      'home': home,
      'away': away,
      'eliminatedTeamId': eliminatedId,
      'statusId': statusId,
      'tournamentStage': tournamentStage,
      'status': status,
      'liveTime': liveTime
    };
  }
  
  factory ShortInfoFixture.fromMap(Map<String, dynamic> map) {
    return ShortInfoFixture(
      id: map['id'] as int,
      leagueId: map['leagueId'] as int,
      time: map['time'] as String,
      home: ShortInfoTeam.fromMap(map['home'] as Map<String, dynamic>),
      away: ShortInfoTeam.fromMap(map['away'] as Map<String, dynamic>),
      eliminatedId: map['eliminatedTeamId'] == null ? null : map['eliminatedTeamId'] as int,
      statusId: map['statusId'] as int,
      tournamentStage: map['tournamentStage'] as String,
      status: map['status'] == null ? null : Status.fromMap(map['status'] as Map<String, dynamic>),
      liveTime: map['status']['liveTime'] == null ? null : LiveTime.fromMap(map['status']['liveTime'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory ShortInfoFixture.fromJson(String source) => ShortInfoFixture.fromMap(json.decode(source) as Map<String, dynamic>);

}
