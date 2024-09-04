import 'dart:convert';

import 'package:betgram_app/Models/MatchInfo/Statistics/Statistics.dart';

class StatsDetails {
  
  List<Statistics>? all;
  List<Statistics>? firstHalf;
  List<Statistics>? secondHalf;

  StatsDetails({
    this.all,
    this.firstHalf,
    this.secondHalf
  });

  factory StatsDetails.fromMap(Map<String, dynamic> map) {
    return StatsDetails(
    all: map['Periods']['All']['stats'][0]['stats'] != null ? (map['Periods']['All']['stats'][0]['stats'] as List).map((x) => Statistics.fromMap(x)).toList() : [],
    firstHalf: map['Periods']['FirstHalf']['stats'][0]['stats'] != null ? (map['Periods']['FirstHalf']['stats'][0]['stats'] as List).map((x) => Statistics.fromMap(x)).toList() : [],
    secondHalf: map['Periods']['SecondHalf']['stats'][0]['stats'] != null ? (map['Periods']['SecondHalf']['stats'][0]['stats'] as List).map((x) => Statistics.fromMap(x)).toList() : [],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'all': all?.map((x) => x.toMap()).toList(),
      'firstHalf': firstHalf?.map((x) => x.toMap()).toList(),
      'secondHalf': secondHalf?.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  factory StatsDetails.fromJson(String source) => StatsDetails.fromMap(json.decode(source) as Map<String, dynamic>);

}