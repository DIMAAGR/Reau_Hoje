import 'dart:async';

import 'package:flutter/material.dart';
import 'package:reau_hoje/data/data.dart';
import 'package:reau_hoje/routers/application_routers.dart';
import 'package:reau_hoje/utils/language.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Language lang = Language();
  String myLang;

  Map<String, String> language;

  @override
  void initState() {
    language = lang.getSelectedLanguageInfo();
    myLang = lang.getLanguage();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  FutureOr onGoBack(dynamic value) {
    lang.setLanguage(language: MyPreferences.getLanguage());
    lang.defLanguage();
    language = lang.getSelectedLanguageInfo();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color.fromARGB(255, 40, 40, 40)),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: _myListOfOptions(),
      ),
    );
  }

  _myTextStyle(FontWeight fontWeight) {
    return TextStyle(
      fontWeight: fontWeight,
      fontSize: 16,
    );
  }

  _myListOfOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            language["Settings"],
            style: TextStyle(
                fontFamily: "Roboto",
                fontSize: 35,
                fontWeight: FontWeight.w800),
          ),
        ),
        ListTile(
          leading: Icon(Icons.account_circle),
          title: Row(
            children: [
              Text(
                "Profile: ",
                style: _myTextStyle(FontWeight.normal),
              ),
              Text(
                language["MyProfile"],
                style: _myTextStyle(FontWeight.w600),
              ),
            ],
          ),
          onTap: () => Navigator.of(context)
              .pushNamed(AppRoutes.SELECT_MY_PROFILE_SETTINGS),
        ),
        ListTile(
          leading: Icon(Icons.language),
          title: Row(
            children: [
              Text(
                "Language: ",
                style: _myTextStyle(FontWeight.normal),
              ),
              Text(
                language["Language"],
                style: _myTextStyle(FontWeight.w600),
              ),
            ],
          ),
          onTap: () => Navigator.of(context)
              .pushNamed(AppRoutes.SELECT_LANGUAGE_SETTINGS)
              .then(onGoBack),
        ),
        ListTile(
          leading: Icon(Icons.attach_money),
          title: Row(
            children: [
              Text(
                "currency: ",
                style: _myTextStyle(FontWeight.normal),
              ),
              Text(
                MyPreferences.getCurrentType() == null
                    ? "Undefined"
                    : MyPreferences.getCurrentType(),
                style: _myTextStyle(FontWeight.w600),
              ),
            ],
          ),
          onTap: () => Navigator.of(context)
              .pushNamed(AppRoutes.SELECT_CURRENCY_SETTINGS)
              .then(onGoBack),
        ),
        ListTile(
            leading: Icon(Icons.priority_high),
            title: Row(
              children: [
                Text(
                  "About",
                  style: _myTextStyle(FontWeight.w600),
                ),
              ],
            )),
      ],
    );
  }
}
