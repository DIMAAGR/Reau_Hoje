import 'dart:async';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:reau_hoje/data/data.dart';
import 'package:reau_hoje/views/main_screen/components/market_value.dart';
import 'package:web3dart/contracts.dart';
import 'package:web3dart/web3dart.dart';

class ReauConnection {
  var url = "https://bsc-dataseed1.binance.org:443";

  var httpClient = new Client();

  Web3Client web3;
  String appUser = "Italo Matos";
  final myAdress = "0xf43415f2dbca4853664abbdc0e9a7ce3d2010d36";

  ReauConnection() {
    web3 = Web3Client(url, httpClient);
  }

  //Definições Obtidas a partir do contrato do reau
  var deadBalance;
  var totalFees;

  BigInt walletValue;
  double reauBNBprice;
  double reauUSDPrice;

  double bnbPrice;
  double totalBRLFeesValue;
  bool data;
  bool updown;
  BigInt ancientWallet;

  //DATA STATUS
  double ancientWalletValue;
  double difference = 0;
  double ancientdifference = 0;

  // CURRENT TYPE
  String _currentType;

  // ignore: unused_field
  Timer _timer;

  // ESTA FUNÇÃO DEFINE O TIPO DE MOEDA QUE SERA UTILIZADA
  void defCurrentType(String currency) {
    _currentType = currency;
  }

  double currentWalletValue;

  // Essa função define o tipo de moeda do app
  setCurrency() {
    switch (_currentType) {
      case "BRL":
        currentWalletValue = brlMyWalletValue;
        break;
      case "USD":
        currentWalletValue = usdMyWalletValue;
        break;
    }
  }

  //Obtem o valor da moeda do APP
  String getCurrentType() => _currentType;

  //Strings Usadas no DIFF para mostrar a diferença no valor recebido
  String diffstring;
  String diffBalanceString;

  //Calcula a diferenca/volatilidade do preço do reau
  void diff() {
    if (ancientWalletValue != null) if (ancientWalletValue !=
        brlMyWalletValue) {
      double d =
          ((brlMyWalletValue - ancientWalletValue) / ancientWalletValue) *
              100; //d = Diferença
      difference = d;

      if (difference.isNegative) difference *= -1;
    }

    if (difference == -0.0) difference = 0.0;

    if (difference < -0.01 || difference > 0.01) {
      if (difference > ancientdifference)
        updown = true;
      else
        updown = false;

      ancientdifference = difference;
      diffstring = difference.toStringAsFixed(2) + "%";
      // setmyState();
    }
  }

//==============================//
// CARREGA O CONTRATO DA MOEDA //
  Future<DeployedContract> loadContract(
          String contractAdress, String abi, String contractName) async =>
      DeployedContract(ContractAbi.fromJson(abi, contractName),
          EthereumAddress.fromHex(contractAdress));

//==============================================================================================//
  // Tem a função de transferir os argumentos carregar o contrato
  // e receber a informação desejada do servidor
  Future<List<dynamic>> query(
          {String functionName,
          List<dynamic> args,
          DeployedContract contract}) async =>
      await web3.call(
          contract: contract,
          function: _ethFunction(functionName, contract),
          params: args);

//Cria o contrato que sera utilizado para verificar os valores da moeda
  _ethFunction(String functionName, DeployedContract contract) =>
      contract.function(functionName);

//==============================================================================================//
  // RECEBE O VALOR NUMERICO(A QUANTIDADE) de REAUS QUE VOCÊ TEM EM SUA CARTEIRA
  Future<void> startReauOptions() async {
    // INICIA ABI
    String abi = await rootBundle.loadString('lib/assets/abi.json');

    //Carrega o Contrato do ViraLataFinance recebendo o Contrato o tipo ABI e o Nome do Contrato
    DeployedContract contract =
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
    // Carregará o pancake contract
    String abi = await rootBundle.loadString('lib/assets/lpAbi.json');
    final contract = await loadContract(
        "0x1B96B92314C44b159149f7E0303511fB2Fc4774f", abi, "PancakePair");

    //Receberá o BNBUSD Reserves
    List<dynamic> getBnbUsdReserves =
        await query(functionName: "getReserves", args: [], contract: contract);

    //Calculará o preço do bnb;
    double bnbPrice = getBnbUsdReserves[1] / getBnbUsdReserves[0];
    this.bnbPrice = bnbPrice;
    reauUSDPrice = bnbPrice * reauBNBprice;
    loadCBrl();
  }

  double reauUSDprice;
  BigInt totalSupply;
  double dollarPrice;
  double reauBRLPrice;

  Future<void> loadCBrl() async {
    String abi = await rootBundle.loadString('lib/assets/lpAbi.json');
    // Carregará o pancake contract
    final contract = await loadContract(
        "0x3E820DF7D7086DE2D46d908d04c0A24968B32b94", abi, "PancakePair");
    //Receberá o BNBUSD Reserves
    List<dynamic> getCbrlReserves =
        await query(functionName: "getReserves", args: [], contract: contract);
    //Calculará o preço do bnb;
    double cBrlprice =
        (getCbrlReserves[0] / getCbrlReserves[1]) * 1000000000000;
    //Valor do Dolar
    dollarPrice = cBrlprice / bnbPrice;
    // Valor do Reau em Reais
    reauBRLPrice = reauBNBprice * bnbPrice * dollarPrice;
    // Valor do Reau em Dolar
    reauUSDprice = bnbPrice * dollarPrice;
    // Total do Suprimento
    totalSupply = deadBalance - totalFees;
    _make();
  }

  void _make() {
    returnUSDMarketValue();
    returnReauBRLValue();
    returnReauUSDValue();
    returnTotalBRLMarketCap();
    if (ancientWallet != null && ancientWallet != walletValue)
      returnReauWalletValueDifference();
    ancientWallet = walletValue;
    returnBNBMarketValue();
    setCurrency();
    diff();
  }

  double bnbMarketValue;
  double usdMarketValue;
  double reauWalletValueDifference;
  double usdMyWalletValue;
  double brlMyWalletValue;

  //Colocar o valor do reau na carteira!
  void returnReauBRLValue() =>
      brlMyWalletValue = (reauBRLPrice * walletValue.toDouble()) / 1000000000;
  // Calcula o valor do reau na carteira em USD
  void returnReauUSDValue() =>
      usdMyWalletValue = (reauUSDPrice * walletValue.toDouble()) / 1000000000;
  // Calcula o MarketCap do reau em reais
  void returnTotalBRLMarketCap() =>
      totalBRLFeesValue = (reauBRLPrice * totalSupply.toDouble()) / 1000000000;
  // Calcula o MarketCap do reau em BNB
  void returnBNBMarketValue() =>
      bnbMarketValue = (totalSupply.toDouble() / reauBRLPrice) / 1000000000;
  // Calcula o MarketCap do reau em USD
  void returnUSDMarketValue() =>
      usdMarketValue = (reauUSDPrice * totalSupply.toDouble()) / 1000000000;
  // Calcula a diferença do valor da carteira!
  void returnReauWalletValueDifference() => reauWalletValueDifference =
      walletValue.toDouble() - ancientWallet.toDouble();
}
