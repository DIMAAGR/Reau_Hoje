import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:reau_hoje/data/data.dart';
import 'package:reau_hoje/views/main_screen/components/app_btn.dart';
import 'package:reau_hoje/views/main_screen/components/custom_reau_app_bar.dart';
import 'package:reau_hoje/views/main_screen/components/market_value.dart';
import 'package:reau_hoje/views/main_screen/components/reau_Balance.dart';
import 'package:web3dart/web3dart.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var url = "https://bsc-dataseed1.binance.org:443";

  var httpClient = new Client();

  Web3Client web3;

  String appUser = "Italo";
  final myAdress = "0x000000000000000000000000000000000000dead";

  //Definições Obtidas a partir do contrato do reau
  var deadBalance;
  var totalFees;
  BigInt totalSupply;
  BigInt walletValue;
  double reauBNBprice;
  double reauUSDPrice;
  double reauBRLPrice;
  double dollarPrice;
  double reauUSD;
  double brlWalletValue;
  double bnbPrice;
  double totalBRLFeesValue;
  bool data;
  String diffstring;
  bool updown;

  //DATA STATUS
  double ancientWalletValue;
  double difference = 0;
  double ancientdifference = 0;

  // ignore: unused_field
  Timer _timer;

  @override
  void initState() {
    web3 = Web3Client(url, httpClient);

    debugPrint(myAdress);
    startReauOptions(myAdress);
    startTimer();
    super.initState();
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
                appUser: appUser,
                updown: updown,
                difference: difference,
                diffstring: diffstring),
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
                  brlWalletValue != null
                      ? Padding(
                          padding: const EdgeInsets.only(
                              top: 2, left: 16.0, bottom: 8.0),
                          child: Text(
                            "R\$ " +
                                brlWalletValue
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
                    ReauBalance(walletValue: walletValue),
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
            MarketValueWidget(marketPrice: totalBRLFeesValue),
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
          setState(() {
            debugPrint("UPDATED!");
            ancientWalletValue = brlWalletValue;
            startReauOptions(myAdress);
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  //Calcula a diferenca/volatilidade do preço do reau
  void diff() {
    if (ancientWalletValue != null) if (ancientWalletValue != brlWalletValue) {
      double d = ((brlWalletValue - ancientWalletValue) / ancientWalletValue) *
          100; //d = Diferença
      difference = d;

      if (difference.isNegative) difference *= -1;
    }

    if (difference == -0.0) difference = 0.0;
    if (difference < -0.01 || difference > 0.01) {
      if (difference > ancientdifference) {
        updown = true;
      } else {
        updown = false;
      }
      ancientdifference = difference;
      diffstring = difference.toStringAsFixed(2) + "%";
      setState(() {});
      hello();
    }
  }

//==============================================================================================//
  // CARREGA O CONTRATO DO VIRA LATA FINANCE REAU
  Future<DeployedContract> loadContract(
      String contractAdress, String abi, String contractName) async {
    final contract = DeployedContract(ContractAbi.fromJson(abi, contractName),
        EthereumAddress.fromHex(contractAdress));
    return contract;
  }

  void hello() => print("Hello Test");
//==============================================================================================//
  // Tem a função de transferir os argumentos carregar o contrato
  // e receber a informação desejada do servidor
  Future<List<dynamic>> query(
      {String functionName,
      List<dynamic> args,
      DeployedContract contract}) async {
    final ethFunction = contract.function(functionName);
    final result = await web3.call(
        contract: contract, function: ethFunction, params: args);
    return result;
  }

//==============================================================================================//
  // RECEBE O VALOR NUMERICO(A QUANTIDADE) de REAUS QUE VOCÊ TEM EM SUA CARTEIRA
  Future<void> startReauOptions(String wallet) async {
    // INICIA ABI
    String abi = await rootBundle.loadString('lib/assets/abi.json');

    //Carrega o Contrato do ViraLataFinance recebendo o Contrato o tipo ABI e o Nome do Contrato
    final contract =
        await loadContract(ProgramData().reauContract, abi, "ViraLataFinance");

    //Mostra o Balanço que há em sua carteira!
    List<dynamic> walletBalanceResult = await query(
        functionName: "balanceOf",
        args: [EthereumAddress.fromHex(myAdress)],
        contract: contract);

    // Mostra o totalSupply do Vira Lata Finance Reau
    List<dynamic> totalFeesResult =
        await query(functionName: "totalFees", args: [], contract: contract);

    // Mostra o total de moedas mortas
    List<dynamic> deadBalanceResult = await query(
        functionName: "balanceOf",
        args: [
          EthereumAddress.fromHex("0x000000000000000000000000000000000000dead")
        ],
        contract: contract);

    //Retorno das Informações
    walletValue = walletBalanceResult[0];
    deadBalance = deadBalanceResult[0];
    totalFees = totalFeesResult[0];
    data = true;
    loadPancake();
  }

//==============================================================================================//
//Carrega o contrato da pancake
  Future<void> loadPancake() async {
    String abi = await rootBundle.loadString('lib/assets/lpAbi.json');
    final contract = await loadContract(
        "0x7Cc956136C36e7Fbd6B74C07d9E40Eccd3779249",
        abi,
        "PancakePair"); // Carregará o pancake contract

    List<dynamic> getReauReserves =
        await query(functionName: "getReserves", args: [], contract: contract);
    var reauPriceBnb = (getReauReserves[1] / getReauReserves[0]) * 0.000000001;
    reauBNBprice = reauPriceBnb;
    loadBnbUsd();
  }

//Carrega o contrato da BNBUSD
  Future<void> loadBnbUsd() async {
    // contract: 0x1B96B92314C44b159149f7E0303511fB2Fc4774f
    //
    String abi = await rootBundle.loadString('lib/assets/lpAbi.json');
    final contract = await loadContract(
        "0x1B96B92314C44b159149f7E0303511fB2Fc4774f",
        abi,
        "PancakePair"); // Carregará o pancake contract
    //Receberá o BNBUSD Reserves
    List<dynamic> getBnbUsdReserves =
        await query(functionName: "getReserves", args: [], contract: contract);
    //Calculará o preço do bnb;
    double bnbPrice = getBnbUsdReserves[1] / getBnbUsdReserves[0];
    this.bnbPrice = bnbPrice;
    double a = bnbPrice;
    double b = reauBNBprice;
    reauUSDPrice = a * b;
    loadCBrl();
  }

  Future<void> loadCBrl() async {
    // contract: 0x1B96B92314C44b159149f7E0303511fB2Fc4774f
    //
    String abi = await rootBundle.loadString('lib/assets/lpAbi.json');
    final contract = await loadContract(
        "0x3E820DF7D7086DE2D46d908d04c0A24968B32b94",
        abi,
        "PancakePair"); // Carregará o pancake contract
    //Receberá o BNBUSD Reserves
    List<dynamic> getCbrlReserves =
        await query(functionName: "getReserves", args: [], contract: contract);
    //Calculará o preço do bnb;
    double cBrlprice =
        (getCbrlReserves[0] / getCbrlReserves[1]) * 1000000000000;
    double a = cBrlprice;
    double b = reauBNBprice;
    reauUSD = a * b;
    dollarPrice = cBrlprice / bnbPrice;
    reauBRLPrice = reauBNBprice * bnbPrice * dollarPrice;
    totalSupply = deadBalance - totalFees;
    returnReauBRLValue();
    returnTotalBRLFeesValue();
    diff();
    setState(() {});
  }

  //Colocar o valor do reau na carteira!
  void returnReauBRLValue() =>
      brlWalletValue = (reauBRLPrice * walletValue.toDouble()) / 1000000000;
  void returnTotalBRLFeesValue() =>
      totalBRLFeesValue = (reauBRLPrice * totalSupply.toDouble()) / 1000000000;
}
