import 'package:flutter/material.dart';

/// Este Widget tem como função mostrar o valor de mercado da moeda REAU
/// Ele receberá a variável [marketPrice] que irá definir o preço de mercado da moeda

class FeeValueWidget extends StatefulWidget {
  const FeeValueWidget({
    Key key,
    @required this.language,
    @required this.actualPoolFee,
    @required this.burnedFee,
  }) : super(key: key);

  /// a variável language troca o tipo de lingua de acordo com o selecionado pelo usuário
  final Map<String, String> language;

  /// a variavel [currencyType] define o tipo de moeda que aparecerá
  final BigInt actualPoolFee;

  /// a variável [marketPrice] define o preço da moeda na tela
  final BigInt burnedFee;

  @override
  _FeeValueWidgetState createState() => _FeeValueWidgetState();
}

class _FeeValueWidgetState extends State<FeeValueWidget> {
  BigInt actualBalance;
  String visibledactualBalance;

  @override
  Widget build(BuildContext context) {
    if (widget.actualPoolFee != null) {
      BigInt a = BigInt.from(5e+23);
      BigInt b = BigInt.from(5e+23);
      actualBalance = widget.actualPoolFee - a - b;
      actualBalance *= BigInt.from(-1);
      //visibledactualBalance = convert(actualBalance.toString());
    }
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Center(
        child: Container(
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
          height: 182,

          width: MediaQuery.of(context).size.width * 0.92,
          child: widget.burnedFee != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, left: 64.0),
                      child: Text(
                        "In circulation:",
                        style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, left: 64.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _bolinha(),
                          Text(
                            "REAUS " + actualBalance.toString(),
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
                      padding: const EdgeInsets.only(top: 8.0, left: 64.0),
                      child: Text(
                        "Total Burned:",
                        style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, left: 64.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _bolinha(),
                          Text(
                            "REAUS " + widget.burnedFee.toString(),
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: "Montserrat",
                                color: Color.fromARGB(255, 46, 46, 46),
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 64.0),
                      child: Text(
                        "Total Balance:",
                        style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, left: 64.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _bolinha(),
                          Text(
                            "REAUS " + "1000000000000000000000000",
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
