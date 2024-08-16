class GoalEvent {
  final String reactKey;
  final int time;
  final String type;
  final int playerId;
  final String playerName;
  final List<int> newScore;
  final String? assistStr;

  GoalEvent({
    required this.reactKey,
    required this.time,
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
      type: json['type'],
      playerId: json['player']['id'],
      playerName: json['player']['name'],
      newScore: List<int>.from(json['newScore']),
      assistStr: json['assistStr'],
    );
  }
}