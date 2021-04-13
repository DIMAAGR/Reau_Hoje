import 'package:flutter/material.dart';

class MarketValueWidget extends StatelessWidget {
  const MarketValueWidget({
    Key key,
    @required this.totalBRLFeesValue,
  }) : super(key: key);

  final double totalBRLFeesValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 235, 235, 235),
              blurRadius: 8,
            )
          ],
          borderRadius: BorderRadius.circular(15),
          color: Color.fromARGB(
              255, 250, 250, 250)), //Color.fromARGB(255, 74, 70, 255)),
      height: 80,
      width: MediaQuery.of(context).size.width * 0.92,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              "Capital de Mercado:",
              style: TextStyle(
                  fontSize: 12,
                  fontFamily: "Roboto",
                  color: Colors.black87,
                  fontWeight: FontWeight.w400),
            ),
          ),
          totalBRLFeesValue != null
              ? Padding(
                  padding:
                      const EdgeInsets.only(top: 2, left: 16.0, bottom: 8.0),
                  child: Text(
                    "R\$ " +
                        totalBRLFeesValue
                            .toStringAsFixed(2)
                            .replaceAll(".", ","),
                    style: TextStyle(
                        fontSize: 30,
                        fontFamily: "Roboto",
                        color: Colors.black87,
                        fontWeight: FontWeight.w800),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: new AlwaysStoppedAnimation<Color>(
                        Color.fromARGB(255, 246, 246, 246)),
                  ),
                ),
        ],
      ),
    );
  }
}
