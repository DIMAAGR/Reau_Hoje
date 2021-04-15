import 'package:flutter/material.dart';

class AppBtn extends StatelessWidget {
  final bool active;
  final Function function;
  final Icon icon;
  final String text;

  const AppBtn({
    this.active,
    this.function,
    this.icon,
    this.text,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return active == true
        ? InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: function,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Color.fromARGB(255, 238, 238, 238),
                      blurRadius: 8,
                      spreadRadius: 3)
                ],
                color: Color.fromARGB(255, 250, 250, 250),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  icon,
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: "Roboto",
                          color: Colors.black54,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
          )
        : InkWell(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  icon,
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: "Roboto",
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
