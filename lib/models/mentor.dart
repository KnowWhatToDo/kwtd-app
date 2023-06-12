import 'dart:convert';

Mentor mentorFromJson(String str) => Mentor.fromJson(json.decode(str));

String mentorToJson(Mentor data) => json.encode(data.toJson());

class Mentor {
    String phone;
    String name;
    String collegeName;
    List<String> skills;
    String email;
    String linkedinUrl;
    double experience;
    bool isVerified;

    Mentor({
        required this.phone,
        required this.name,
        required this.collegeName,
        required this.skills,
        required this.email,
        required this.linkedinUrl,
        required this.experience,
        required this.isVerified,
    });

    factory Mentor.fromJson(Map<String, dynamic> json) => Mentor(
        phone: json["phone"],
        name: json["name"],
        collegeName: json["collegeName"],
        skills: List<String>.from(json["skills"].map((x) => x)),
        email: json["email"],
        linkedinUrl: json["linkedinUrl"],
        experience: json["experience"].toDouble(),
        isVerified: json["isVerified"],
    );

    Map<String, dynamic> toJson() => {
        "phone": phone,
        "name": name,
        "collegeName": collegeName,
        "skills": List<dynamic>.from(skills.map((x) => x)),
        "email": email,
        "linkedinUrl": linkedinUrl,
        "experience": experience,
        "isVerified": isVerified,
    };
}
