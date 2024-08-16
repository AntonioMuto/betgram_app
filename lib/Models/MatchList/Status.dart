import 'dart:convert';

class Status {
  bool? finished;
  bool? started;
  bool? cancelled;
  bool? awarded;
  bool? ongoing;
  String? scoreStr;
  String? short;

  Status(
      { this.finished,
       this.started,
       this.cancelled,
       this.ongoing,
       this.awarded,
       this.scoreStr,
       this.short});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'finished': finished,
      'started': started,
      'cancelled': cancelled,
      'ongoing': ongoing,
      'awarded': awarded,
      'scoreStr': scoreStr,
      'short': short,
    };
  }
  
  factory Status.fromMap(Map<String, dynamic> map) {
    return Status(
      finished: map['finished'] == null ? null : map['finished'] as bool,
      started: map['started'] == null ? null : map['started'] as bool,
      cancelled: map['cancelled'] == null ? null : map['cancelled'] as bool,
      ongoing: map['ongoing'] == null ? null : map['ongoing'] as bool,
      awarded: map['awarded'] == null ? null : map['awarded'] as bool,
      scoreStr: map['scoreStr'] == null ? null : map['scoreStr'] as String,
      short: _takeShort(map)
    );
  }

  String toJson() => json.encode(toMap());

  factory Status.fromJson(String source) => Status.fromMap(json.decode(source) as Map<String, dynamic>);

  static _takeShort(Map<String, dynamic> map){
    if(map['liveTime'] != null){
      return map['liveTime']['short'] as String;
    } else {
     return map['reason'] == null ? null : map['reason']['short'] as String;
    }
  }

}
