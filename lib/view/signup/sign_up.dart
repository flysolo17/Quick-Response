import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:student_attendance/data/create_account_resquest.dart';
import 'package:student_attendance/utils/app_url.dart';
import 'package:student_attendance/utils/constants.dart';

import 'package:http/http.dart' as http;
import 'package:student_attendance/view/login/login.dart';
import '../../models/user_model.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key, required String title}) : super(key: key);
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}
class _SignUpPageState extends State<SignUpPage> {
  final List<bool> _selectedAccountType= <bool>[true, false];
  late var selected = 0;
  bool vertical = false;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _idNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Future<void> createAccount(CreateAccountRequest user) async {
    var client = http.Client();
    try {
      var response = await client.post(Uri.parse(AppUrl.signUpEndpoint),
          body: json.encode(user.toJson()),
          headers: {
            "Accept": "application/json",
            "content-type": "application/json"
          });
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: "Account Successfully Created!",  // message
          toastLength: Toast.LENGTH_LONG, // length
          gravity: ToastGravity.CENTER,
        );

      } else {
        Fluttertoast.showToast(
          msg: "Error: ${response.statusCode} ${response.body}",  // message
          toastLength: Toast.LENGTH_LONG, // length
          gravity: ToastGravity.CENTER,
        );
      }
    } finally {
      client.close();
    }
  }
  String getAccountType() {
    if(selected == 0) {
      return "Student";
    }
    return "Teacher";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey100,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            height: 640,
            width: 920,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children:  [
                 Container(
                   color: colorPrimary,
                   child: const SizedBox(
                    height: double.infinity,
                    width: 15,
                   ),
                 ),
                 Expanded(child:  Container(
                   color: grey25,
                   width: double.infinity,
                   child: Padding(
                     padding: const EdgeInsets.all(20),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text("Sign Up",
                          style: TextStyle(
                           color: colorPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 24
                          ),
                         ),
                         Text("This is your first step with us!",
                           style: TextStyle(
                               color: colorPrimary,
                           ),
                         ),
                         const SizedBox(
                           height: 20,
                         ),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           children: [
                             Expanded(
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   const Padding(
                                     padding: EdgeInsets.all(5),
                                     child:  Text("Firstname",
                                       style: TextStyle(
                                           fontWeight: FontWeight.normal,
                                           fontSize: 14,
                                           color: Colors.black
                                       ),
                                     ),
                                   ),
                                   Container(
                                     padding: const EdgeInsets.symmetric(vertical: 5.0),
                                     margin:const  EdgeInsets.only(right: 5),
                                     decoration: BoxDecoration(
                                       color: grey100,
                                       borderRadius: BorderRadius.circular(10),
                                     ),
                                     child: Padding(
                                       padding: EdgeInsets.only(left: 10),
                                       child: TextField(
                                         controller: _firstNameController,
                                         decoration:const  InputDecoration(
                                             hintText: "Juan",
                                             border: InputBorder.none
                                         ),
                                       ),
                                     ),
                                   ),
                                 ],
                               ),
                             ),
                             Expanded(
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   const Padding(
                                     padding: EdgeInsets.all(5),
                                     child:  Text("Middle name",
                                       style: TextStyle(
                                           fontWeight: FontWeight.normal,
                                           fontSize: 14,
                                           color: Colors.black
                                       ),
                                     ),
                                   ),
                                   Container(
                                     padding: const EdgeInsets.symmetric(vertical: 5.0),
                                     margin: const EdgeInsets.only(left: 5,right: 5),
                                     decoration: BoxDecoration(
                                       color: grey100,
                                       borderRadius: BorderRadius.circular(10),
                                     ),
                                     child: Padding(
                                       padding: const EdgeInsets.only(left: 10),
                                       child: TextField(
                                         controller: _middleNameController,
                                         decoration: const InputDecoration(
                                             hintText: "Dela",
                                             border: InputBorder.none
                                         ),
                                       ),
                                     ),
                                   ),
                                 ],
                               ),
                             ),
                             Expanded(
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   const Padding(
                                     padding: EdgeInsets.all(5),
                                     child:  Text("Lastname",
                                       style: TextStyle(
                                           fontWeight: FontWeight.normal,
                                           fontSize: 14,
                                           color: Colors.black
                                       ),
                                     ),
                                   ),
                                   Container(
                                     padding: const EdgeInsets.symmetric(vertical: 5.0),
                                     margin:const  EdgeInsets.only(left: 5),
                                     decoration: BoxDecoration(
                                       color: grey100,
                                       borderRadius: BorderRadius.circular(10),
                                     ),
                                     child:  Padding(
                                       padding:const  EdgeInsets.only(left: 10),
                                       child: TextField(
                                         controller: _lastNameController,
                                         decoration:const InputDecoration(
                                             hintText: "Cruz",
                                             border: InputBorder.none
                                         ),
                                       ),
                                     ),
                                   ),
                                 ],
                               ),
                             ),
                           ],
                         ),
                         const SizedBox(
                           height: 20,
                         ),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           children: [
                             Expanded(
                               child: Padding(
                                 padding: const EdgeInsets.only(right: 10),
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     const Padding(
                                       padding: EdgeInsets.all(5),
                                       child:  Text("ID number",
                                         style: TextStyle(
                                             fontWeight: FontWeight.normal,
                                             fontSize: 14,
                                             color: Colors.black
                                         ),
                                       ),
                                     ),
                                     Container(
                                       padding:const EdgeInsets.symmetric(vertical: 5.0),
                                       decoration: BoxDecoration(
                                         color: grey100,
                                         borderRadius: BorderRadius.circular(10),
                                       ),
                                       child: Padding(
                                         padding:const  EdgeInsets.only(left: 10),
                                         child: TextField(
                                           controller: _idNumberController,
                                           inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                           keyboardType: TextInputType.number,
                                           decoration: const InputDecoration(
                                               hintText: "03161704870",
                                               border: InputBorder.none
                                           ),
                                         ),
                                       ),
                                     ),
                                   ],
                                 ),
                               ),
                             ),
                             Expanded(
                               child: Padding(
                                 padding: const EdgeInsets.only(left: 10),
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     const Padding(
                                       padding: EdgeInsets.all(5),
                                       child:  Text("Password",
                                         style: TextStyle(
                                             fontWeight: FontWeight.normal,
                                             fontSize: 14,
                                             color: Colors.black
                                         ),
                                       ),
                                     ),
                                     Container(
                                       padding: const EdgeInsets.symmetric(vertical: 5.0),

                                       decoration: BoxDecoration(
                                         color: grey100,
                                         borderRadius: BorderRadius.circular(10),
                                       ),
                                       child:  Padding(
                                         padding:const EdgeInsets.only(left: 10),
                                         child: TextField(
                                           controller: _passwordController,
                                           obscureText: true,
                                           decoration:const InputDecoration(
                                               hintText: "yourpassword",
                                               border: InputBorder.none
                                           ),
                                         ),
                                       ),
                                     ),
                                   ],
                                 ),
                               ),
                             ),
                           ],
                         ),

                         Padding(
                           padding: const EdgeInsets.symmetric(vertical: 50),
                           child: Center(
                             child: ToggleButtons(
                               direction: vertical ? Axis.vertical : Axis.horizontal,
                               onPressed: (int index) {
                                 setState(() {
                                   selected = index;
                                   for (int i = 0; i < _selectedAccountType.length; i++) {
                                     _selectedAccountType[i] = i == index;
                                   }
                                 });
                               },
                               borderRadius: const BorderRadius.all(Radius.circular(8)),
                               selectedColor: Colors.white,
                               fillColor: colorSecondary,
                               color: colorPrimary,
                               constraints: const BoxConstraints(
                                 minHeight: 50.0,
                                 minWidth: 150.0,
                               ),
                               isSelected: _selectedAccountType,
                               children: accountTypes,
                             ),
                           ),
                         ),
                         //Login -> Button
                         Center(
                             child: Container(
                               width: 300,
                               padding: const EdgeInsets.all(20),
                               margin: const EdgeInsets.all(30),
                               decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(30)
                               ),
                               child: ElevatedButton(
                                 style: ElevatedButton.styleFrom(
                                   shape: RoundedRectangleBorder(
                                     borderRadius: BorderRadius.circular(10),
                                   ),
                                   backgroundColor: colorSecondary,
                                 ),
                                 onPressed: () {
                                   String firstName = _firstNameController.text.toString();
                                   String middleName = _middleNameController.text.toString();
                                   String lastName = _lastNameController.text.toString();
                                   String idNumber = _idNumberController.text.toString();
                                   String password = _passwordController.text.toString();
                                   if(firstName.isEmpty|| middleName.isEmpty || lastName.isEmpty || idNumber.isEmpty || password.isEmpty) {
                                     Fluttertoast.showToast(msg: "Please Sign up all forms");
                                   } else {
                                     createAccount(CreateAccountRequest(firstName: firstName, middleName: middleName, lastName: lastName, type: getAccountType(), idNumber: idNumber,password: password)).then((value) => {
                                       Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()))
                                     });
                                   }
                                 },
                                 child: const Padding(
                                   padding: EdgeInsets.all(10),
                                   child: Text(
                                     "Create Account",
                                     style: TextStyle(color: Colors.white),
                                   ),
                               ),
                             ),
                           ),
                         ),
                         Align(
                           alignment: Alignment.bottomCenter,
                           child: Padding(
                             padding: const  EdgeInsets.all(5),
                             child: Text.rich(
                               TextSpan(
                                 text: 'Already a member? ', // default text style
                                 children: <TextSpan>[
                                   TextSpan(text: 'Sign In',recognizer: TapGestureRecognizer()..onTap = () {
                                     Navigator.pop(context);
                                   }, style: const TextStyle(fontWeight: FontWeight.bold)),
                                 ],
                               ),
                             ),
                           ),
                         ),
                       ],
                     ),
                   ),
                 ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
