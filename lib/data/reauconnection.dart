import 'dart:async';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:reau_hoje/data/data.dart';
import 'package:web3dart/contracts.dart';
import 'package:web3dart/web3dart.dart';

class ReauConnection {
  var url = "https://bsc-dataseed1.binance.org:443";

  var httpClient = new Client();

  Function setmyState;

  Web3Client web3;

  String appUser = "Italo Matos";
  final myAdress = "0xf43415f2dbca4853664abbdc0e9a7ce3d2010d36";

  ReauConnection(this.setmyState) {
    web3 = Web3Client(url, httpClient);
  }

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
  bool updown;
  BigInt ancientWallet;

  //DATA STATUS
  double ancientWalletValue;
  double difference = 0;
  double ancientdifference = 0;

  // ignore: unused_field
  Timer _timer;

  //Strings Usadas no DIFF para mostrar a diferença no valor recebido
  String diffstring;
  String diffBalanceString;
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
      if (difference > ancientdifference)
        updown = true;
      else
        updown = false;

      ancientdifference = difference;
      diffstring = difference.toStringAsFixed(2) + "%";
      hello();
      // setmyState();
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

  double reauUSDprice;
  double reauBNBMarketPrice;

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
    reauUSDprice = bnbPrice * dollarPrice;
    reauBNBMarketPrice = reauBRLPrice / reauUSDprice;
    totalSupply = deadBalance - totalFees;

    returnUSDMarketValue();
    returnReauBRLValue();
    returnTotalBRLMarketCap();
    if (ancientWallet != null && ancientWallet != walletValue)
      returnReauWalletValueDifference();
    ancientWallet = walletValue;
    returnBNBMarketValue();
    // print(reauBNBMarketPrice);
    // print(bnbPrice);
    // print("dolar > dolarPrice: " + dollarPrice.toString());
    // print("dolar > usdprice: " + reauUSD.toString());
    // print("BRL PRICE " + reauBRLPrice.toString());
    //print("USD PRICE " + reauUSDprice.toString());
    //print("Wallet USD VALUE: " + usdMarketValue.toString());
    //  print("Wallet BRL VALUE: " + brlWalletValue.toString());
    //brlWalletValue += 5555445;
    diff();

    //  setmyState();
  }

  double bnbMarketValue;
  double usdMarketValue;
  double reauWalletValueDifference;

  //Colocar o valor do reau na carteira!
  void returnReauBRLValue() =>
      brlWalletValue = (reauBRLPrice * walletValue.toDouble()) / 1000000000;
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
