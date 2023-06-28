import 'dart:convert';

Mentee menteeFromJson(String str) => Mentee.fromJson(json.decode(str));

String menteeToJson(Mentee data) => json.encode(data.toJson());

class Mentee {
  String name;
  String phone;
  String email;
  String collegeName;
  String collegeYear;
  String collegeBranch;
  String linkedInProfile;
  List<String> questions;
  List<String> answers;
  List<String> mentors;
  List<String> meetings;

  Mentee({
    required this.name,
    required this.phone,
    required this.email,
    required this.collegeName,
    required this.collegeYear,
    required this.collegeBranch,
    required this.linkedInProfile,
    required this.questions,
    required this.answers,
    required this.mentors,
    required this.meetings,
  });

  factory Mentee.fromJson(Map<String, dynamic> json) => Mentee(
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        collegeName: json["collegeName"],
        collegeYear: json["collegeYear"],
        collegeBranch: json["collegeBranch"],
        linkedInProfile: json["linkedInProfile"] ?? "",
        questions: List<String>.from(json["questions"].map((x) => x)),
        answers: List<String>.from(json["answers"].map((x) => x)),
        mentors: List<String>.from(json["mentors"].map((x) => x)),
        meetings: List<String>.from(json["meetings"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "email": email,
        "collegeName": collegeName,
        "collegeYear": collegeYear,
        "collegeBranch": collegeBranch,
        "linkedInProfile": linkedInProfile,
        "questions": List<dynamic>.from(questions.map((x) => x)),
        "answers": List<dynamic>.from(answers.map((x) => x)),
        "mentors": List<dynamic>.from(mentors.map((x) => x)),
        "meetings": List<dynamic>.from(meetings.map((x) => x)),
      };

  bool isRegistered() {
    if (email == ' ' ||
        collegeName == ' ' ||
        linkedInProfile == ' ' ||
        answers.isEmpty) {
      return false;
    }
    return true;
  }
}
