

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:student_attendance/utils/app_url.dart';
import '../models/subject_model.dart';

class SubjectApiService {

    static List<Subjects> parseSubjects(String response) {
      var listResponseBody = json.decode(response) as List<dynamic>;
      List<Subjects> subjects = listResponseBody.map((subject) => Subjects.fromJson(subject)).toList();
      return subjects;
    }

    static Future<List<Subjects>> getAllSubjects(int userId,String token) async => Future.delayed(const Duration(milliseconds: 2000), () async {
        var client = http.Client();
        try {
          var response = await client.get(Uri.parse("${AppUrl.subjectEndpoint}/$userId"),
              headers: {
                "Authorization" : "Bearer $token",
                "Accept" : "application/json",
                "content-type" : "application/json"
              });
          if(response.statusCode == 200) {
            return compute(parseSubjects,response.body);
          }else {
            throw Exception();
          }
        } catch(e) {
          throw Exception();
        } finally {
          client.close();
        }
      });

    static Future createSubject(String name,String desc, int userId,String token) async {
        var client = http.Client();
        try {
          var response = await client.post(Uri.parse(AppUrl.createSubjectEndpoint),
              body: json.encode({
                "name": name,
                "desc" : desc,
                "userId": userId
              }),
              headers: {
                "Authorization" : "Bearer $token",
                "Accept" : "application/json",
                "content-type": "application/json"
              });
          if (response.statusCode != 200) {
            Fluttertoast.showToast(msg: "${response.statusCode}  ${response.body}",toastLength: Toast.LENGTH_LONG);
          }
          Fluttertoast.showToast(msg: response.body);
        } catch(e) {
          Fluttertoast.showToast(msg: e.toString());
        }finally {
          client.close();
        }
    }
    static Future deleteSubject(int subjectId,String token) async {
        var client = http.Client();
        try {
          var response = await client.delete(Uri.parse("${AppUrl.subjectEndpoint}/$subjectId"),
              headers: {
                "Authorization" : "Bearer $token",
                "Accept" : "application/json",
                "content-type": "application/json"
              });
          Fluttertoast.showToast(msg: response.body);
        } catch(e) {
          Fluttertoast.showToast(msg: e.toString());
        }finally {
          client.close();
        }
    }
    static Future updateSubject(String name, String desc,int subjectID,String token) async {
        var client = http.Client();
        try {
          var response = await client.patch(Uri.parse("${AppUrl.subjectEndpoint}/$subjectID"),
              body: json.encode({
                "name": name,
                "desc" : desc
              }),
              headers: {
                "Authorization" : "Bearer $token",
                "Accept" : "application/json",
                "content-type": "application/json"
              });
          if (response.statusCode == 200) {
            Fluttertoast.showToast(msg: response.body);
          }
        } catch(e) {
          Fluttertoast.showToast(msg: e.toString());
        }finally {
          client.close();
        }
    }
}