import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:reau_hoje/data/connections/reauConnection/reauconnection.dart';
import 'package:reau_hoje/data/data.dart';
import 'package:reau_hoje/routers/application_routers.dart';

class SelectFirstCurrencyView extends StatefulWidget {
  final ReauConnection rc;
  SelectFirstCurrencyView({this.rc});

  @override
  _SelectFirstCurrencyViewState createState() =>
      _SelectFirstCurrencyViewState();
}

class _SelectFirstCurrencyViewState extends State<SelectFirstCurrencyView> {
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
                "Select Currency",
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
              title: Center(child: Text("AED: درهم الإمارات العربية المتحدة")),
              onTap: () {
                widget.rc.defCurrentType("AED");
                MyPreferences.setCurrentType("AED");
                Navigator.of(context).pushNamed(AppRoutes.HELLO);
                setState(() {});
              },
            ),
            ListTile(
              leading: Flag(
                "AR",
                height: 40,
                width: 40,
              ),
              title: Center(child: Text("ARS: Peso argentino")),
              onTap: () {
                widget.rc.defCurrentType("ARS");
                MyPreferences.setCurrentType("ARS");
                Navigator.of(context).pushNamed(AppRoutes.HELLO);
                setState(() {});
              },
            ),
            ListTile(
              leading: Flag(
                "AU",
                height: 40,
                width: 40,
              ),
              title: Center(child: Text("AUD: Australian Dollar")),
              onTap: () {
                widget.rc.defCurrentType("AUD");
                MyPreferences.setCurrentType("AUD");
                Navigator.of(context).pushNamed(AppRoutes.HELLO);
                setState(() {});
              },
            ),
            ListTile(
              leading: Flag(
                "BR",
                height: 40,
                width: 40,
              ),
              title: Center(child: Text("BRL: Reau Brasileiro")),
              onTap: () {
                widget.rc.defCurrentType("BRL");
                MyPreferences.setCurrentType("BRL");
                Navigator.of(context).pushNamed(AppRoutes.HELLO);
                setState(() {});
              },
            ),
            ListTile(
              leading: Flag(
                "CA",
                height: 40,
                width: 40,
              ),
              title: Center(child: Text("CAD: Canadian Dollar")),
              onTap: () {
                widget.rc.defCurrentType("CAD");
                MyPreferences.setCurrentType("CAD");
                Navigator.of(context).pushNamed(AppRoutes.HELLO);
                setState(() {});
              },
            ),
            ListTile(
              leading: Flag(
                "CN",
                height: 40,
                width: 40,
              ),
              title: Center(child: Text("CNY: 元")),
              onTap: () {
                widget.rc.defCurrentType("CNY");
                MyPreferences.setCurrentType("CNY");
                Navigator.of(context).pushNamed(AppRoutes.HELLO);
                setState(() {});
              },
            ),
            ListTile(
              leading: Flag(
                "EU",
                height: 40,
                width: 40,
              ),
              title: Center(child: Text("EUR: Euro")),
              onTap: () {
                widget.rc.defCurrentType("EUR");
                MyPreferences.setCurrentType("EUR");
                Navigator.of(context).pushNamed(AppRoutes.HELLO);
                setState(() {});
              },
            ),
            ListTile(
              leading: Flag(
                "GB",
                height: 40,
                width: 40,
              ),
              title: Center(child: Text("GBP: British Pound")),
              onTap: () {
                widget.rc.defCurrentType("GBP");
                MyPreferences.setCurrentType("GBP");
                Navigator.of(context).pushNamed(AppRoutes.HELLO);
                setState(() {});
              },
            ),
            ListTile(
              leading: Flag(
                "JP",
                height: 40,
                width: 40,
              ),
              title: Center(child: Text("JPY: 日本円")),
              onTap: () {
                widget.rc.defCurrentType("JPY");
                MyPreferences.setCurrentType("JPY");
                Navigator.of(context).pushNamed(AppRoutes.HELLO);
                setState(() {});
              },
            ),
            ListTile(
              leading: Flag(
                "RU",
                height: 40,
                width: 40,
              ),
              title: Center(child: Text("RUB: Русский рубль")),
              onTap: () {
                widget.rc.defCurrentType("RUB");
                MyPreferences.setCurrentType("RUB");
                Navigator.of(context).pushNamed(AppRoutes.HELLO);
                setState(() {});
              },
            ),
            ListTile(
              leading: Flag(
                "TR",
                height: 40,
                width: 40,
              ),
              title: Center(child: Text("TRY: Türk Lirası")),
              onTap: () {
                widget.rc.defCurrentType("TRY");
                MyPreferences.setCurrentType("TRY");
                Navigator.of(context).pushNamed(AppRoutes.HELLO);
                setState(() {});
              },
            ),
            ListTile(
              leading: Flag(
                "US",
                height: 40,
                width: 40,
              ),
              title: Center(child: Text("USD: United State Dollar")),
              onTap: () {
                widget.rc.defCurrentType("USD");
                MyPreferences.setCurrentType("USD");
                Navigator.of(context).pushNamed(AppRoutes.HELLO);
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
