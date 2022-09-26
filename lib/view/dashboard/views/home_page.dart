import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:student_attendance/models/subject_model.dart';
import 'package:student_attendance/models/user_model.dart';
import 'package:student_attendance/service/auth_service.dart';
import 'package:student_attendance/utils/app_url.dart';
import 'package:student_attendance/service/subject_service.dart';
import 'package:student_attendance/utils/constants.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:http/http.dart' as http;
import 'package:student_attendance/view/dashboard/cards/subject_card.dart';
import 'package:student_attendance/view/dashboard/views/subject_page.dart';
class DashBoardHomePage extends StatefulWidget {
  const DashBoardHomePage({Key? key}) : super(key: key);
  @override
  State<DashBoardHomePage> createState() => _DashBoardHomePageState();
}
class _DashBoardHomePageState extends State<DashBoardHomePage> {
  late SharedPreferences _preferences;
  String token = '';
  int id = 0;
  Future<List<Subjects>>? subjects;
  bool isApiCallProcess = false;
  final TextEditingController _subjectNameController = TextEditingController();
  final TextEditingController _subjectDescController = TextEditingController();
  @override
  void initState() {
    super.initState();
    initPrefs();
  }
  Future initPrefs() async {
    _preferences = await SharedPreferences.getInstance();
    String? token = _preferences.getString("token");
    if(token == null) return;
    setState(() {
      this.token = token;
      getSubject(token);
    });
  }
  Future createSubjectDialog() => showDialog(context: context, builder: (context) => AlertDialog(
    title: const Text("Add a Subject"),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children:[
        TextField(
          controller: _subjectNameController,
          decoration: const InputDecoration(
              hintText: "Name"
          ),
        ),
        TextField(
          controller: _subjectDescController,
          decoration: const InputDecoration(
              hintText: "Description"
          ),
        ),
      ]
    ),
    actions: [
      ElevatedButton(onPressed: (){
        setState(() {
          isApiCallProcess = true;
        });
        String name = _subjectNameController.text.toString();
        String desc = _subjectDescController.text.toString();
        if (name.isNotEmpty) {
          SubjectApiService.createSubject(name, desc,id!, token).then((response) => {
            setState(() {
              isApiCallProcess = false;
              Navigator.of(context).pop();
              _subjectNameController.clear();
            }),
          });
        }
      }, child:const Text("Submit"))
    ],
    )
  );

  @override
  Widget build(BuildContext context) {
    return Container(
        padding:const  EdgeInsets.all(20),
        color: colorSecondary,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(onPressed: (){
                createSubjectDialog();
              }, child:const  Text("Create Subject")),
            ),
            Flexible(
              child: ProgressHUD(key: UniqueKey(),
                  opacity: 0.3,
                  inAsyncCall: isApiCallProcess,
                  child: loadSubjects(token)
              ),
            ),
          ],
        ),
      );
  }
  getSubject(token) async {
    User user = await AuthApiService.getUser(token);
    setState(() {
      id = user.id;
    });
  }
  FutureBuilder<List<Subjects>> loadSubjects(token) {
      return FutureBuilder(
        future:  SubjectApiService.getAllSubjects(id, token),
        builder: (
            BuildContext context,
            AsyncSnapshot<List<Subjects>> model,) {
          if(model.hasError) {
            if(model.hasData == false) {
              return const Text("No Subjects Yet!",style: TextStyle(color: Colors.white),);
            }
            return const Text("error fetching Subjects",style: TextStyle(color: Colors.white),);
          } else if(model.hasData) {
            return gridView(model);
          }
          return circularLoading();
        },
      );
  }
  gridView(AsyncSnapshot<List<Subjects>> snapshot) {
    return Padding(padding: const EdgeInsets.all(10.0),
    child: GridView.count(crossAxisCount: 4,
    childAspectRatio: (1 / .3),
    mainAxisSpacing: 10,
    crossAxisSpacing: 10,
    children: snapshot.data!.reversed.map((subject) {
          return GestureDetector(
              onTap: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) =>  SubjectPage(subjects: subject,onDelete: deleteSubject,onUpdate: updateSubject,token: token,)));
              },
              child: SubjectCard(subjects: subject));
        }).toList(),
      ),
    );
  }

  circularLoading() {
    return const Center(child: CircularProgressIndicator(),);
  }
  deleteSubject(int subjectId,String token) {
    setState(() {
      isApiCallProcess = true;
    });
    SubjectApiService.deleteSubject(subjectId, token);
    setState(() {
      isApiCallProcess = false;
    });
  }
  updateSubject(int subjectId,String name,String desc,String token) {
    setState(() {
      isApiCallProcess = true;
    });
    SubjectApiService.updateSubject(name,desc, subjectId, token);
    setState(() {
      isApiCallProcess = false;
    });
  }

}
