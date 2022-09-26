import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:student_attendance/models/user_model.dart';
import 'package:student_attendance/utils/app_url.dart';

class AuthApiService {
  static Future<void> login(String idNumber,String password) async {
    var client = http.Client();
    try {
      var response = await client.post(Uri.parse("http://127.0.0.1:8080/auth/login"),
          body: json.encode({
            "idNumber": idNumber,
            "password": password
          }),
          headers: {
            "Accept": "application/json",
            "content-type": "application/json"
          });
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: "Successfully Logged in!",  // message
          toastLength: Toast.LENGTH_LONG, // length
          gravity: ToastGravity.CENTER,
        );

      } else {
        Fluttertoast.showToast(
          msg: "Error: ${response.statusCode} ${response.body}",  // message
          toastLength: Toast.LENGTH_LONG, // length
          gravity: ToastGravity.CENTER,
        );
      }
    } finally {
      client.close();
    }
  }
  static Future<User> getUser(String token) async {
    var client = http.Client();
    try {
      var response = await client.get(Uri.parse(AppUrl.secretEndpoint),
          headers: {
            "Authorization" : "Bearer $token",
            "Accept" : "application/json",
            "content-type": "application/json"
          });
      if (response.statusCode == 200) {
        var user = json.decode(response.body);
        return User.fromJson(user);
      } else {
        throw Exception();
      }
    } catch(e) {
      throw Exception();
    }finally {
      client.close();
    }
  }

}