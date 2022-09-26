import 'package:flutter/material.dart';
import 'package:student_attendance/models/subject_model.dart';
import 'package:student_attendance/utils/constants.dart';

class SubjectCard extends StatelessWidget {
  final Subjects? subjects;
  const SubjectCard({Key? key, required this.subjects}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      color: purple,
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.book),
            title:  Text(subjects?.name ?? "No name" ),
            subtitle: Text(
              subjects?.desc ?? "No Subject description",
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
        ],
      ),
    );
  }
}
