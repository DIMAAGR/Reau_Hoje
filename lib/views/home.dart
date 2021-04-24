import 'package:flutter/material.dart';
import 'package:reau_hoje/data/data.dart';
import 'package:reau_hoje/views/hello.dart';
import 'package:reau_hoje/views/main_screen/body/main_screen.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (MyPreferences.getWallet() == null ||
        MyPreferences.getWallet().isEmpty) {
      return FirstTake();
    } else {
      return MainScreen();
    }
    // Navigator.of(context).pushNamed(AppRoutes.HELLO),
    // : Navigator.of(context).pushNamed(AppRoutes.HOME);
  }
}
