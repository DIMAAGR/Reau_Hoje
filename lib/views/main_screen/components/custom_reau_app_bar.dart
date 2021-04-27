import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:reau_hoje/data/connections/reauConnection/reauconnection.dart';
import 'package:reau_hoje/views/main_screen/components/difference.dart';

class CustomReauAppBar extends StatefulWidget {
  const CustomReauAppBar({
    Key key,
    @required this.rc,
    @required this.appUser,
    @required this.updown,
    @required this.difference,
    @required this.diffstring,
  }) : super(key: key);

  final String appUser;
  final bool updown;
  final ReauConnection rc;
  final double difference;
  final String diffstring;

  @override
  _CustomReauAppBarState createState() => _CustomReauAppBarState();
}

class _CustomReauAppBarState extends State<CustomReauAppBar> {
  @override
  Widget build(BuildContext context) {
    String moneyType = widget.rc.getCurrentType();
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: SizedBox(),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12.0, top: 12.0),
            child: InkWell(
              onTap: () {
                setState(() {
                  _botomsheetdonation(context);
                  // moneyType == "BRL" ? moneyType = "USD" : moneyType = "BRL";
                  // moneyType == "BRL"
                  //     ? widget.rc.defCurrentType("BRL")
                  //     : widget.rc.defCurrentType("USD");
                });
              },
              borderRadius: BorderRadius.circular(5),
              child: Container(
                height: 28,
                width: 46,
                decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                  child: Text(
                    moneyType,
                    style: TextStyle(
                        color: Color.fromARGB(255, 248, 248, 248),
                        fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            ),
          ),
          Difference(
            updown: widget.updown == null ? true : widget.updown,
            difference: widget.difference,
            diffstring: widget.diffstring,
          )
        ],
      ),
    );
  }

  _botomsheetdonation(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  leading: Flag(
                    "AE",
                    height: 40,
                    width: 40,
                  ),
                  title:
                      Center(child: Text("AED: درهم الإمارات العربية المتحدة")),
                  onTap: () {
                    widget.rc.defCurrentType("AED");
                    Navigator.pop(context);
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
                    Navigator.pop(context);
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
                    Navigator.pop(context);
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
                    Navigator.pop(context);
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
                    Navigator.pop(context);
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
                    Navigator.pop(context);
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
                    Navigator.pop(context);
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
                    Navigator.pop(context);
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
                    Navigator.pop(context);
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
                    Navigator.pop(context);
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
                    Navigator.pop(context);
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
                    Navigator.pop(context);
                  },
                ),

                // Русский рубль
                // درهم الإمارات العربية المتحدة
                // Türk Lirası
                // British Pound
                // 日本円
                // 元
              ],
            ),
          );
        });
  }
}
