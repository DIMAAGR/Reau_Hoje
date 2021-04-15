import 'package:flutter/material.dart';
import 'package:reau_hoje/views/main_screen/components/difference.dart';

class ReauBalance extends StatelessWidget {
  final double reauWalletDifference;
  const ReauBalance({
    this.reauWalletDifference,
    Key key,
    @required this.walletValue,
  }) : super(key: key);

  final BigInt walletValue;

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
                  Expanded(flex: 1, child: SizedBox()),
                  reauWalletDifference == 0.00 || reauWalletDifference == null
                      ? Padding(
                          padding:
                              const EdgeInsets.only(right: 24.0, bottom: 8),
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
                          padding:
                              const EdgeInsets.only(right: 24.0, bottom: 8),
                          child: Text(
                            "+" + reauWalletDifference.toStringAsFixed(5),
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: "Roboto",
                                color: Colors.green[700],
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                ],
              ),
              Text(
                "Meus Reaus:",
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Roboto",
                    color: Colors.black87,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w400),
              ),
              walletValue != null
                  ? Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: Text(
                        walletValue.toString() + " \$REAU",
                        style: TextStyle(
                            fontSize: 18,
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
