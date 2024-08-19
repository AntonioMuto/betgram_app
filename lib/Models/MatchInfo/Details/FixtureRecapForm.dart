import 'dart:convert';

class FixtureRecapForm {
  int? id;
  int? result;
  String? resultString;
  String? data;
  String? score;
  String? homeTeamId;
  String? homeTeamName;
  String? awayTeamId;
  String? awayTeamName;

  FixtureRecapForm(
      {this.id,
      this.result,
      this.resultString,
      this.data,
      this.score,
      this.homeTeamId,
      this.homeTeamName,
      this.awayTeamId,
      this.awayTeamName});

  factory FixtureRecapForm.fromMap(Map<String, dynamic> map) {
    return FixtureRecapForm(
      id: _takeId(map['linkToMatch']) ?? -1,
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

  factory FixtureRecapForm.fromJson(String source) =>
      FixtureRecapForm.fromMap(json.decode(source) as Map<String, dynamic>);

  static _takeId(String link) {
    RegExp regExp = RegExp(r'#(\d+)$');
    Match? match = regExp.firstMatch(link);

    if (match != null) {
      String numbers = match.group(1)!;
      return int.tryParse(numbers);
    } else {
      return -1;
    }
  }
}
