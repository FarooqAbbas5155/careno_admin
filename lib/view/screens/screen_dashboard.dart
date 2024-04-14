import 'package:careno_admin/view/screens/screen_mobile_home_page.dart';
import 'package:careno_admin/view/screens/screen_web_home_page.dart';
import 'package:flutter/material.dart';

class ScreenDashboard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {

        if (constraints.maxWidth > 600) {
          return ScreenWebHomePage();
        } else {
          return ScreenMobileHomePage();
        }
      },
    );

  }
}
