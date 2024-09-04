import 'dart:convert';

class Statistics {

  String? title;
  List<dynamic>? stats;
  String? statsHome;
  String? statsAway;
  String? highlighted;

  Statistics({this.title, this.stats, this.statsHome, this.statsAway, this.highlighted});

  factory Statistics.fromMap(Map<String, dynamic> map) {

    return Statistics(
      title: map['title'],
      statsHome: map['stats'] != null ? _formatStats(map['stats'][0].toString()) : "",
      statsAway: map['stats'] != null ? _formatStats(map['stats'][1].toString()) : "",
      highlighted: map['highlighted'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'statsHome': statsHome,
      'statsAway': statsHome,
      'highlighted': highlighted
    };
  }

  String toJson() => json.encode(toMap());

  factory Statistics.fromJson(String source) => Statistics.fromMap(json.decode(source) as Map<String, dynamic>);


  static _formatStats(String stats) {
    List<String> statsList = stats.split(' ');
    if(statsList.isNotEmpty){
      String number = statsList[0];
      return number;
    }
    return stats;
  }

}