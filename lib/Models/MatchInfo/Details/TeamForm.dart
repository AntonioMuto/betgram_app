import 'dart:convert';

import '../Header/HeaderInfoTeam.dart';
import 'FixtureRecapForm.dart';

class TeamForm {
  List<FixtureRecapForm>? fixtureHome;
  List<FixtureRecapForm>? fixtureAway;

  TeamForm({
    this.fixtureHome,
    this.fixtureAway,
  });

  factory TeamForm.fromMap(List<dynamic> map) {
    return TeamForm(
      fixtureHome: (map[0] as List<dynamic>).map<FixtureRecapForm>((x) => FixtureRecapForm.fromMap(x as Map<String, dynamic>)).toList(),
      fixtureAway: (map[1] as List<dynamic>).map<FixtureRecapForm>((x) => FixtureRecapForm.fromMap(x as Map<String, dynamic>)).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fixtureHome': fixtureHome?.map((x) => x.toMap()).toList(),
      'fixtureAway': fixtureAway?.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  factory TeamForm.fromJson(String source) => TeamForm.fromMap(json.decode(source) as List<dynamic>);

}