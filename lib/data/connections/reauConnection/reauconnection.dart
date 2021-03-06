import 'dart:async';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:reau_hoje/data/connections/reauConnection/conversor/moneyConversion.dart';
import 'package:reau_hoje/data/data.dart';
import 'package:web3dart/contracts.dart';
import 'package:web3dart/web3dart.dart';

class ReauConnection {
  /// REAU ENGINE: [REAU ENGINE 0.10.0(Beta)]

  Web3Client web3;
  var url = "https://bsc-dataseed1.binance.org:443";
  var httpClient = new Client();
  String appUser = MyPreferences.getUserName();
  var myAdress = MyPreferences.getWallet();
  // 0x46da24dbb9a19dafaf620a363396cecf20c95fed

  // Variaveis de Controle
  bool _verifyReauPrice = false;
  bool _enableConversor = false;

  // Inicia os modulos e verifica as informações
  ReauConnection({bool enableConversor, bool verifyReauPrice}) {
    _verifyReauPrice = verifyReauPrice;
    _enableConversor = enableConversor;
  }

  //Definições Obtidas a partir do contrato do reau
  var deadBalance;
  var totalFees;

  double walletValue;
  double reauBNBprice;
  double reauUSDPrice;

  double bnbPrice;
  bool data;
  bool updown;
  double ancientWallet;

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

  void disableEvents({String eventType, bool setFunc}) {
    switch (eventType) {
      case "verifyReauPrice":
        if (setFunc)
          _verifyReauPrice = true;
        else
          _verifyReauPrice = false;
        break;
      case "enableConversor":
        if (setFunc)
          _enableConversor = true;
        else
          _enableConversor = false;
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
    if (_ancientBalanceValue != null) if (_ancientBalanceValue !=
        currentWalletValue) {
      double d =
          ((currentWalletValue - _ancientBalanceValue) / _ancientBalanceValue) *
              100; //d = Diferença
      difference = d;

      if (difference.isNegative) difference *= -1;
    }

    if (difference == -0.0) difference = 0.0;

    if (difference < -0.0001 || difference > 0.0001) {
      if (_ancientBalanceValue < currentWalletValue) {
        updown = true;
      } else {
        updown = false;
      }
      ancientdifference = difference;
      diffstring = difference.toStringAsFixed(2) + "%";

      // setmyState();
    }
    if (currentWalletValue != null) {
      setAncientBalanceValue(currentWalletValue);
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
  // ignore: missing_return
  Future<List<dynamic>> query(
      {String functionName,
      List<dynamic> args,
      DeployedContract contract}) async {
    var y = await web3.call(
        contract: contract,
        function: _ethFunction(functionName, contract),
        params: args);
    return y;
  }

//Cria o contrato que sera utilizado para verificar os valores da moeda
  _ethFunction(String functionName, DeployedContract contract) =>
      contract.function(functionName);

//==============================================================================================//
  // RECEBE O VALOR NUMERICO(A QUANTIDADE) de REAUS QUE VOCÊ TEM EM SUA CARTEIRA
  Future<void> startReauOptions() async {
    //Obtem as infos do Usuário
    appUser = MyPreferences.getUserName();
    myAdress = MyPreferences.getWallet();
    web3 = Web3Client(url, httpClient);
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
    BigInt _wbr = walletBalanceResult[0];
    walletValue = _wbr.toDouble();
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
    // Valor do Reau em Dolar
    reauUSDprice = bnbPrice * dollarPrice;
    // Valor do Reau em Reais
    reauBRLPrice = reauBNBprice * reauUSDprice;
    // Total do Suprimento
    totalSupply = deadBalance - totalFees;
    _make();
  }

  double actualCurrencyValue;
  // Faz as operações de acordo com o necessário impedindo de fazer coisas desnecessárias
  void _make() {
    // Caso seja Necessário verificar o Preço do reau!
    if (_verifyReauPrice) {
      print("verificando informações sobre a wallet...");

      returnUSDMarketValue();

      if (_currentType != "USD") {
        returnReauWalletValueFromDefinedCurrency();
        returnReauMarketCapValueFromDefinedCurrency();
        diff();
      } else {
        currentWalletValue = returnReauUSDValue();
        marketcap = usdMarketValue;
        diff();
      }
      if (ancientWallet != null && ancientWallet != walletValue)
        returnReauWalletValueDifference();
      ancientWallet = walletValue.toDouble();
      returnBNBMarketValue();
    }

    // Caso seja necessário habilitar o conversor
    if (_enableConversor) {
      print("Conversor iniciado.... ");
      returnBRLtoReauValue();
      returnImutableBRLtoReauValue();
    }
  }

  // ignore: unused_field
  double _bnbMarketValue;
  MoneyConversor _mc = MoneyConversor();
  double usdMarketValue;
  double reauWalletValueDifference;
  double marketcap;
  double brlMyWalletValue;
  double _brlToReauValue = 1;
  double _ancientBalanceValue;
  final double _imutableVLRtBRLValue = 1;
  double _imutablebrlToReauConvertedValue;

  double _brlToReauConvertedValue;

  //Colocar o valor do reau na carteira!
  void returnReauWalletValueFromDefinedCurrency() async => currentWalletValue =
      (await _mc.make(_currentType) * returnReauUSDValue());

  void returnReauMarketCapValueFromDefinedCurrency() async =>
      marketcap = (usdMarketValue * await _mc.make(_currentType));

  // Calcula o valor do reau na carteira em USD
  double returnReauUSDValue() =>
      (reauUSDPrice * walletValue.toDouble()) / 1000000000;

  // Calcula o MarketCap do reau em BNB
  void returnBNBMarketValue() =>
      _bnbMarketValue = (totalSupply.toDouble() / reauBRLPrice) / 1000000000;

  // Calcula o MarketCap do reau em USD
  void returnUSDMarketValue() =>
      usdMarketValue = (reauUSDPrice * totalSupply.toDouble()) / 1000000000;

  // Calcula a diferença do valor da carteira!
  void returnReauWalletValueDifference() => reauWalletValueDifference =
      walletValue.toDouble() - ancientWallet.toDouble();

  // Converte um Valor X em real para Reau
  void returnBRLtoReauValue() =>
      _brlToReauConvertedValue = (_brlToReauValue / reauBRLPrice);

  //Define o valor que será convertido!
  void setbrlToReauValue(double x) => _brlToReauValue = x;

  //Obtem o valor convertido para Reau!
  String getbrlToReauValue() => _brlToReauConvertedValue == null
      ? "none"
      : _brlToReauConvertedValue.toStringAsFixed(2);

  // FAZ OS CALCULOS DOS VALORES DE 1 REAL @immutable
  void returnImutableBRLtoReauValue() =>
      _imutablebrlToReauConvertedValue = (_imutableVLRtBRLValue / reauBRLPrice);

  String getImutablebrlToReauValue() => _imutablebrlToReauConvertedValue == null
      ? "none"
      : _imutablebrlToReauConvertedValue.toStringAsFixed(0);

  //Define o Valor antigo do AncientBalanceValue
  void setAncientBalanceValue(double y) => _ancientBalanceValue = y;
  double getAncientBalanceValue() => _ancientBalanceValue;

  void verifyNameandWallet() {
    if (appUser == null ||
        myAdress == null ||
        myAdress.isEmpty ||
        myAdress == "") {
      appUser = MyPreferences.getUserName();
      myAdress = MyPreferences.getWallet();
    }
  }
}
