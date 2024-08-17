class GoalEvent {
  String reactKey;
  int time;
  int? overloadTime;
  String type;
  int playerId;
  String playerName;
  List<int> newScore;
  String? assistStr;


  GoalEvent({
    required this.reactKey,
    required this.time,
    this.overloadTime,
    required this.type,
    required this.playerId,
    required this.playerName,
    required this.newScore,
    this.assistStr,
  });

  factory GoalEvent.fromJson(Map<String, dynamic> json) {
    return GoalEvent(
      reactKey: json['reactKey'],
      time: json['time'],
      overloadTime: json['overloadTime'],
      type: json['type'],
      playerId: json['player']['id'],
      playerName: json['player']['name'],
      newScore: List<int>.from(json['newScore']),
      assistStr: json['assistStr'],
    );
  }
}