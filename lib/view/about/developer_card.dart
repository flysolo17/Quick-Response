import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:student_attendance/utils/constants.dart';

import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class DeveloperCard extends StatelessWidget {
  final String name;
  final String position;
  final String facebook;
  final String instagram;
  const DeveloperCard(
      {super.key,
      required this.name,
      required this.position,
      required this.facebook,
      required this.instagram});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: Colors.black,
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Image.asset(
              'assets/person.jpg',
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                name,
                style: GoogleFonts.poppins(
                  textStyle: Theme.of(context).textTheme.bodyMedium,
                  color: Colors.white,
                  fontWeight: FontWeight.w200,
                  fontSize: 20,
                ),
              ),
            ),
            Text(
              position,
              style: GoogleFonts.poppins(
                textStyle: Theme.of(context).textTheme.bodyMedium,
                color: Colors.white,
                fontWeight: FontWeight.w100,
                fontSize: 18,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  FlutterSocialButton(
                    onTap: () {},
                    mini: true,
                    buttonType: ButtonType.google,
                  ),
                  FlutterSocialButton(
                    onTap: () {
                      _launchInBrowser(Uri.parse(facebook));
                    },
                    mini: true,
                    buttonType: ButtonType.facebook,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }
}
