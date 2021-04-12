import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:reau_hoje/data/data.dart';
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
  final myAdress = "0x056982E47890Ff8eeac1d57bb36Ef48Dd0D5A823";

  //Definições Obtidas a partir do contrato do reau
  var totalFees;
  BigInt walletValue;
  var deadBalance;
  double reauBNBprice;
  double reauUSDPrice;
  double reauBRLPrice;
  double dollarPrice;
  double reauUSD;
  double brlWalletValue;
  double bnbPrice;
  bool data;

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
    String diffstring = difference.toStringAsFixed(2) +
        "%"; //Recebe o balor da diferença em $ do REAU
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, top: 12.0),
                  child: Row(
                    children: [
                      Text(
                        "Olá, ",
                        style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 35,
                            fontWeight: FontWeight.w300),
                      ),
                      Text(
                        appUser,
                        style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 35,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12.0, top: 12.0),
                  child: Container(
                    height: 28,
                    width: 46,
                    decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: Text(
                        "BRL",
                        style: TextStyle(
                            color: Color.fromARGB(255, 248, 248, 248),
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ),
                _reauVariation(diffstring),
              ],
            ),
            SizedBox(
              height: 18,
            ),
            Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[500],
                      blurRadius: 18,
                    )
                  ],
                  borderRadius: BorderRadius.circular(15),
                  color: Color.fromARGB(
                      255, 25, 64, 217)), //Color.fromARGB(255, 74, 70, 255)),
              height: 125,
              width: MediaQuery.of(context).size.width * 0.93,
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
                          padding:
                              const EdgeInsets.only(left: 16.0, bottom: 8.0),
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
          ],
        ),
      ),
    );
  }

  _reauVariation(String diffstring) {
    return difference > ancientdifference
        ? Padding(
            padding: const EdgeInsets.only(right: 16.0, top: 12.0),
            child: Container(
              height: 28,
              width: 58 + diffstring.length.toDouble() * 2.4,
              decoration: BoxDecoration(
                  color: Colors.greenAccent[700],
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: Row(
                  children: [
                    Icon(
                      Icons.keyboard_arrow_up,
                      color: Colors.white,
                    ),
                    Text(
                      diffstring,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              ),
            ),
          )
        : difference < ancientdifference
            ? Padding(
                padding: const EdgeInsets.only(right: 16.0, top: 12.0),
                child: Container(
                  height: 28,
                  width: 64 + diffstring.length.toDouble() * 2.3,
                  decoration: BoxDecoration(
                      color: Colors.redAccent[700],
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: Row(
                      children: [
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                        ),
                        Text(
                          diffstring,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : difference == 0.0
                ? Padding(
                    padding: const EdgeInsets.only(right: 16.0, top: 12.0),
                    child: Container(
                      height: 28,
                      width: 58,
                      decoration: BoxDecoration(
                          color: Colors.grey[700],
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                        child: Text(
                          diffstring,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                  )
                : SizedBox();
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
    if (ancientWalletValue != brlWalletValue) {
      if (difference < -0.02 || difference > 0.02) {
        ancientdifference = difference;
      }
    }
    if (ancientWalletValue != null) if (ancientWalletValue != brlWalletValue) {
      double d = ((brlWalletValue - ancientWalletValue) / ancientWalletValue) *
          100; //d = Diferença
      difference = d;
      if (difference.isNegative) difference *= -1;
    }
    if (difference == -0.0) difference = 0.0;
  }

//==============================================================================================//
  // CARREGA O CONTRATO DO VIRA LATA FINANCE REAU
  Future<DeployedContract> loadContract(
      String contractAdress, String abi, String contractName) async {
    final contract = DeployedContract(ContractAbi.fromJson(abi, contractName),
        EthereumAddress.fromHex(contractAdress));
    return contract;
  }

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
    returnReauBRLValue();
    diff();
    setState(() {});
  }

  //Colocar o valor do reau na carteira!
  void returnReauBRLValue() =>
      brlWalletValue = (reauBRLPrice * walletValue.toDouble()) / 1000000000;
}
