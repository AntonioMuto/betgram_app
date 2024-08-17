import 'dart:convert';

class FixtureRecapForm {
  
  int? result;
  String? resultString;
  String? data;
  String? score;
  String? homeTeamId;
  String? homeTeamName;
  String? awayTeamId;
  String? awayTeamName;

  FixtureRecapForm({
    this.result,
    this.resultString,
    this.data,
    this.score,
    this.homeTeamId,
    this.homeTeamName,
    this.awayTeamId,
    this.awayTeamName
  });

  factory FixtureRecapForm.fromMap(Map<String, dynamic> map) {
      return FixtureRecapForm(
        result: map['result'],
        resultString: map['resultString'],
        data: map['date']['utcTime'],
        score: map['score'],
        homeTeamId: map['home']['id'],
        homeTeamName: map['home']['name'],
        awayTeamId: map['away']['id'],
        awayTeamName: map['away']['name'],
      );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'result': result,
      'resultString': resultString,
      'data': data,
      'score': score,
      'homeTeamId': homeTeamId,
      'homeTeamName': homeTeamName,
      'awayTeamId': awayTeamId,
      'awayTeamName': awayTeamName
    };
  }

  String toJson() => json.encode(toMap());

  factory FixtureRecapForm.fromJson(String source) => FixtureRecapForm.fromMap(json.decode(source) as Map<String, dynamic>);

}