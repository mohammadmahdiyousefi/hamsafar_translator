import 'package:flutter/material.dart';

class Country {
  final String name;
  final String language;
  final String flag;
  final String code;
  final TextDirection textDirection;
  Map<String, dynamic> get getMap => {
        "name": name,
        "language": language,
        "flag": flag,
        "code": code,
        "textDirection": textDirection.index
      };
  Country(
      {required this.name,
      required this.language,
      required this.flag,
      required this.code,
      required this.textDirection});

  factory Country.fromjson(Map<String, dynamic> json) {
    return Country(
        name: json['name'],
        language: json['language'],
        flag: json['flag'],
        code: json['code'],
        textDirection:
            json['textDirection'] == 0 ? TextDirection.rtl : TextDirection.ltr);
  }
}
