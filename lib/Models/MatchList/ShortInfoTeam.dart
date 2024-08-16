import 'dart:convert';

class ShortInfoTeam {
  int id;
  int score;
  String name;
  int? redCards;
  String longNames;

  ShortInfoTeam({ 
    required this.id,
    required this.score,
    required this.name,
    this.redCards,
    required this.longNames
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'score': score,
      'name': name,
      'redCards': redCards,
      'longNames': longNames
    };
  }
  
  factory ShortInfoTeam.fromMap(Map<String, dynamic> map) {
    return ShortInfoTeam(
      id: map['id'] as int,
      score: map['score'] as int,
      name: map['name'] as String,
      redCards: map['redCards'] == null ? null : map['redCards'] as int,
      longNames: map['longName'] as String
    );
  }

  String toJson() => json.encode(toMap());

  factory ShortInfoTeam.fromJson(String source) => ShortInfoTeam.fromMap(json.decode(source) as Map<String, dynamic>);


}
