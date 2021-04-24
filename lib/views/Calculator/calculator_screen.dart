import 'dart:async';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:reau_hoje/data/connections/reauconnection.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  ReauConnection rc;
  // ignore: unused_field

  @override
  void initState() {
    rc = ReauConnection();
    rc.defCurrentType("BRL");
    rc.startReauOptions();
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 248, 248),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 248, 248, 248),
        iconTheme: IconThemeData(color: Color.fromARGB(255, 40, 40, 40)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 8),
              child: Text(
                "Converter",
                style: TextStyle(
                    fontSize: 37,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w800,
                    color: Color.fromARGB(255, 60, 60, 60)),
              ),
            ),
            SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width * 0.80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color.fromARGB(255, 248, 248, 248),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(255, 230, 230, 230),
                        blurRadius: 6,
                        spreadRadius: 4)
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CurrencyConvertType(),
                    rc.getImutablebrlToReauValue() != "none"
                        ? Text(
                            "1 Real = " +
                                rc.getImutablebrlToReauValue() +
                                " \$REAUS",
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w800,
                                color: Color.fromARGB(255, 60, 60, 60)),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 4.5,
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    Color.fromARGB(255, 60, 60, 60)),
                              ),
                            ),
                          ),
                    TextFormField(
                      initialValue: "00.00",
                      style: TextStyle(
                          fontSize: 48,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 60, 60, 60)),
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        //fillColor: Colors.green
                      ),
                      onChanged: (mySubmit) {
                        rc.setbrlToReauValue(double.parse(mySubmit));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

//TIMER!

  // ignore: unused_field
  Timer _timer;
  int _start = 5;

  Future<void> startTimer() async {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          _start = 10;
          rc.startReauOptions();
          rc.ancientWalletValue = rc.brlMyWalletValue;
          debugPrint("UPDATED!");
          setState(() {});
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }
}

class CurrencyConvertType extends StatelessWidget {
  const CurrencyConvertType({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 48,
        width: 123,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(255, 240, 240, 240),
                blurRadius: 4,
                spreadRadius: 2)
          ],
          color: Color.fromARGB(255, 248, 248, 248),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Flag(
                  "BR",
                  height: 40,
                  width: 40,
                ),
              ),
            ),
            SizedBox(width: 8),
            Center(
              child: Text(
                "BRL: Real",
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w800,
                    color: Color.fromARGB(255, 60, 60, 60)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
