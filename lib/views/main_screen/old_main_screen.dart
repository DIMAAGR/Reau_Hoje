import 'dart:async';
import 'package:flutter/material.dart';
import 'package:reau_hoje/data/reauconnection.dart';
import 'package:reau_hoje/views/main_screen/components/app_btn.dart';
import 'package:reau_hoje/views/main_screen/components/custom_reau_app_bar.dart';
import 'package:reau_hoje/views/main_screen/components/market_value.dart';
import 'package:reau_hoje/views/main_screen/components/reau_Balance.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  ReauConnection rc;

  // ignore: unused_field
  Timer _timer;

  @override
  void initState() {
    rc = ReauConnection(setmyState());
    rc.startReauOptions();
    startTimer();
    super.initState();
  }

  setmyState() {
    setState(() {});
  }

  int _start = 15;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 245, 245),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            CustomReauAppBar(
                appUser: rc.appUser,
                updown: rc.updown,
                difference: rc.difference,
                diffstring: rc.diffstring),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(left: 24.0, top: 24.0),
                child: Text(
                  "Visão Geral da Conta",
                  style: TextStyle(
                    color: Colors.black87,
                    fontFamily: "Roboto",
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 144, 140, 255),
                      blurRadius: 8,
                    )
                  ],
                  borderRadius: BorderRadius.circular(15),
                  color: Color.fromARGB(
                      255, 74, 70, 255)), //Color.fromARGB(255, 74, 70, 255)),
              height: 150,
              width: MediaQuery.of(context).size.width * 0.92,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      "Valor Total:",
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: "Roboto",
                          color: Color.fromARGB(255, 248, 248, 248),
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  rc.brlWalletValue != null
                      ? Padding(
                          padding: const EdgeInsets.only(
                              top: 2, left: 16.0, bottom: 8.0),
                          child: Text(
                            "R\$ " +
                                rc.brlWalletValue
                                    .toStringAsFixed(2)
                                    .replaceAll('.', ","),
                            style: TextStyle(
                                fontSize: 45,
                                fontFamily: "Roboto",
                                color: Color.fromARGB(255, 248, 248, 248),
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
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.92,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(255, 235, 235, 235),
                        blurRadius: 10),
                  ],
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[50],
                ),
                height: 85,
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
                    ReauBalance(walletValue: rc.walletValue),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(
                              top: 16, bottom: 16, left: 16, right: 8),
                          child: AppBtn(
                            active: true,
                            text: "Minha\nCarteira",
                            function: () {},
                            icon: Icon(
                              Icons.account_balance_wallet,
                              size: 35,
                              color: Colors.black54,
                            ),
                          )),
                      Padding(
                          padding: const EdgeInsets.only(
                              top: 16, bottom: 16, left: 8, right: 8),
                          child: AppBtn(
                            icon: Icon(
                              Icons.settings,
                              size: 35,
                              color: Colors.black54,
                            ),
                            function: () {},
                            active: true,
                            text: "Configurações",
                          )),
                      Padding(
                          padding: const EdgeInsets.only(
                              top: 16, bottom: 16, left: 8, right: 8),
                          child: AppBtn(
                            text: "Analises\n(Indisponivel)",
                            function: () {},
                            icon: Icon(
                              Icons.bar_chart,
                              size: 35,
                              color: Colors.white,
                            ),
                            active: false,
                          )),
                    ],
                  ),
                ),
              ),
            ),
            MarketValueWidget(
                usdMarketPrice: rc.usdMarketValue,
                bnbMarketPrice: rc.bnbMarketValue,
                marketPrice: rc.totalBRLFeesValue),
          ],
        ),
      ),
    );
  }

  Future<void> startTimer() async {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          _start = 10;
          rc.startReauOptions();
          debugPrint("UPDATED!");
          rc.ancientWalletValue = rc.brlWalletValue;

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
