import 'dart:convert';

class Stadium {
  String? name;
  String? city;
  String? country;


  Stadium({this.name, this.city, this.country});

  factory Stadium.fromMap(Map<String, dynamic> map) {
      return Stadium(
        name: map['name'],
        city: map['city'],
        country: map['country']
      );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'city': city,
      'country': country
    };
  }

  String toJson() => json.encode(toMap());

  factory Stadium.fromJson(String source) => Stadium.fromMap(json.decode(source) as Map<String, dynamic>);


}