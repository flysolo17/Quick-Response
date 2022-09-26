import 'package:flutter/material.dart';
import 'package:student_attendance/utils/constants.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorPrimary,
      child: const Center(
        child: Text("Not Found!"),
      ),
    );
  }
}
