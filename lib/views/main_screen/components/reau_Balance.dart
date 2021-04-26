import 'package:flutter/material.dart';

class ReauBalance extends StatelessWidget {
  final double reauWalletDifference;

  const ReauBalance({
    this.reauWalletDifference,
    @required this.language,
    Key key,
    @required this.walletValue,
  }) : super(key: key);

  final double walletValue;
  final Map<String, String> language;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        height: 90,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Color.fromARGB(255, 238, 238, 238),
                  blurRadius: 8,
                  spreadRadius: 3)
            ],
            color: Color.fromARGB(255, 248, 248, 248),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    language["MyReaus"],
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: "Roboto",
                        color: Colors.black87,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w400),
                  ),
                  Expanded(flex: 1, child: SizedBox()),
                  reauWalletDifference == 0.00 || reauWalletDifference == null
                      ? Padding(
                          padding: const EdgeInsets.only(right: 24.0),
                          child: Text(
                            "0.00000",
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: "Roboto",
                                color: Colors.black54,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(right: 24.0),
                          child: Text(
                            "+" +
                                (reauWalletDifference / 1000000000)
                                    .toStringAsFixed(0),
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: "Roboto",
                                color: Colors.green[700],
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                ],
              ),
              walletValue != null
                  ? Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: Text(
                        (walletValue / 1000000000).toStringAsFixed(0) +
                            " \$REAU",
                        style: TextStyle(
                            fontSize: 26,
                            fontFamily: "Roboto",
                            color: Colors.black87,
                            fontWeight: FontWeight.w800),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor: new AlwaysStoppedAnimation<Color>(
                            Color.fromARGB(255, 46, 46, 46)),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
