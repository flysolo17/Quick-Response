import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_attendance/service/auth_service.dart';
import 'package:student_attendance/utils/constants.dart';
import 'package:student_attendance/view/accounts/acount_page.dart';

import 'package:student_attendance/view/attendance/attendance_main_page.dart';
import 'package:student_attendance/view/dashboard/dashboard.dart';
import 'package:student_attendance/view/notfound/not_found.dart';
import 'package:student_attendance/view/signup/sign_up.dart';

import 'models/user_model.dart';
import 'view/login/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Quick Response',
      debugShowCheckedModeBanner: false,
      home: SharedPrefs(),
    );
  }
}

class SharedPrefs extends StatefulWidget {
  const SharedPrefs({Key? key}) : super(key: key);
  @override
  State<SharedPrefs> createState() => _SharedPrefsState();
}

class _SharedPrefsState extends State<SharedPrefs> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<String> _token;
  Future<User>? user;
  @override
  void initState() {
    super.initState();
    _token = _prefs.then((SharedPreferences prefs) {
      return prefs.getString('token') ?? "";
    });
    initPrefs();
  }

  Future initPrefs() async {
    String? token = await _token;
    if (token.isEmpty) return;
    setState(() {
      user = AuthApiService.getUser(token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<User?>(
          future: user,
          builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              default:
                if (snapshot.data == null) {
                  return const LoginPage();
                } else {
                  if (snapshot.data!.type == accounts[0]) {
                    return DashBoardPage(user: snapshot.data!);
                  } else if (snapshot.data!.type == accounts[1]) {
                    return const AccountPage();
                  } else {
                    return const NotFoundPage();
                  }
                }
            }
          }),
    );
  }
}
