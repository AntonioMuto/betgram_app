import 'dart:convert';

class Statistics {

  String? title;
  List<int>? stats;
  String? highlighted;

  Statistics({this.title, this.stats, this.highlighted});

  factory Statistics.fromMap(Map<String, dynamic> map) {
    print(map);
    return Statistics(
      title: map['title'],
      stats: map['stats'],
      highlighted: map['highlighted'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'stats': stats,
      'highlighted': highlighted
    };
  }

  String toJson() => json.encode(toMap());

  factory Statistics.fromJson(String source) => Statistics.fromMap(json.decode(source) as Map<String, dynamic>);

}