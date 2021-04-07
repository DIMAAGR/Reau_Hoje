import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ProgramData {
  // Informações sobre o contrato das moedas

  //======================================================================//
  final String reauContract = "0x4c79b8c9cB0BD62B047880603a9DEcf36dE28344";
  final String wBNBContract = "0xbb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c";
  final String cBRLContract = '0x9e691fd624410d631c082202b050694233031cb7';
  //======================================================================//

  // minha carteira para quem quiser fazer alguma doação
  // 0x056982E47890Ff8eeac1d57bb36Ef48Dd0D5A823

  // Olá! Caso Você tenha Vindo dar uma olhada no código, sinta-se a vontade!
  // Você também pode ajudar e melhorar o codigo!

  // Ficará com as Informações da Carteira
  // Caso não haja nenhuma informação sobre a carteira gravada retornará none!
  String _myWallet = MyPreferences.getWallet() ?? "none";

  //Recebe a informação contida em Wallet
  get minhaWallet {
    return _myWallet;
  }

  String url; // Contém as informações da API da carteira

  //Função Futura Obtem o valor contido na carteira ASICRONA
  Future<BscFormat> getWalletValue() async {
    _setUrl(); // Define o Caminho da URL

    // Recebe a Resposta da URL
    final response = await http.get(url);

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
            MyPreferences.getWallet() +
            "&contractaddress=" +
            reauContract;
  }
} //Fim da Clase

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
} // Fim da Classe!

class MyPreferences {
  static SharedPreferences _preferences;

  // KEYS dos ITEMS == IMUTAVEL
  // Mostra o caminho da informação da Chave!
  static const _keyWallet = 'MyWallet';
  static const _keyUserName = 'UserName';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  //Salvar a Carteira de Reaus
  static Future setWallet(String wallet) async =>
      await _preferences.setString(_keyWallet, wallet);

  //Obtem a informação da Carteira de Reaus
  static String getWallet() => _preferences.getString(_keyWallet);

  //================================================================//

  //Salva o nome de Usuário
  static Future setUserName(String userName) async =>
      await _preferences.setString(_keyUserName, userName);

  //Obtem a informação da Carteira de Reaus
  static String getUserName() => _preferences.getString(_keyUserName);
}
