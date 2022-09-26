import 'dart:convert';

List<CreateAccountRequest> userFromJson(String str) => List<CreateAccountRequest>.from(json.decode(str).map((x) => CreateAccountRequest.fromJson(x)));

String userToJson(List<CreateAccountRequest> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CreateAccountRequest {
  CreateAccountRequest({
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.type,
    required this.idNumber,
    required this.password,
  });

  String firstName;
  String middleName;
  String lastName;
  String type;
  String idNumber;
  String password;
  factory CreateAccountRequest.fromJson(Map<String, dynamic> json) => CreateAccountRequest(
      firstName: json["firstName"],
      middleName: json["middleName"],
      lastName: json["lastName"],
      type: json["type"],
      idNumber: json["idNumber"],
      password: json["password"]
  );

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "middleName": middleName,
    "lastName": lastName,
    "type": type,
    "idNumber": idNumber,
    "password" : password,
  };
}
