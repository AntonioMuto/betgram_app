import 'dart:convert';

class LiveTime {
  String short;
  String long;
  int maxTime;
  int addedTime;

  LiveTime({required this.short, required this.long, required this.maxTime, required this.addedTime});

  factory LiveTime.fromMap(Map<String, dynamic> map) {
    return LiveTime(
      short: map['short'] as String,
      long: map['long'] as String,
      maxTime: map['maxTime'] as int,
      addedTime: map['addedTime'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'short': short,
      'long': long,
      'maxTime': maxTime,
      'addedTime': addedTime,
    };
  }

  String toJson() => json.encode(toMap());

  factory LiveTime.fromJson(String source) => LiveTime.fromMap(json.decode(source) as Map<String, dynamic>);

}