import 'package:flutter/material.dart';
import 'package:reau_hoje/views/main_screen/components/difference.dart';

class CustomReauAppBar extends StatelessWidget {
  const CustomReauAppBar({
    Key key,
    @required this.appUser,
    @required this.updown,
    @required this.difference,
    @required this.diffstring,
  }) : super(key: key);

  final String appUser;
  final bool updown;
  final double difference;
  final String diffstring;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12.0, top: 12.0),
          child: Row(
            children: [
              Text(
                "Olá, ",
                style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 35,
                    fontWeight: FontWeight.w300),
              ),
              Text(
                appUser,
                style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 35,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: SizedBox(),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 12.0, top: 12.0),
          child: Container(
            height: 28,
            width: 46,
            decoration: BoxDecoration(
                color: Colors.black45, borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: Text(
                "BRL",
                style: TextStyle(
                    color: Color.fromARGB(255, 248, 248, 248),
                    fontWeight: FontWeight.w900),
              ),
            ),
          ),
        ),
        Difference(
          updown: updown == null ? true : updown,
          difference: difference,
          diffstring: diffstring,
        )
      ],
    );
  }
}
