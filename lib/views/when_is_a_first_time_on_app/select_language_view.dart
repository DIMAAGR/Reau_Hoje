import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:reau_hoje/data/data.dart';
import 'package:reau_hoje/routers/application_routers.dart';

class SelectFirstLanguageView extends StatefulWidget {
  @override
  _SelectFirstLanguageViewState createState() =>
      _SelectFirstLanguageViewState();
}

class _SelectFirstLanguageViewState extends State<SelectFirstLanguageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color.fromARGB(255, 40, 40, 40)),
        leading: Row(
          children: [],
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Select Language",
                style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 35,
                    fontWeight: FontWeight.w800),
              ),
            ),
            ListTile(
              leading: Flag(
                "AE",
                height: 40,
                width: 40,
              ),
              title: Center(child: Text("عربى")),
              onTap: () {
                MyPreferences.setLanguage("AR");
                Navigator.of(context)
                    .pushNamed(AppRoutes.SELECT_FIRST_CURRENCY_SETTINGS);
                setState(() {});
              },
            ),
            ListTile(
              leading: Flag(
                "ES",
                height: 40,
                width: 40,
              ),
              title: Center(child: Text("Español")),
              onTap: () {
                MyPreferences.setLanguage("ES");
                Navigator.of(context)
                    .pushNamed(AppRoutes.SELECT_FIRST_CURRENCY_SETTINGS);
                setState(() {});
              },
            ),ListTile(
              leading: Flag(
                "FR",
                height: 40,
                width: 40,
              ),
              title: Center(child: Text("français")),
              onTap: () {
                MyPreferences.setLanguage("FR");
                Navigator.of(context)
                    .pushNamed(AppRoutes.SELECT_FIRST_CURRENCY_SETTINGS);
                setState(() {});
              },
            ),
            ListTile(
              leading: Flag(
                "BR",
                height: 40,
                width: 40,
              ),
              title: Center(child: Text("Português")),
              onTap: () {
                MyPreferences.setLanguage("PT-BR");
                Navigator.of(context)
                    .pushNamed(AppRoutes.SELECT_FIRST_CURRENCY_SETTINGS);
                setState(() {});
              },
            ),
            ListTile(
              leading: Flag(
                "CN",
                height: 40,
                width: 40,
              ),
              title: Center(child: Text("中文")),
              onTap: () {
                MyPreferences.setLanguage("CN");
                Navigator.of(context)
                    .pushNamed(AppRoutes.SELECT_FIRST_CURRENCY_SETTINGS);
                setState(() {});
              },
            ),
            ListTile(
              leading: Flag(
                "JP",
                height: 40,
                width: 40,
              ),
              title: Center(child: Text("日本語")),
              onTap: () {
                MyPreferences.setLanguage("JP");
                Navigator.of(context)
                    .pushNamed(AppRoutes.SELECT_FIRST_CURRENCY_SETTINGS);
                setState(() {});
              },
            ),
            ListTile(
              leading: Flag(
                "RU",
                height: 40,
                width: 40,
              ),
              title: Center(child: Text("русский язык")),
              onTap: () {
                MyPreferences.setLanguage("RU");
                Navigator.of(context)
                    .pushNamed(AppRoutes.SELECT_FIRST_CURRENCY_SETTINGS);
                setState(() {});
              },
            ),
            ListTile(
              leading: Flag(
                "TR",
                height: 40,
                width: 40,
              ),
              title: Center(child: Text("Türk Dili")),
              onTap: () {
                MyPreferences.setLanguage("TR");
                Navigator.of(context)
                    .pushNamed(AppRoutes.SELECT_FIRST_CURRENCY_SETTINGS);
                setState(() {});
              },
            ),
            ListTile(
              leading: Flag(
                "US",
                height: 40,
                width: 40,
              ),
              title: Center(child: Text("English")),
              onTap: () {
                MyPreferences.setLanguage("EN");
                Navigator.of(context)
                    .pushNamed(AppRoutes.SELECT_FIRST_CURRENCY_SETTINGS);
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
