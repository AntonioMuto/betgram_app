import 'dart:convert';

import 'ShortInfoFixture.dart';

class MatchList {
  String countryCode;
  int id;
  int primaryId;
  String name;
  List<ShortInfoFixture> matches;

  MatchList({
    required this.countryCode,
    required this.id,
    required this.primaryId,
    required this.name,
    required this.matches
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ccode': countryCode,
      'id': id,
      'name': name,
      'primaryId': primaryId,
      'matches': matches?.map((x) => x?.toMap()).toList(),
    };
  }

  factory MatchList.fromMap(Map<String, dynamic> map) {
    return MatchList(
      countryCode: map['ccode'] as String,
      id: map['id'] as int,
      primaryId: map['primaryId'] as int,
      name: map['name'] as String,
      matches: (map['matches'] as List<dynamic>).map<ShortInfoFixture>((x) => ShortInfoFixture.fromMap(x as Map<String, dynamic>)).toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory MatchList.fromJson(String source) => MatchList.fromMap(json.decode(source) as Map<String, dynamic>);

}
