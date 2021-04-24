import 'package:flutter/material.dart';
import 'package:reau_hoje/data/connections/reauconnection.dart';
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
                  moneyType == "BRL" ? moneyType = "USD" : moneyType = "BRL";
                  moneyType == "BRL"
                      ? widget.rc.defCurrentType("BRL")
                      : widget.rc.defCurrentType("USD");
                  widget.rc.setCurrency();
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
}
