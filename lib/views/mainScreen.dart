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
  final myAdress = MyPreferences.getWallet();
  int amount = 0;
  var myData;
  bool data;

  @override
  void initState() {
    web3 = Web3Client(url, httpClient);
    debugPrint(myAdress);
    getbalance(MyPreferences.getWallet());
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
                      child: myData != null
                          ? Text(
                              myData.toString(),
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
  Future<DeployedContract> loadReauContract() async {
    String abi =
        await rootBundle.loadString('lib/assets/abi.json'); //recebe o JSON ABI
    String contractAdress =
        '0x4c79b8c9cB0BD62B047880603a9DEcf36dE28344'; //gera o contrato a partir do reauContract

    final contract = DeployedContract(
        ContractAbi.fromJson(abi, 'ViraLataFinance'),
        EthereumAddress.fromHex(contractAdress));
    return contract;
  }

//==============================================================================================//
  // Tem a função de transferir os argumentos carregar o contrato
  // e receber a informação desejada do servidor
  Future<List<dynamic>> reauQuery(
      String functionName, List<dynamic> args) async {
    final contract = await loadReauContract();
    final ethFunction = contract.function(functionName);
    final result = await web3.call(
        contract: contract, function: ethFunction, params: args);
    print(result);
    return result;
  }

//==============================================================================================//
  // RECEBE O VALOR NUMERICO(A QUANTIDADE) de REAUS QUE VOCÊ TEM EM SUA CARTEIRA
  Future<void> getbalance(String wallet) async {
    // Esta Função faz a conversão da carteira para HEX
    //  EthereumAddress address = EthereumAddress.fromHex(wallet);

    //Mostra o Balanço que há em sua carteira!
    List<dynamic> result =
        await reauQuery("balanceOf", [EthereumAddress.fromHex(myAdress)]);
    myData = result[0];
    data = true;
    setState(() {});
  }
//==============================================================================================//

}
