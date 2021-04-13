import 'package:flutter/material.dart';

class ReauBalance extends StatelessWidget {
  const ReauBalance({
    Key key,
    @required this.walletValue,
  }) : super(key: key);

  final BigInt walletValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
    );
  }
}
