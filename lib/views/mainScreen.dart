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
  final myAdress = "0x056982E47890Ff8eeac1d57bb36Ef48Dd0D5A823";
  int amount = 0;

  //Definições Obtidas a partir do contrato do reau
  var totalFees;
  var walletValue;
  var deadBalance;
  double reauBNBprice;
  double reauUSDPrice;
  double dollarPrice;
  bool data;

  @override
  void initState() {
    web3 = Web3Client(url, httpClient);
    debugPrint(myAdress);
    startReauOptions(myAdress);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.blue), //Color.fromARGB(255, 2, 214, 214)),
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 41.0),
                    child: Container(
                      height: 28,
                      width: 56,
                      decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        children: [
                          Icon(
                            Icons.keyboard_arrow_up,
                            color: Colors.greenAccent,
                          ),
                          Text(
                            "55%",
                            style: TextStyle(
                                color: Colors.greenAccent,
                                fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Minha Carteira",
                    style: TextStyle(
                        color: Color.fromARGB(255, 248, 248, 248),
                        fontWeight: FontWeight.w900),
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: walletValue != null
                          ? Text(
                              walletValue.toString(),
                              style: TextStyle(
                                  fontSize: 55,
                                  color: Color.fromARGB(255, 248, 248, 248),
                                  fontWeight: FontWeight.w900),
                            )
                          : CircularProgressIndicator(
                              strokeWidth: 2.5,
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Color.fromARGB(255, 246, 246, 246)),
                            ),
                    ),
                  ),
                  Text(
                    "  MyPreferences.getWallet()",
                    style: TextStyle(
                        fontSize: 11,
                        color: Color.fromARGB(255, 248, 248, 248),
                        fontWeight: FontWeight.w900),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 28,
                          width: 46,
                          decoration: BoxDecoration(
                              color: Colors.black26,
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
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
    print(result);
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
    walletValue = walletBalanceResult[0];
    deadBalance = deadBalanceResult[0];
    totalFees = totalFeesResult[0];
    data = true;
    setState(() {});
    loadPancake();
  }

//==============================================================================================//
//
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
    print("reauBNBprice: " + reauPriceBnb.toString());
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
    debugPrint("BnbPrice: " + bnbPrice.toString());
    double a = bnbPrice;
    double b = reauBNBprice;
    reauUSDPrice = a * b;
    debugPrint("ReauPrice: " + reauUSDPrice.toString());
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
    debugPrint("cBRLPrice: " + cBrlprice.toString());
    double a = cBrlprice;
    double b = reauBNBprice;
    dollarPrice = a * b;
    debugPrint("dollarPrice: " + dollarPrice.toString());
  }
}
