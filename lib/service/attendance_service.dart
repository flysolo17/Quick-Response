
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../models/attendance_model.dart';
import '../utils/app_url.dart';
class AttendanceService {
  static List<Attendance> parseAttendance(String response) {
    var listResponseBody = json.decode(response) as List<dynamic>;
    List<Attendance> attendanceList = listResponseBody.map((attendance) => Attendance.fromJson(attendance)).toList();
    return attendanceList;
  }
  static Future createAttendance(String title,int subjectId) async {
    var client = http.Client();
    try {
      var response = await client.post(Uri.parse(AppUrl.createAttendanceEndpoint),
          body: json.encode({
            "title" : title,
            "subjectId" : subjectId
          }),
          headers: {
            "Accept" : "application/json",
            "content-type" : "application/json"
          });
      if (response.statusCode != 200) {
        Fluttertoast.showToast(msg: "${response.statusCode} ${response.body}");
      }
      Fluttertoast.showToast(msg: response.body);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      client.close();
    }
  }
  static Future<List<Attendance>> getAllAttendance(int subjectId) async => Future.delayed(const Duration(seconds: 1), () async {
    var client = http.Client();
    try {
      var response = await client.get(Uri.parse("${AppUrl.attendanceEndpoint}/$subjectId"),
          headers: {
            "Accept" : "application/json",
            "content-type" : "application/json"
          });
      if(response.statusCode == 200) {
        return compute(parseAttendance,response.body);
      }else {
        throw Exception();
      }
    } catch(e) {
      throw Exception();
    } finally {
      client.close();
    }
  });
}