import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ProgramData {
  // Informações sobre o contrato das moedas

  final String reauContract = "0x4c79b8c9cB0BD62B047880603a9DEcf36dE28344";
  final String wBNBContract = "0xbb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c";
  final String cBRLContract = '0x9e691fd624410d631c082202b050694233031cb7';

  final bool basicsInformations = false;
  final bool hasSettedWallet = false;
  final bool hasWalletValue = false;

  // minha carteira para quem quiser fazer alguma doação
  // 0x056982E47890Ff8eeac1d57bb36Ef48Dd0D5A823

  // Ficará com as Informações da Carteira
  String _myWallet = "0x056982E47890Ff8eeac1d57bb36Ef48Dd0D5A823"; //"none";

  // Altera o codigo da Carteira
  Future<bool> changeMyWallet(String carteira) async {
    // O SharedPreferences obtem as informações contidas nele e o seu caminho
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print(_myName);
    print(_myWallet);
    return prefs.setString('_myWallet', carteira);
  }

  Future<String> getMyWallet() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _myWallet = prefs.getString('_myWallet') ?? 'none';
    return prefs.getString('_myWallet') ?? 'none';
  }

  //Recebe a informação contida em Wallet
  get minhaWallet {
    return _myWallet;
  }

  // Seu Nome

  String _myName = "None";

  // Esta Função Muda o seu nome apresentado no App
  Future<bool> changeMyName(String name) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('_myName', name);
  }

  //retorna seu nome
  Future<String> getMyName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _myName = prefs.getString('_myName') ?? 'none';
    return prefs.getString('_myName') ?? 'none';
  }

  String url; // Contém as informações da API da carteira

  //Função Futura Obtem o valor contido na carteira ASICRONA
  Future<BscFormat> getWalletValue() async {
    _setUrl(); // Define o Caminho da URL
    final response = await http.get(url); // Recebe a Resposta da URL

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return BscFormat.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load bsc informations');
    }
  }

  //define como será a URL da API
  String _setUrl() {
    return url =
        "https://api.bscscan.com/api?module=account&action=tokenbalance&tag=latest&apikey=xxx" +
            "&address=" +
            _myWallet +
            "&contractaddress=" +
            reauContract;
  }
}

// Classe formatadora de informações
class BscFormat {
  final String status;
  final String message;
  final String result;

  BscFormat({
    this.status,
    this.message,
    this.result,
  });

  // Faz a formatação de Dados JSON para Map
  factory BscFormat.fromJson(Map<String, Object> json) {
    return BscFormat(
      status: json['status'].toString(),
      message: json['message'],
      result: json['result'].toString(),
    );
  }
}
