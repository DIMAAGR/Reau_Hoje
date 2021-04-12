import 'package:flutter/material.dart';

class Difference extends StatelessWidget {
  final double difference;
  final double ancientdifference;
  final String diffstring;

  Difference({this.difference, this.ancientdifference, this.diffstring});

  @override
  Widget build(BuildContext context) {
    return difference > ancientdifference
        ? Padding(
            padding: const EdgeInsets.only(right: 16.0, top: 12.0),
            child: Container(
              height: 28,
              width: 58 + diffstring.length.toDouble() * 2.4,
              decoration: BoxDecoration(
                  color: Colors.greenAccent[700],
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: Row(
                  children: [
                    Icon(
                      Icons.keyboard_arrow_up,
                      color: Colors.white,
                    ),
                    Text(
                      diffstring,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              ),
            ),
          )
        : difference < ancientdifference
            ? Padding(
                padding: const EdgeInsets.only(right: 16.0, top: 12.0),
                child: Container(
                  height: 28,
                  width: 64 + diffstring.length.toDouble() * 2.3,
                  decoration: BoxDecoration(
                      color: Colors.redAccent[700],
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: Row(
                      children: [
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                        ),
                        Text(
                          diffstring,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : difference == 0.0
                ? Padding(
                    padding: const EdgeInsets.only(right: 16.0, top: 12.0),
                    child: Container(
                      height: 28,
                      width: 58,
                      decoration: BoxDecoration(
                          color: Colors.grey[700],
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                        child: Text(
                          diffstring,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                  )
                : SizedBox();
  }
}
