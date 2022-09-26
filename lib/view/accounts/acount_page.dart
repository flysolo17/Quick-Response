import 'dart:convert';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_attendance/models/user_model.dart';
import 'package:student_attendance/service/auth_service.dart';
import 'package:student_attendance/utils/constants.dart';
import 'package:student_attendance/view/login/login.dart';
import 'package:student_attendance/view/notfound/not_found.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:universal_html/html.dart' as html;
import 'package:image_downloader_web/image_downloader_web.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<String> _token;
  Future<User>? user;
  final GlobalKey globalKey = GlobalKey();
  bool isApiCallProcess = false;

  final WebImageDownloader _webImageDownloader = WebImageDownloader();
  bool downloading = false;

  Future<void> _downloadImage() async {
    try {
      setState(() {
        downloading = true;
      });
      RenderRepaintBoundary boundary =
          globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage();
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      await _webImageDownloader.downloadImageFromUInt8List(uInt8List: pngBytes);
      setState(() {
        downloading = false;
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

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
        backgroundColor: colorSecondary,
        body: Center(
          child: ProgressHUD(
              key: UniqueKey(),
              opacity: 0.3,
              inAsyncCall: isApiCallProcess,
              child: loadUser()),
        ));
  }

  FutureBuilder<User> loadUser() {
    return FutureBuilder(
      future: user,
      builder: (
        BuildContext context,
        AsyncSnapshot<User> model,
      ) {
        if (model.hasError) {
          return const Text(
            "error fetching user info",
            style: TextStyle(color: Colors.white),
          );
        } else if (model.hasData && model.data != null) {
          if (downloading) {
            return circularLoading();
          }
          return cardUserInfo(model.data!);
        }
        return circularLoading();
      },
    );
  }

  cardUserInfo(User user) {
    return Container(
        width: 980,
        height: 640,
        padding: const EdgeInsets.all(30),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          color: colorPrimary,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Account Details",
                style: GoogleFonts.poppins(
                    textStyle: Theme.of(context).textTheme.headline4,
                    fontSize: 48,
                    fontWeight: FontWeight.w500,
                    color: Colors.white)),
            Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    RepaintBoundary(
                      key: globalKey,
                      child: QrImage(
                        data: user.idNumber,
                        version: QrVersions.auto,
                        size: 150,
                        gapless: false,
                        backgroundColor: Colors.white,
                        embeddedImage: const AssetImage('assets/logo.png'),
                        embeddedImageStyle: QrEmbeddedImageStyle(
                          size: const Size(50, 50),
                        ),
                      ),
                    ),
                    IconButton(
                      color: Colors.white54,
                      icon: const Icon(Icons.download),
                      onPressed: () {
                        _downloadImage();
                      },
                    ),
                  ],
                )),
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Firstname",
                              style: GoogleFonts.poppins(
                                  textStyle:
                                      Theme.of(context).textTheme.headline6,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w200,
                                  fontSize: 20),
                            ),
                            Text(
                              "Middle Name",
                              style: GoogleFonts.poppins(
                                  textStyle:
                                      Theme.of(context).textTheme.headline6,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w200,
                                  fontSize: 20),
                            ),
                            Text(
                              "Lastname",
                              style: GoogleFonts.poppins(
                                  textStyle:
                                      Theme.of(context).textTheme.headline6,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w200,
                                  fontSize: 20),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                user.firstName,
                                style: GoogleFonts.poppins(
                                    textStyle:
                                        Theme.of(context).textTheme.headline6,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w100,
                                    fontSize: 20),
                              ),
                              Text(
                                user.middleName,
                                style: GoogleFonts.poppins(
                                    textStyle:
                                        Theme.of(context).textTheme.headline6,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w100,
                                    fontSize: 20),
                              ),
                              Text(
                                user.lastName,
                                style: GoogleFonts.poppins(
                                    textStyle:
                                        Theme.of(context).textTheme.headline6,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w100,
                                    fontSize: 20),
                              )
                            ],
                          ),
                        ),
                        Wrap(
                          spacing: 100,
                          alignment: WrapAlignment.start,
                          children: [
                            Text(
                              "Account Type",
                              style: GoogleFonts.poppins(
                                  textStyle:
                                      Theme.of(context).textTheme.headline6,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w200,
                                  fontSize: 20),
                            ),
                            Text(
                              "ID Number",
                              style: GoogleFonts.poppins(
                                  textStyle:
                                      Theme.of(context).textTheme.headline6,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w200,
                                  fontSize: 20),
                            ),
                          ],
                        ),
                        Wrap(
                          spacing: 150,
                          alignment: WrapAlignment.start,
                          children: [
                            Text(
                              user.type,
                              style: GoogleFonts.poppins(
                                  textStyle:
                                      Theme.of(context).textTheme.headline6,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w100,
                                  fontSize: 20),
                            ),
                            Text(
                              user.idNumber,
                              style: GoogleFonts.poppins(
                                  textStyle:
                                      Theme.of(context).textTheme.headline6,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w100,
                                  fontSize: 20),
                            ),
                          ],
                        ),
                      ],
                    ))),
            Wrap(
              spacing: 50,
              children: [
                //Login -> Button
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(30)),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () {
                      _downloadImage();
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(
                          left: 60, right: 60, top: 15, bottom: 15),
                      child: Text(
                        "Edit Profile",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(30)),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      setState(() {
                        downloading = true;
                      });
                      logout();
                      setState(() {
                        downloading = false;
                      });
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(
                          left: 60, right: 60, top: 15, bottom: 15),
                      child: Text(
                        "Logout",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }

  void logout() async {
    setState(() {
      isApiCallProcess = true;
    });
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove("token").then((value) => {
          isApiCallProcess = false,
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginPage()))
        });
  }

  circularLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
