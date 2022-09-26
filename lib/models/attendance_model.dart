import 'dart:convert';

List<Attendance> attendanceFromJson(String str) => List<Attendance>.from(json.decode(str).map((x) => Attendance.fromJson(x)));

String attendanceToJson(List<Attendance> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Attendance {
  Attendance({
    required this.id,
    required this.title,
    required this.date,
    required this.subjectId,
    required this.code,
    required this.isOpen,
  });

  int id;
  String title;
  DateTime date;
  int subjectId;
  String code;
  bool isOpen;

  factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
    id: json["id"],
    title: json["title"],
    date: DateTime.parse(json["date"]),
    subjectId: json["subjectId"],
    code: json["code"],
    isOpen: json["isOpen"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "subjectId": subjectId,
    "code": code,
    "isOpen": isOpen,
  };
}
