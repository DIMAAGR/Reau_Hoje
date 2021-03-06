import 'package:flutter/material.dart';

/// Este Widget tem como função mostrar o valor de mercado da moeda REAU
/// Ele receberá a variável [marketPrice] que irá definir o preço de mercado da moeda

class MarketValueWidget extends StatelessWidget {
  const MarketValueWidget({
    Key key,
    @required this.language,
    @required this.usdMarketPrice,
    @required this.marketPrice,
    @required this.currencyType,
  }) : super(key: key);

  /// a variável language troca o tipo de lingua de acordo com o selecionado pelo usuário
  final Map<String, String> language;

  /// a variavel [currencyType] define o tipo de moeda que aparecerá
  final String currencyType;

  /// a variável [marketPrice] define o preço da moeda na tela
  final double marketPrice;

  /// a variável [usdMarketPrice] define o preço da moeda em USD
  final double usdMarketPrice;

  /// a variável [bnbMarketPrice] define o preço da moeda em BNB
  // final double bnbMarketPrice;

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
      height: 150,

      width: MediaQuery.of(context).size.width * 0.92,
      child: marketPrice != null
          ? Column(
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Vira-lata Reau",
                            style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 20,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            language["MarketCap"],
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: "Roboto",
                                color: Colors.black87,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, left: 64.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _bolinha(),
                      Text(
                        currencyType +
                            marketPrice.toStringAsFixed(2).replaceAll(".", ","),
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Montserrat",
                            color: Color.fromARGB(255, 46, 46, 46),
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 64.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _bolinha(),
                      Text(
                        "US\$ " +
                            usdMarketPrice
                                .toStringAsFixed(2)
                                .replaceAll(".", ","),
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Montserrat",
                            color: Color.fromARGB(255, 46, 46, 46),
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                )
              ],
            )
          : Center(
              child: Container(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: new AlwaysStoppedAnimation<Color>(
                      Color.fromARGB(255, 46, 46, 46)),
                ),
              ),
            ),
    );
  }

  _bolinha() {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Container(
        height: 12,
        width: 12,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
          color: Color.fromARGB(255, 0, 179, 215),
        ),
      ),
    );
  }
}
