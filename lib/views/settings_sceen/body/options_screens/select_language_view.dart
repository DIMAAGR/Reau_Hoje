import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:reau_hoje/data/data.dart';

class SelectLanguageView extends StatefulWidget {
  @override
  _SelectLanguageViewState createState() => _SelectLanguageViewState();
}

class _SelectLanguageViewState extends State<SelectLanguageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color.fromARGB(255, 40, 40, 40)),
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
                Navigator.pop(context);
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
                Navigator.pop(context);
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
                Navigator.pop(context);
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
                Navigator.pop(context);
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
                Navigator.pop(context);
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
                Navigator.pop(context);
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
                Navigator.pop(context);
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
                Navigator.pop(context);
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
