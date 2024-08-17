import 'dart:convert';

import 'package:betgram_app/Models/MatchInfo/Header/Highlights.dart';

import 'Details/FixtureInfoDetails.dart';
import 'Header/HeaderFixture.dart';

class FixtureInfo {

  int? matchId;
  Highlights? highlights;
  HeaderFixture? header;
  FixtureInfoDetails? details;

  FixtureInfo({
    this.matchId,
    this.highlights,
    this.header,
    this.details
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'matchId': matchId,
      'highlights': highlights?.toMap(),
      'header': header?.toMap(),
      'details': details?.toMap(),
    };
  }
  
  factory FixtureInfo.fromMap(Map<String, dynamic> map) {
    return FixtureInfo(
      matchId: map['matchId'] as int,
      highlights: map['highlights'] == null ? null : Highlights.fromMap(map['highlights']),
      header: map['header']== null ? null : HeaderFixture.fromMap(map['header']),
      details: FixtureInfoDetails.fromMap(map),
    );
  }

  String toJson() => json.encode(toMap());

  factory FixtureInfo.fromJson(String source) => FixtureInfo.fromMap(json.decode(source));
  
}