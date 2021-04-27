import 'package:flutter/material.dart';
import 'package:reau_hoje/data/connections/reauConnection/reauconnection.dart';
import 'package:reau_hoje/data/data.dart';
import 'package:reau_hoje/views/hello.dart';
import 'package:reau_hoje/views/main_screen/body/main_screen.dart';

class Home extends StatelessWidget {
  final ReauConnection rc;

  Home({this.rc});

  @override
  Widget build(BuildContext context) {
    if (MyPreferences.getWallet() == null ||
        MyPreferences.getWallet().isEmpty) {
      return FirstTake();
    } else {
      return MainScreen(
        rc: rc,
      );
    }
    // Navigator.of(context).pushNamed(AppRoutes.HELLO),
    // : Navigator.of(context).pushNamed(AppRoutes.HOME);
  }
}
