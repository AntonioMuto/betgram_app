import 'dart:convert';

class FixtureEvent {
  
  int? eventId;
  int? time;
  int? overloadTime;
  String? type;
  int? playerId;
  String? playerName;
  bool? isHome;
  String? card;
  int? minutesAddedInput;
  bool? injuredPlayerOut;
  String? subsitutionPlayerIdIN;
  String? subsitutionPlayerNameIN; 
  String? subsitutionPlayerIdOUT;
  String? subsitutionPlayerNameOUT;
  bool? ownGoal;
  String? nameStr;
  List<int>? newScore;
  String? assistInput;
  String? goalDescriptionKey;
  String? varEventType;
  String? varEventReason;
  String? halfStrShort;


  FixtureEvent({
    this.eventId,
    this.time,
    this.overloadTime,
    this.type,
    this.playerId,
    this.playerName,
    this.isHome,
    this.card,
    this.minutesAddedInput,
    this.injuredPlayerOut,
    this.subsitutionPlayerIdIN,
    this.subsitutionPlayerNameIN,
    this.subsitutionPlayerIdOUT,
    this.subsitutionPlayerNameOUT,
    this.ownGoal,
    this.nameStr,
    this.newScore,
    this.assistInput,
    this.goalDescriptionKey,
    this.varEventType,
    this.varEventReason,
    this.halfStrShort
  });


  factory FixtureEvent.fromMap(Map<String, dynamic> map) {
    FixtureEvent x = FixtureEvent(
      eventId: map['eventId'],
      time: map['time'],
      overloadTime: map['overloadTime'],
      type: map['type'],
      playerId: map['player']['id'],
      playerName: map['player']['name'],
      isHome: map['isHome'],
      card: map['card'],
      minutesAddedInput: map['minutesAddedInput'],
      injuredPlayerOut: map['injuredPlayerOut'],
      subsitutionPlayerIdIN: map['swap']?[0]['id'],
      subsitutionPlayerNameIN: map['swap']?[0]['name'],
      subsitutionPlayerIdOUT: map['swap']?[1]['id'],
      subsitutionPlayerNameOUT: map['swap']?[1]['name'],
      ownGoal: map['ownGoal'],
      nameStr: map['nameStr'],
      newScore: map['newScore'] != null ? (map['newScore'] as List<dynamic>).map<int>((x) => x as int).toList() : [],
      assistInput: map['assistInput'],
      goalDescriptionKey: map['goalDescriptionKey'],
      varEventType: null,
      varEventReason: map['VAR']?['decision']?['value']?[0],
      halfStrShort: map['halfStrShort']
    );
    return x;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'eventId': eventId,
      'time': time,
      'overloadTime': overloadTime,
      'type': type,
      'playerId': playerId,
      'playerName': playerName,
      'isHome': isHome,
      'card': card,
      'minutesAddedInput': minutesAddedInput,
      'injuredPlayerOut': injuredPlayerOut,
      'subsitutionPlayerIdIN': subsitutionPlayerIdIN,
      'subsitutionPlayerNameIN': subsitutionPlayerNameIN,
      'subsitutionPlayerIdOUT': subsitutionPlayerIdOUT,
      'subsitutionPlayerNameOUT': subsitutionPlayerNameOUT,
      'ownGoal': ownGoal,
      'nameStr': nameStr,
      'newScore': newScore,
      'assistInput': assistInput,
      'goalDescriptionKey': goalDescriptionKey,
      'varEventType': varEventType,
      'varEventReason': varEventReason,
      'halfStrShort': halfStrShort
    };
  }

  String toJson() => json.encode(toMap());

  factory FixtureEvent.fromJson(String source) => FixtureEvent.fromMap(json.decode(source) as Map<String, dynamic>);

}