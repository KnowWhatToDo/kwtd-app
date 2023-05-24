import 'dart:convert';

Mentee menteeFromJson(String str) => Mentee.fromJson(json.decode(str));

String menteeToJson(Mentee data) => json.encode(data.toJson());

class Mentee {
  String name;
  String currentYear;
  String collegeName;
  String branch;
  String linkedInProfile;
  String email;
  List<dynamic> questions;
  List<dynamic> answers;

  Mentee({
    required this.name,
    required this.currentYear,
    required this.collegeName,
    required this.branch,
    required this.linkedInProfile,
    required this.email,
    required this.questions,
    required this.answers,
  });

  factory Mentee.fromJson(Map<String, dynamic> json) => Mentee(
        name: json["name"],
        currentYear: json["currentYear"],
        collegeName: json["collegeName"],
        branch: json["branch"],
        linkedInProfile: json["linkedInProfile"],
        email: json["email"],
        questions: List<dynamic>.from(json["questions"].map((x) => x)),
        answers: List<dynamic>.from(json["answers"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "currentYear": currentYear,
        "collegeName": collegeName,
        "branch": branch,
        "LinkedInProfile": linkedInProfile,
        "email": email,
        "questions": List<dynamic>.from(questions.map((x) => x)),
        "answers": List<dynamic>.from(answers.map((x) => x)),
      };
}
