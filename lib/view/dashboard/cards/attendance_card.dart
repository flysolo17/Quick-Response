import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:student_attendance/models/attendance_model.dart';
import 'package:student_attendance/utils/constants.dart';

class AttendanceCard extends StatelessWidget {
  final Attendance? attendance;
  AttendanceCard({Key? key, required this.attendance}) : super(key: key);
  final DateFormat dateFormat = DateFormat("MMM-dd-yyyy");
  @override
  Widget build(BuildContext context) {
    return Card(
      color: purple,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text(attendance?.title?? "No Attendance Title"),
            subtitle: Text(dateFormat.format(attendance!.date)),
          ),
          const Padding(
            padding:  EdgeInsets.all(8.0),
            child:  Align(alignment: Alignment.bottomRight,child:  Text("Attendees: 0")),
          ),
        ],
      ),
    );
  }
}