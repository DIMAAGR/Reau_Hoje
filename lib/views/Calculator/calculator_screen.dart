import 'dart:async';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reau_hoje/data/connections/reauConnection/reauconnection.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  ReauConnection rc;
  bool reverse = false;
  double finalvalue = 00.00;

  // ignore: unused_field

  @override
  void initState() {
    rc = ReauConnection(enableConversor: true, verifyReauPrice: false);
    rc.defCurrentType("BRL");
    rc.startReauOptions();
    startTime = true;
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    startTime = false;
    super.dispose();
  }

  void _calcFunction(double x) {
    if (rc.getImutablebrlToReauValue() == "none") {
      finalvalue = 0.00;
    } else if (reverse) {
      setState(() {
        finalvalue = (x / double.parse(rc.getImutablebrlToReauValue()));
      });
    } else {
      setState(() {
        finalvalue = (x * double.parse(rc.getImutablebrlToReauValue()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //  final ReauProvider rp = Provider.of<ReauProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 248, 248),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 248, 248, 248),
        iconTheme: IconThemeData(color: Color.fromARGB(255, 40, 40, 40)),
        leading: IconButton(
          onPressed: () {
            //   rp.enableWalletOpt();
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
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
                height: MediaQuery.of(context).size.width * 0.84,
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
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child:
                          reverse ? REAUConvertType() : CurrencyConvertType(),
                    ),
                    rc.getImutablebrlToReauValue() != "none"
                        ? Padding(
                            padding:
                                const EdgeInsets.only(left: 16.0, top: 8.00),
                            child: Text(
                              reverse
                                  ? rc.getImutablebrlToReauValue() +
                                      " REAUS = R\$ 1.00 "
                                  : "1 Real = " +
                                      rc.getImutablebrlToReauValue() +
                                      " \$REAUS",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w800,
                                  color: Color.fromARGB(255, 60, 60, 60)),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Container(
                              height: 10,
                              width: 10,
                              child: CircularProgressIndicator(
                                strokeWidth: 1.5,
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    Color.fromARGB(255, 60, 60, 60)),
                              ),
                            ),
                          ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                          fontSize: 48,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 60, 60, 60)),
                      decoration: InputDecoration(
                        hintText: "R\$ 00.00",
                        fillColor: Colors.white,

                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        //fillColor: Colors.green
                      ),
                      onChanged: (mySubmit) {
                        _calcFunction(double.parse(mySubmit));
                      },
                    ),
                    Container(
                      height: 38,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(fit: StackFit.passthrough, children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              height: 38,
                              width: 38,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 2, 204, 204),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.swap_vert,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  if (reverse)
                                    setState(() {
                                      reverse = !reverse;
                                    });
                                  else
                                    setState(() {
                                      reverse = !reverse;
                                    });
                                },
                              ),
                            ),
                          ),
                        ),
                        Divider(),
                      ]),
                    ),
                    reverse ? CurrencyConvertType() : REAUConvertType(),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, left: 16.0),
                      child: Text(
                        reverse
                            ? "R\$ " + finalvalue.toStringAsFixed(2)
                            : "\$REAU " + finalvalue.toStringAsFixed(2),
                        style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 25,
                            fontWeight: FontWeight.w500),
                      ),
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
  int _start = 0;
  bool startTime = false;

  Future<void> startTimer() async {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0 && startTime) {
          _start = 10;
          rc.startReauOptions();
          rc.ancientWalletValue = rc.brlMyWalletValue;
          debugPrint("UPDATED!");
          setState(() {});
        } else {
          if (startTime) _start--;
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
      padding: const EdgeInsets.only(left: 16.0),
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

class REAUConvertType extends StatelessWidget {
  const REAUConvertType({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
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
            Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 16.0),
              child: Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 2, 204, 204),
                  borderRadius: BorderRadius.circular(44),
                ),
                child: Center(
                  child: Text(
                    "R",
                    style: TextStyle(
                      fontSize: 28,
                      fontStyle: FontStyle.italic,
                      color: Color.fromARGB(255, 248, 248, 248),
                      fontFamily: "Montserrat",
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 8),
            Center(
              child: Text(
                "REAU",
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
