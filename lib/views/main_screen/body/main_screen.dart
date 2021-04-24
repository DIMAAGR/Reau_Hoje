import 'dart:async';
import 'package:flutter/material.dart';
import 'package:reau_hoje/data/connections/reauconnection.dart';
import 'package:reau_hoje/views/main_screen/components/screen_buttons.dart';
import 'package:reau_hoje/views/main_screen/components/custom_reau_app_bar.dart';
import 'package:reau_hoje/views/main_screen/components/reau_Balance.dart';
//import 'package:reau_hoje/views/main_screen/components/market_value.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  ReauConnection rc;

  // ignore: unused_field

  @override
  void initState() {
    rc = ReauConnection(false);
    rc.defCurrentType("BRL");
    rc.startReauOptions();
    startTimer();
    super.initState();
  }

  setmyState() {
    setState(() {});
  }

  // ignore: unused_field
  Timer _timer;
  int _start = 15;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 245, 245),
      body: CustomScrollView(
        //Adicionamos Slivers A Partir do SliverAppBar
        slivers: [
          SliverAppBar(
            //Adicionamos um flexibleSpace que receberá um Widget
            // O Widget Será o Container
            floating: false,
            snap: false,
            pinned: false,

            backgroundColor: Color.fromARGB(255, 4, 174, 174),
            expandedHeight: MediaQuery.of(context).size.height,
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hello!"),
                  CustomReauAppBar(
                      rc: rc,
                      appUser: rc.appUser,
                      updown: rc.updown,
                      difference: rc.difference,
                      diffstring: rc.diffstring),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 72.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Olá, ",
                            style: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 40,
                                color: Color.fromARGB(255, 248, 248, 248),
                                fontWeight: FontWeight.w300),
                          ),
                          Text(
                            rc.appUser + "!",
                            style: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 50,
                                color: Color.fromARGB(255, 248, 248, 248),
                                fontWeight: FontWeight.w600),
                          ),
                          _valordaWalletemBRL(context),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 176.0),
                              child: Center(
                                  child: Icon(
                                Icons.keyboard_arrow_up,
                                size: 28,
                                color: Color.fromARGB(255, 248, 248, 248),
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // O SliverFillRemaning preenche o espaço vazio restante da tela do APP
          // Nesse caso irá preencher o espaço que ficará para a Carteira
          SliverFillRemaining(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 57.0, left: 16.0),
                    child: Text(
                      "Minha Carteira",
                      style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 30,
                          color: Color.fromARGB(255, 48, 48, 48),
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color.fromARGB(255, 251, 220,
                              138)), //Color.fromARGB(255, 74, 70, 255)),
                      height: 210,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, left: 8),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8.0, left: 8.0),
                                  child: Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 248, 248, 248),
                                      borderRadius: BorderRadius.circular(44),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "R",
                                        style: TextStyle(
                                          fontSize: 28,
                                          fontStyle: FontStyle.italic,
                                          color: Color.fromARGB(
                                              255, 251, 220, 138),
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
                                  ],
                                ),
                                Expanded(
                                  child: SizedBox(),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                      color: Colors.black26,
                                      borderRadius: BorderRadius.circular(44),
                                    ),
                                    child: Center(
                                        child: Icon(
                                      Icons.copy,
                                      color: Color.fromARGB(255, 248, 248, 248),
                                      size: 16,
                                    )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 64,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 16.0, bottom: 4),
                            child: Text(
                              "Minha Carteira:",
                              style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              rc.myAdress,
                              style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 15,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Text(
                                  rc.appUser.toUpperCase(),
                                  style: TextStyle(
                                      fontFamily: "Roboto",
                                      fontSize: 15,
                                      fontWeight: FontWeight.w900),
                                ),
                              ),
                              Expanded(
                                child: SizedBox(),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: Text(
                                  "XX/XX",
                                  style: TextStyle(
                                      fontFamily: "Roboto",
                                      fontSize: 15,
                                      fontWeight: FontWeight.w900),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  ReauBalance(
                    walletValue: rc.walletValue,
                    reauWalletDifference: rc.reauWalletValueDifference,
                  ),
                  ScreenButtons(rc: rc),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

//Mostra os Botões que estarão no app

  //Mostra o que a wallet tem em BRL
  _valordaWalletemBRL(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 5),
      child: rc.currentWalletValue != null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Valor Total da Sua Carteira:",
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Roboto",
                      color: Color.fromARGB(255, 248, 248, 248),
                      fontWeight: FontWeight.w400),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2, bottom: 8.0),
                  child: Text(
                    "R\$ " +
                        rc.currentWalletValue
                            .toStringAsFixed(2)
                            .replaceAll('.', ","),
                    style: TextStyle(
                        fontSize: 50,
                        fontFamily: "Roboto",
                        color: Color.fromARGB(255, 248, 248, 248),
                        fontWeight: FontWeight.w700),
                  ),
                )
              ],
            )
          : Padding(
              padding: const EdgeInsets.all(48.0),
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 4.5,
                  valueColor: new AlwaysStoppedAnimation<Color>(
                      Color.fromARGB(255, 246, 246, 246)),
                ),
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
