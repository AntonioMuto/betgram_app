import 'dart:convert';

class Highlights {
  String? image;
  String? url;
  String? source;

  Highlights({this.image, this.url, this.source});

    factory Highlights.fromMap(Map<String, dynamic> map) {
    return Highlights(
      image: map['image'] as String,
      url: map['url'] as String,
      source: map['source'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image': image,
      'url': url,
      'source': source
    };
  }

  String toJson() => json.encode(toMap());

  factory Highlights.fromJson(String source) => Highlights.fromMap(json.decode(source) as Map<String, dynamic>);

}