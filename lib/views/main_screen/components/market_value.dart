import 'package:flutter/material.dart';

/// Este Widget tem como função mostrar o valor de mercado da moeda REAU
/// Ele receberá a variável [marketPrice] que irá definir o preço de mercado da moeda

class MarketValueWidget extends StatelessWidget {
  const MarketValueWidget({
    Key key,
    @required this.marketPrice,
  }) : super(key: key);

  /// a variável [marketPrice] define o preço da moeda na tela
  final double marketPrice;

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
      height: 200,

      width: MediaQuery.of(context).size.width * 0.92,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                  child: Container(
                    height: 44,
                    width: 44,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 0, 219, 255),
                      borderRadius: BorderRadius.circular(44),
                    ),
                    child: Center(
                      child: Text(
                        "R",
                        style: TextStyle(
                          fontSize: 30,
                          color: Color.fromARGB(255, 245, 245, 245),
                          fontFamily: "Montserrat",
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      "Vira-lata Reau",
                      style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                )
              ],
            ),
          ),
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
          marketPrice != null
              ? Padding(
                  padding:
                      const EdgeInsets.only(top: 2, left: 16.0, bottom: 8.0),
                  child: Text(
                    "R\$ " +
                        marketPrice.toStringAsFixed(2).replaceAll(".", ","),
                    style: TextStyle(
                        fontSize: 30,
                        fontFamily: "Roboto",
                        color: Colors.black87,
                        fontWeight: FontWeight.w800),
                  ),
                )
              : Center(
                  child: Container(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          Color.fromARGB(255, 46, 46, 46)),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
