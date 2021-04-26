import 'dart:convert';

import 'package:reau_hoje/data/connections/reauConnection/conversor/urlconversion.dart';
import 'package:http/http.dart' as http;

/// Essa classe [MoneyConversor] Tem o papel de converter a moeda dolar para outras moedas internais
/// com a finalidade de converter os valores apresentados na tela inicial do aplicativo.
class MoneyConversor {
  /// [selectCurrency] recebe uma string [currency], ele tem o papel de definir qual será a moeda
  /// que será convertida.
  String selectCurrency(String currency) {
    switch (currency) {
      case "AUD":
        return UrlConversion.USD_AUD;
        break;
      case "GBP":
        return UrlConversion.USD_GBP;
        break;
      case "CAD":
        return UrlConversion.USD_CAD;
        break;
      case "EUR":
        return UrlConversion.USD_EUR;
        break;
      case "ARS":
        return UrlConversion.USD_ARS;
        break;
      case "BRL":
        return UrlConversion.USD_BRL;
        break;
      case "JPY":
        return UrlConversion.USD_JPY;
        break;
      case "CNY":
        return UrlConversion.USD_CNY;
        break;
      default:
        return "";
        break;
    }
  }

  /// Esta classe recebe as informações do servidor partindo de um json
  Future<Conversion> getJSONDataForConversion(String currency) async {
    final response = await http.get(Uri.encodeFull(selectCurrency(currency)));
    if (response.statusCode == 200) {
      // se o servidor retornar um response OK, vamos fazer o parse no JSON

      return Conversion.fromJson(json.decode(response.body));
    } else {
      // se a responsta não for OK , lançamos um erro
      throw Exception('Failed to load post');
    }
  }

  Future<double> make(String currency) async {
    Conversion cv = await getJSONDataForConversion(currency);
    return double.parse(cv.uSD.ask);
  }
}

class Conversion {
  USD uSD;

  Conversion({this.uSD});

  Conversion.fromJson(Map<String, dynamic> json) {
    uSD = json['USD'] != null ? new USD.fromJson(json['USD']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.uSD != null) {
      data['USD'] = this.uSD.toJson();
    }
    return data;
  }
}

class USD {
  String code;
  String codein;
  String name;
  String high;
  String low;
  String varBid;
  String pctChange;
  String bid;
  String ask;
  String timestamp;
  String createDate;

  USD(
      {this.code,
      this.codein,
      this.name,
      this.high,
      this.low,
      this.varBid,
      this.pctChange,
      this.bid,
      this.ask,
      this.timestamp,
      this.createDate});

  USD.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    codein = json['codein'];
    name = json['name'];
    high = json['high'];
    low = json['low'];
    varBid = json['varBid'];
    pctChange = json['pctChange'];
    bid = json['bid'];
    ask = json['ask'];
    timestamp = json['timestamp'];
    createDate = json['create_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['codein'] = this.codein;
    data['name'] = this.name;
    data['high'] = this.high;
    data['low'] = this.low;
    data['varBid'] = this.varBid;
    data['pctChange'] = this.pctChange;
    data['bid'] = this.bid;
    data['ask'] = this.ask;
    data['timestamp'] = this.timestamp;
    data['create_date'] = this.createDate;
    return data;
  }
}
