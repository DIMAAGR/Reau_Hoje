import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class ProgramData {
  // Informações sobre o contrato das moedas

  //======================================================================//
  final String reauContract = "0x4c79b8c9cB0BD62B047880603a9DEcf36dE28344";
  final String wBNBContract = "0xbb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c";
  final String cBRLContract = '0x9e691fd624410d631c082202b050694233031cb7';
  final String panCakeContract = '0x7Cc956136C36e7Fbd6B74C07d9E40Eccd3779249';
  //======================================================================//

  // minha carteira para quem quiser fazer alguma doação
  // 0x056982E47890Ff8eeac1d57bb36Ef48Dd0D5A823

  // Olá! Caso Você tenha Vindo dar uma olhada no código, sinta-se a vontade!
  // Você também pode ajudar e melhorar o codigo!

} // Fim da Classe!

class MyPreferences {
  static SharedPreferences _preferences;

  // KEYS dos ITEMS == IMUTAVEL
  // Mostra o caminho da informação da Chave!
  static const _keyWallet = 'MyWallet';
  static const _keyUserName = 'UserName';
  static const _keyCurrentType = "CurrentType";

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

  static Future setCurrentType(String currentType) async =>
      await _preferences.setString(_keyCurrentType, currentType);

  static String getCurrentType() => _preferences.getString(_keyCurrentType);
}
