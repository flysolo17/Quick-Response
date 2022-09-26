import 'dart:convert';

List<User> userFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  User({
    required this.id,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.type,
    required this.idNumber,
    required this.password,
  });
  int id;
  String firstName;
  String middleName;
  String lastName;
  String type;
  String idNumber;
  String password;
  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json['id'],
      firstName: json["firstName"],
      middleName: json["middleName"],
      lastName: json["lastName"],
      type: json["type"],
      idNumber: json["idNumber"],
      password: json["password"]
  );

  Map<String, dynamic> toJson() => {
    "id" : id,
    "firstName": firstName,
    "middleName": middleName,
    "lastName": lastName,
    "type": type,
    "idNumber": idNumber,
    "password" : password,
  };
}