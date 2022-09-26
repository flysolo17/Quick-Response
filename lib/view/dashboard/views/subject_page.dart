import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:student_attendance/models/subject_model.dart';

import 'package:student_attendance/utils/constants.dart';
import 'package:student_attendance/view/attendance/attendance_main_page.dart';

class SubjectPage extends StatefulWidget {
  final Subjects? subjects;
  final Function? onDelete;
  final Function? onUpdate;
  final String token;
  const SubjectPage({Key? key,required this.subjects,required this.onDelete,required this.token, required this.onUpdate}) : super(key: key);
  @override
  State<SubjectPage> createState() => _SubjectPageState();
}
class _SubjectPageState extends State<SubjectPage> {
  late final TextEditingController _subjectNameController = TextEditingController();
  late final TextEditingController _subjectDescController = TextEditingController();
  final DateFormat dateFormat = DateFormat("MMM-dd-yyyy");
  @override
  Widget build(BuildContext context) {
    _subjectNameController.text = widget.subjects!.name;
    _subjectDescController.text = widget.subjects!.desc;
     return Scaffold(
       appBar: AppBar(title: Text(widget.subjects?.name ?? "no subject name"),
       backgroundColor: colorPrimary,),
         body: Row(
           children: [
             Expanded(child: Container(
               color: colorSecondary,
               child: Padding(
                 padding: const EdgeInsets.all(10),
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     const SizedBox(height: 10,),
                     const Text("Subject Name" ,style: TextStyle(
                       color: Colors.white,
                       fontSize: 16,
                       fontWeight: FontWeight.normal
                     ),),
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Text("${widget.subjects?.name}", style: const TextStyle(
                         color: Colors.white54,

                        ),
                       ),
                     ),
                     const SizedBox(height: 10,),
                     const Text("Description" ,style: TextStyle(
                         color: Colors.white,
                         fontSize: 16,
                         fontWeight: FontWeight.normal
                     ),),
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Text("${widget.subjects?.desc}", style: const TextStyle(
                         color: Colors.white54,

                       ),
                       ),
                     ),
                     const SizedBox(height: 10,),
                     const Text("Created At" ,style: TextStyle(
                         color: Colors.white,
                         fontSize: 16,
                         fontWeight: FontWeight.normal
                     ),),
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Text(dateFormat.format(widget.subjects!.createdAt), style: const TextStyle(
                         color: Colors.white54,

                       ),
                       ),
                     ),
                     Row(
                       mainAxisSize: MainAxisSize.max,
                       children: [
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: TextButton(onPressed: () {
                             widget.onDelete!(widget.subjects!.id,widget.token);
                             Navigator.of(context).pop();
                           }, child: const Text("DELETE",style: TextStyle(color: Colors.red),)),
                         ),
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: TextButton(onPressed: () {
                             updateSubjectDialog(widget.subjects!.id,widget.token);
                           }, child: const Text("EDIT",style: TextStyle(color: Colors.blue),)),
                         )
                       ],
                     )
                   ],
                 ),
               ),
              ),
             ),
             Expanded(
               flex: 4,
                 child: AttendanceMainPage(subjectId: widget.subjects!.id))
           ],
         )
     );
  }
  Future updateSubjectDialog(int id,String token) => showDialog(context: context, builder: (context) => AlertDialog(
    title: const Text("Update a Subject"),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: _subjectNameController,
          decoration: const InputDecoration(
              hintText: "Subject name"
          ),
        ),
        TextField(
          controller: _subjectDescController,
          decoration: const InputDecoration(
              hintText: "Description"
          ),
        ),
      ],
    ),
    actions: [
      ElevatedButton(onPressed: (){
        String name = _subjectNameController.text.toString();
        String desc = _subjectDescController.text.toString();
        if (name.isNotEmpty) {
          widget.onUpdate!(id,name,desc,token);
          Navigator.of(context).pop();
        }
      }, child:const Text("Update"))
    ],
  )
  );

}
