import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_attendance/utils/constants.dart';
import 'package:student_attendance/view/about/developer_card.dart';
import 'package:student_attendance/view/dashboard/cards/profile_card.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorSecondary,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SvgPicture.asset(
                'assets/logo.svg',
                semanticsLabel: "Logo",
                width: 180,
                height: 180,
              ),
              Text(
                "What is Quick Response?",
                style: GoogleFonts.poppins(
                  textStyle: Theme.of(context).textTheme.headline6,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 40,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(40),
                child: Text(
                  about,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    textStyle: Theme.of(context).textTheme.headline6,
                    color: Colors.white,
                    fontWeight: FontWeight.w100,
                    fontSize: 22,
                  ),
                ),
              ),
              Text(
                "Our Goal",
                style: GoogleFonts.poppins(
                  textStyle: Theme.of(context).textTheme.headline6,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 40,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(40),
                child: Text(
                  about,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    textStyle: Theme.of(context).textTheme.headline6,
                    color: Colors.white,
                    fontWeight: FontWeight.w100,
                    fontSize: 22,
                  ),
                ),
              ),
              Text(
                "Who are the minds of behind Quick Response ?",
                style: GoogleFonts.poppins(
                  textStyle: Theme.of(context).textTheme.headline6,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 40,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  hero,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    textStyle: Theme.of(context).textTheme.headline6,
                    color: Colors.white,
                    fontWeight: FontWeight.w200,
                    fontSize: 22,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: const [
                    DeveloperCard(
                      name: "Juan Dele Cruz",
                      position: "Developer/Leader",
                      facebook: "https://www.facebook.com/jmballangca.pogi",
                      instagram: "Hey",
                    ),
                    DeveloperCard(
                      name: "Juan Dele Cruz",
                      position: "Developer/Leader",
                      facebook: "https://www.facebook.com/jmballangca.pogi",
                      instagram: "Hey",
                    ),
                    DeveloperCard(
                      name: "Juan Dele Cruz",
                      position: "Developer/Leader",
                      facebook: "https://www.facebook.com/jmballangca.pogi",
                      instagram: "Hey",
                    ),
                  ],
                ),
              ),
            ]),
      )),
    );
  }
}
