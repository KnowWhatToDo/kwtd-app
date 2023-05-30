import 'dart:convert';

import 'package:kwtd/models/experience.dart';

Mentor mentorFromJson(String str) => Mentor.fromJson(json.decode(str));

String mentorToJson(Mentor data) => json.encode(data.toJson());

class Mentor {
  String name;
  List<Experience> experiences;
  String collegeName;
  List<String> skills;
  int wallet;
  bool isVerified;

  Mentor({
    required this.name,
    required this.experiences,
    required this.collegeName,
    required this.skills,
    required this.wallet,
    required this.isVerified,
  });

  factory Mentor.fromJson(Map<String, dynamic> json) => Mentor(
        name: json["name"],
        experiences: List<Experience>.from(
            json["experiences"].map((x) => Experience.fromJson(x))),
        collegeName: json["collegeName"],
        skills: List<String>.from(json["skills"].map((x) => x)),
        wallet: json["wallet"],
        isVerified: json["verified"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "experiences": List<dynamic>.from(experiences.map((x) => x.toJson())),
        "collegeName": collegeName,
        "skills": List<dynamic>.from(skills.map((x) => x)),
        "wallet": wallet,
        "isVerified": isVerified,
      };
}
