import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:reau_hoje/data/data.dart';

class MyWallet extends StatefulWidget {
  @override
  _MyWalletState createState() => _MyWalletState();
}

class _MyWalletState extends State<MyWallet> {
  final ProgramData data = ProgramData();
  String wallet;

  @override
  Widget build(BuildContext context) {
    data.getMyWallet();
    wallet = data.minhaWallet;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Esta é sua Carteira?",
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontFamily: "Roboto",
                fontSize: 25,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 235, 235, 235)),
                height: 285,
                width: 285,
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      wallet,
                      textAlign: TextAlign.justify,
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                          color: Color.fromARGB(255, 48, 48, 48),
                          fontStyle: FontStyle.italic,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.9,
                          fontSize: 30),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _returnButton(),
                  SizedBox(
                    width: 64,
                  ),
                  _continueButton(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _continueButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(225, 238, 238, 238),
          borderRadius: BorderRadius.circular(60),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(60),
          onTap: () async {},
          child: Padding(
            padding: const EdgeInsets.all(16.0), // Tamanho do Circulo
            child: Icon(
              Icons.arrow_forward_ios,
              size: 23,
              color: Color.fromARGB(255, 114, 114, 114),
            ),
          ),
        ),
      ),
    );
  }

  _returnButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(225, 238, 238, 238),
          borderRadius: BorderRadius.circular(60),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(60),
          onTap: () async {},
          child: Padding(
            padding: const EdgeInsets.all(16.0), // Tamanho do Circulo
            child: Icon(
              Icons.cancel,
              size: 23,
              color: Color.fromARGB(255, 114, 114, 114),
            ),
          ),
        ),
      ),
    );
  }
}
