import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_attendance/service/auth_service.dart';
import 'package:student_attendance/utils/constants.dart';
import 'package:student_attendance/view/accounts/acount_page.dart';
import 'package:student_attendance/view/dashboard/dashboard.dart';
import 'package:student_attendance/view/notfound/not_found.dart';
import 'package:student_attendance/view/signup/sign_up.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _idNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late SharedPreferences _preferences;
  @override
  void initState() {
    super.initState();
    initPreferences();
  }

  Future initPreferences() async {
    _preferences = await SharedPreferences.getInstance();
  }

  void navigateToDashboard(String token) {
    if (token.isNotEmpty) {
      AuthApiService.getUser(token).then((value) => {
            if (value.type == "Teacher")
              {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DashBoardPage(
                              user: value,
                            )))
              }
            else if (value.type == "Student")
              {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AccountPage()))
              }
            else
              {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotFoundPage()))
              }
          });
    }
  }

  void storeToken(String token) async {
    _preferences.setString("token", token);
  }

  @override
  Widget build(BuildContext context) {
    Future<void> login(String idNumber, String password) async {
      var client = http.Client();
      try {
        var response = await client.post(
            Uri.parse("http://127.0.0.1:8080/auth/login"),
            body: json.encode({"idNumber": idNumber, "password": password}),
            headers: {
              "Accept": "application/json",
              "content-type": "application/json"
            });
        if (response.statusCode == 200) {
          Fluttertoast.showToast(
            msg: "Successfully Logged in!", // message
            toastLength: Toast.LENGTH_LONG, // length
            gravity: ToastGravity.CENTER,
          );
          navigateToDashboard(response.body);
          storeToken(response.body);
        } else {
          Fluttertoast.showToast(
            msg: "Error: ${response.statusCode} ${response.body}", // message
            toastLength: Toast.LENGTH_LONG, // length
            gravity: ToastGravity.CENTER,
          );
        }
      } catch (e) {
        Fluttertoast.showToast(msg: e.toString());
      } finally {
        client.close();
      }
    }

    return Container(
      color: grey25,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Login -> Text poppins semibold 24
            const Padding(
              padding: EdgeInsets.only(left: 20, bottom: 10, top: 30),
              child: Text(
                "Login",
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
            ),
            //Already Have an account -> Text poppins regular 14
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "Already have an account?",
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //email -> Text
                  const Padding(
                    padding: EdgeInsets.only(top: 5, bottom: 5, left: 5),
                    child: Text(
                      "ID Number",
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 14),
                    ),
                  ),
                  //email -> Textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: grey100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextField(
                          controller: _idNumberController,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              hintText: "03131704870",
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                  ),
                  //Password -> Text  poppins regular 14
                  const Padding(
                    padding: EdgeInsets.only(left: 5, bottom: 5, top: 5),
                    child: Text(
                      "Password",
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 14),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: grey100,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                              hintText: "yourpassword",
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                  ),
                  //Forgot Password ->Text poppins regular 14
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),

                  //Login -> Button
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30)),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: colorSecondary,
                        ),
                        onPressed: () {
                          var idNumber = _idNumberController.text.toString();
                          var password = _passwordController.text.toString();
                          login(idNumber, password);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //Not a member -> Text poppins regular 14
            Align(
              alignment: Alignment.bottomCenter,
              child: Text.rich(
                TextSpan(
                  text: 'Not a member? ', // default text style
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Sign Up',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const SignUpPage(title: "Sign Up")),
                            );
                          },
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
