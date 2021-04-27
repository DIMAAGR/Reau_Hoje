import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reau_hoje/data/connections/reauConnection/conversor/moneyConversion.dart';
import 'package:reau_hoje/data/connections/reauConnection/reauconnection.dart';
import 'package:reau_hoje/data/data.dart';
import 'package:reau_hoje/providers/reau_provider.dart';
import 'package:reau_hoje/utils/language.dart';
import 'package:reau_hoje/views/main_screen/components/market_value.dart';
import 'package:reau_hoje/views/main_screen/components/screen_buttons.dart';
import 'package:reau_hoje/views/main_screen/components/custom_reau_app_bar.dart';
import 'package:reau_hoje/views/main_screen/components/reau_Balance.dart';
//import 'package:reau_hoje/views/main_screen/components/market_value.dart';

class MainScreen extends StatefulWidget {
  final ReauConnection rc;
  MainScreen({this.rc});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // ReauConnection rc;
  ReauProvider rp;
  MoneyConversor mc = MoneyConversor();
  Language lang = Language();
  Map<String, String> language;
  String myLang;

  @override
  void dispose() {
    setState(() {});
    startTime = false;
    super.dispose();
  }

  // ignore: unused_field
  @override
  void initState() {
    language = lang.getSelectedLanguageInfo();
    lang.setLanguage(language: MyPreferences.getLanguage());
    myLang = lang.getLanguage();
    // rc = ReauConnection(enableConversor: false, verifyReauPrice: true);
    // rc.defCurrentType("BRL");
    // rc.startReauOptions();
    rp = ReauProvider();
    // rp.setReauConnection(rc);
    startTime = true;
    startTimer();
    super.initState();
  }

  // ignore: unused_field
  Timer _timer;
  int _start = 15;
  bool startTime = false;

  FutureOr onGoBack(dynamic value) {
    lang.setLanguage(language: MyPreferences.getLanguage());
    language = lang.getSelectedLanguageInfo();
    setState(() {});
  }

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
            floating: true,
            snap: false,
            pinned: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            expandedHeight: MediaQuery.of(context).size.height,

            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Color.fromARGB(255, 4, 174, 174),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomReauAppBar(
                        rc: widget.rc,
                        appUser: widget.rc.appUser,
                        updown: widget.rc.updown,
                        difference: widget.rc.difference,
                        diffstring: widget.rc.diffstring),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0, top: 72.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              language["Hello"],
                              style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 40,
                                  color: Color.fromARGB(255, 248, 248, 248),
                                  fontWeight: FontWeight.w300),
                            ),
                            Text(
                              widget.rc.appUser + "!",
                              style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 50,
                                  color: Color.fromARGB(255, 248, 248, 248),
                                  fontWeight: FontWeight.w600),
                            ),
                            _valordaWallet(context),
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
                      language["MyWallet"],
                      style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 30,
                          color: Color.fromARGB(255, 48, 48, 48),
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: InkWell(
                      onTap: () {
                        Clipboard.setData(
                            new ClipboardData(text: MyPreferences.getWallet()));
                        ScaffoldMessenger.of(context)
                            .showSnackBar(_snackBar(context));
                      },
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
                                        color:
                                            Color.fromARGB(255, 248, 248, 248),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        color:
                                            Color.fromARGB(255, 248, 248, 248),
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
                                language["MyWallet"],
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
                                widget.rc.myAdress,
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
                                    widget.rc.appUser.toUpperCase(),
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
                  ),
                  ReauBalance(
                    language: language,
                    walletValue: widget.rc.walletValue,
                    reauWalletDifference: widget.rc.reauWalletValueDifference,
                  ),
                  ScreenButtons(
                      rc: widget.rc, language: language, onGoBack: onGoBack),
                  Align(
                    alignment: Alignment.center,
                    child: MarketValueWidget(
                        language: language,
                        usdMarketPrice: widget.rc.usdMarketValue,
                        marketPrice: widget.rc.marketcap,
                        currencyType: currencytype()),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Container(
                        height: 90,
                        width: MediaQuery.of(context).size.width,
                        color: Color.fromARGB(255, 50, 50, 50),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 16.0, left: 16.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Reau Hoje",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 248, 248, 248),
                                      fontFamily: "Montserrat",
                                      fontSize: 20,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: SizedBox(),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 16.0),
                                    child: OutlinedButton(
                                      onPressed: () =>
                                          _botomsheetdonation(context),
                                      child: Text(
                                        language["Donatenow"],
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 248, 248, 248),
                                            fontFamily: "Roboto",
                                            fontSize: 15,
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Text(
                                    language["AllRightReserved"],
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 248, 248, 248),
                                        fontFamily: "Roboto",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w200),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _botomsheetdonation(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 160,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                      onPressed: () {
                        Clipboard.setData(
                            new ClipboardData(text: "attackdiamond@gmail.com"));
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(_snackBar(context));
                      },
                      child: Text("PIX: attackdiamond@gmail.com")),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                      onPressed: () {
                        Clipboard.setData(new ClipboardData(
                            text:
                                "0x056982E47890Ff8eeac1d57bb36Ef48Dd0D5A823"));
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(_snackBar(context));
                      },
                      child: Text(
                          "WALLET: 0x056982E47890Ff8eeac1d57bb36Ef48Dd0D5A823")),
                )
              ],
            ),
          );
        });
  }

  String currencytype() {
    switch (widget.rc.getCurrentType()) {
      case "BRL":
        return "R\$ ";
        break;
      case "USD":
        return "US\$ ";
        break;
      case "AUD":
        return "AU\$ ";
        break;
      case "GBP":
        return "\u{20A4} ";
        break;
      case "CAD":
        return "CA\$ ";
        break;
      case "EUR":
        return "\u{20AC} ";
        break;
      case "JPY":
        return "\u{00A5} ";
        break;
      case "ARS":
        return "\u{20B3} ";
        break;
      case "CNY":
        return "\u{00A5} ";
        break;
      case "AED":
        return "\u{17dB} ";
        break;
      case "RUB":
        return "\u{20BD} ";
        break;
      case "TRY":
        return "\u{20BA} ";
        break;
      default:
        return "US\$ ";
    }
  }

  _snackBar(BuildContext context) {
    return SnackBar(
      duration: Duration(seconds: 3),
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      width: MediaQuery.of(context).size.width * 0.96,
      behavior: SnackBarBehavior.floating,
      padding: const EdgeInsets.all(4),
      content: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Text("Copiado com Sucesso!"),
      ),
    );
  }

  //Mostra o que a wallet tem em BRL
  _valordaWallet(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 5),
      child: widget.rc.currentWalletValue != null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  language["TotalWalletValue"],
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Roboto",
                      color: Color.fromARGB(255, 248, 248, 248),
                      fontWeight: FontWeight.w400),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2, bottom: 8.0),
                  child: Text(
                    currencytype() +
                        widget.rc.currentWalletValue
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
        if (_start == 0 && startTime) {
          _start = 10;
          widget.rc.startReauOptions();
          widget.rc.ancientWalletValue = widget.rc.brlMyWalletValue;
          setState(() {});
        } else if (startTime) {
          setState(() {
            _start--;
          });
        }
      },
    );
  }
}
