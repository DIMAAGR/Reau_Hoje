import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class ProgramData {
  // Informações sobre o contrato das moedas

  final String reauContract = "0x4c79b8c9cB0BD62B047880603a9DEcf36dE28344";
  final String wBNBContract = "0xbb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c";
  final String cBRLContract = '0x9e691fd624410d631c082202b050694233031cb7';

  String _myWallet =
      "0x056982E47890Ff8eeac1d57bb36Ef48Dd0D5A823"; // Ficará com as Informações da Carteira
  String url; // Contém as informações da API da carteira

  Future<BscFormat> getWalletValue() async {
    _setUrl();
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

  String _setUrl() {
    return url =
        "https://api.bscscan.com/api?module=account&action=tokenbalance&tag=latest&apikey=xxx" +
            "&address=" +
            _myWallet +
            "&contractaddress=" +
            reauContract;
  }
}

void alterarMinhaCarteira(String carteira) {}

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
