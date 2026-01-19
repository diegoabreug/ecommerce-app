// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  String rating;
  String slidecardimage;
  String slideadress;
  String votes;
  String slidecardtitle;

  Welcome({
    required this.rating,
    required this.slidecardimage,
    required this.slideadress,
    required this.votes,
    required this.slidecardtitle,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    rating: json["rating"],
    slidecardimage: json["slidecardimage"],
    slideadress: json["slideadress"],
    votes: json["votes"],
    slidecardtitle: json["slidecardtitle"],
  );

  Map<String, dynamic> toJson() => {
    "rating": rating,
    "slidecardimage": slidecardimage,
    "slideadress": slideadress,
    "votes": votes,
    "slidecardtitle": slidecardtitle,
  };
}