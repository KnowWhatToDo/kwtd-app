class Experience {
  String companyName;
  DateTime starDate;
  DateTime endDate;
  int experience;

  Experience({
    required this.companyName,
    required this.starDate,
    required this.endDate,
    required this.experience,
  });

  factory Experience.fromJson(Map<String, dynamic> json) => Experience(
        companyName: json["companyName"],
        starDate: DateTime.parse(json["starDate"]),
        endDate: DateTime.parse(json["endDate"]),
        experience: json["experience"],
      );

  Map<String, dynamic> toJson() => {
        "companyName": companyName,
        "starDate":
            "${starDate.year.toString().padLeft(4, '0')}-${starDate.month.toString().padLeft(2, '0')}-${starDate.day.toString().padLeft(2, '0')}",
        "endDate":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "experience": experience,
      };
}
