import 'dart:convert';

class HeaderInfoTeam {
  String name;
  int id;
  int score;
  String imageUrl;

  HeaderInfoTeam({required this.name, required this.id, required this.score, required this.imageUrl});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'score': score,
      'imageUrl': imageUrl
    };
  }

  factory HeaderInfoTeam.fromMap(Map<String, dynamic> map) {
    return HeaderInfoTeam(
      name: map['name'] as String,
      id: map['id'] as int,
      score: map['score'] as int,
      imageUrl: map['imageUrl'] as String
    );
  }

  String toJson() => json.encode(toMap());

  factory HeaderInfoTeam.fromJson(String source) => HeaderInfoTeam.fromMap(json.decode(source) as Map<String, dynamic>);
}