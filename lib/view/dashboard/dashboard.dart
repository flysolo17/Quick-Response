import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:side_navigation/side_navigation.dart';
import 'package:student_attendance/models/user_model.dart';
import 'package:student_attendance/service/auth_service.dart';

import 'package:student_attendance/utils/constants.dart';
import 'package:student_attendance/view/about/about_page.dart';
import 'package:student_attendance/view/accounts/acount_page.dart';
import 'package:student_attendance/view/dashboard/views/home_page.dart';

class DashBoardPage extends StatefulWidget {
  final User user;
  const DashBoardPage({Key? key, required this.user}) : super(key: key);
  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  int selectedIndex = 0;

  String fullname = "";
  List<Widget> views = const [
    DashBoardHomePage(),
    AccountPage(),
    Center(child: Text('About Page')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SideNavigationBar(
            header: SideNavigationBarHeader(
                image: SvgPicture.asset(
                  'assets/logo.svg',
                  width: 50,
                  height: 50,
                ),
                title: const Text(
                  "Quick Response",
                  style: TextStyle(color: Colors.white54),
                ),
                subtitle: const Text(
                  "made by groupname",
                  style: TextStyle(color: Colors.white54, fontSize: 12),
                )),
            selectedIndex: selectedIndex,
            items: const [
              SideNavigationBarItem(
                icon: Icons.dashboard,
                label: 'Dashboard',
              ),
              SideNavigationBarItem(
                icon: Icons.person,
                label: 'Account',
              ),
              SideNavigationBarItem(
                icon: Icons.info,
                label: 'About',
              ),
            ],
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            toggler: SideBarToggler(
                expandIcon: Icons.keyboard_arrow_left,
                shrinkIcon: Icons.keyboard_arrow_right,
                onToggle: () {
                  print('Toggle');
                }),
            theme: SideNavigationBarTheme(
              backgroundColor: colorPrimary,
              itemTheme: SideNavigationBarItemTheme(
                  unselectedItemColor: Colors.white54,
                  selectedItemColor: purple,
                  labelTextStyle:
                      const TextStyle(fontSize: 20, color: Colors.black)),
              togglerTheme: const SideNavigationBarTogglerTheme(
                  expandIconColor: Colors.white54,
                  shrinkIconColor: Colors.white54),
              dividerTheme: SideNavigationBarDividerTheme.standard(),
            ),
          ),
          Expanded(
            child: views.elementAt(selectedIndex),
          )
        ],
      ),
    );
  }
}
