import 'dart:convert';

List<Subjects> subjectsFromJson(String str) => List<Subjects>.from(json.decode(str).map((x) => Subjects.fromJson(x)));

String subjectsToJson(List<Subjects> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Subjects {
  Subjects({
    required this.id,
    required this.name,
    required this.desc,
    required this.createdAt,
    required this.userId,
  });

  int id;
  String name;
  String desc;
  DateTime createdAt;
  int userId;

  factory Subjects.fromJson(Map<String, dynamic> json) => Subjects(
    id: json["id"],
    name: json["name"],
    desc: json["desc"],
    createdAt: DateTime.parse(json["createdAt"]),
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "desc": desc,
    "createdAt": "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
    "userId": userId,
  };
}

