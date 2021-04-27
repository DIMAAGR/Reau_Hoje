import 'package:flutter/material.dart';
import 'package:reau_hoje/data/connections/reauConnection/reauconnection.dart';
import 'package:reau_hoje/data/data.dart';
import 'package:reau_hoje/views/main_screen/body/main_screen.dart';
import 'package:reau_hoje/views/when_is_a_first_time_on_app/select_language_view.dart';

class Home extends StatelessWidget {
  final ReauConnection rc;

  Home({this.rc});

  @override
  Widget build(BuildContext context) {
    if (MyPreferences.getLanguage() == null ||
        MyPreferences.getLanguage().isEmpty) {
      return SelectFirstLanguageView();
    } else {
      return MainScreen(
        rc: rc,
      );
    }
    // MyPreferences.getWallet() == null ||
    //     MyPreferences.getWallet().isEmpty
    // Navigator.of(context).pushNamed(AppRoutes.HELLO),
    // : Navigator.of(context).pushNamed(AppRoutes.HOME);
  }
}
