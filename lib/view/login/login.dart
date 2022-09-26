import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_attendance/utils/constants.dart';
import 'package:student_attendance/view/login/login_left.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../dashboard/dashboard.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: grey100,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              width: 1080,
              height: 640,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  const Expanded(child: LoginForm()),
                  if(MediaQuery.of(context).size.width > 900) Expanded(child:
                  Container(
                    color: colorPrimary,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Student Attendance",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 24
                            ),
                          ),
                          const Text(
                            "System",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 24
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 50),
                            child: SizedBox(
                              width: 453,
                              height: 336,
                              child: SvgPicture.asset('assets/teaching.svg',
                                semanticsLabel: "Teaching",
                              ),
                            ),
                          ),
                          const Text(
                            "Made by Group Name",
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                          const Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              "EST 2022",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
                ],
              ),
            ),
          ),
        )
    );
  }
}

