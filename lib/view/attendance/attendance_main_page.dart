import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:student_attendance/models/attendance_model.dart';
import 'package:student_attendance/service/attendance_service.dart';
import 'package:student_attendance/utils/constants.dart';
import 'package:student_attendance/view/dashboard/cards/attendance_card.dart';

class AttendanceMainPage extends StatefulWidget {
  final int subjectId;
  const AttendanceMainPage({Key? key,required this.subjectId}) : super(key: key);
  @override
  State<AttendanceMainPage> createState() => _AttendanceMainPageState();
}
class _AttendanceMainPageState extends State<AttendanceMainPage> {
  final TextEditingController _attendanceTitleController = TextEditingController();
  bool isApiCallProcess = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorPrimary,
        floatingActionButton:FloatingActionButton.extended(
          backgroundColor: const Color(0xff03dac6),
          foregroundColor: Colors.black,
          onPressed: () {
            createAttendance();
          },
          icon: const Icon(Icons.add),
          label: const Text('Create Attendance'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: ProgressHUD(key: UniqueKey(),
                  opacity: 0.3,
                  inAsyncCall: isApiCallProcess,
                  child:FutureBuilder(
                    future: AttendanceService.getAllAttendance(widget.subjectId),
                    builder: (
                        BuildContext context,
                        AsyncSnapshot<List<Attendance>?> model,) {
                      if(model.hasError) {
                        if(model.hasData == false) {
                          return Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                              SvgPicture.asset('noattendance.svg',width: 200,height: 200,),
                              const Padding(
                                padding: EdgeInsets.all(10),
                                child:  Text("Click add to create an attendance!",style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.normal)),
                              ),
                            ]),
                          );
                        }
                        return const Center(child: Text("error fetching Attendance",style: TextStyle(color: Colors.white),));
                      } else if(model.hasData) {
                        return gridView(model);
                      }
                      return circularLoading();
                    },
                  )
              ),
            ),
          ]
        ),
    );
  }
  gridView(AsyncSnapshot<List<Attendance>?> snapshot) {
    return Padding(padding: const EdgeInsets.all(10.0),
      child: GridView.count(crossAxisCount: getScreenSize(),
        childAspectRatio: (1 / .3),
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: snapshot.data!.reversed.map((attendance) {
          return GestureDetector(
              onTap: () {
                Fluttertoast.showToast(msg: attendance.title);
              },
              child: AttendanceCard(attendance: attendance));
        }).toList(),
      ),
    );
  }
  Future createAttendance() => showDialog(context: context, builder: (context) => AlertDialog(
    title: const Text("Add a Attendance"),
    content: TextField(
      controller: _attendanceTitleController,
      decoration: const InputDecoration(
          hintText: "Title"
      ),
    ),
    actions: [
      ElevatedButton(onPressed: (){
        setState(() {
          isApiCallProcess = true;
        });
        String name = _attendanceTitleController.text.toString();
        if (name.isNotEmpty) {
          AttendanceService.createAttendance(name, widget.subjectId).then((value) => {
            setState(() {
              isApiCallProcess = false;
            }),
            Navigator.of(context).pop(),
          });
        }
      }, child:const  Text("Submit"))
    ],
    )
  );
  circularLoading() {
    return const Center(child: CircularProgressIndicator(),);
  }
  int getScreenSize() {
    if(MediaQuery.of(context).size.width > 1500) {
      return 4;
    } else if (MediaQuery.of(context).size.width < 1500 && MediaQuery.of(context).size.width > 1080){
      return 3;
    }  else if (MediaQuery.of(context).size.width < 1080 && MediaQuery.of(context).size.width > 900){
      return 2;
    }else {
      return 1;
    }
  }
}
