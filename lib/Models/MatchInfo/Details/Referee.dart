import 'dart:convert';

class Referee {

  String? name;
  String? country;
  String? imageUrl;
  

  Referee({this.name, this.country, this.imageUrl});

  factory Referee.fromMap(Map<String, dynamic> map) {
    return Referee(
      name: map['name'],
      country: map['country'],
      imageUrl: map['imageUrl'],
    );
  }

  Map<String, dynamic> toMap() {  
    return <String, dynamic>{
      'name': name,
      'country': country,
      'imageUrl': imageUrl
    };
  }

  String toJson() => json.encode(toMap());

  factory Referee.fromJson(String source) => Referee.fromMap(json.decode(source) as Map<String, dynamic>);

}