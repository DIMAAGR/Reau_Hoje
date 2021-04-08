import 'package:flutter/material.dart';
import 'package:reau_hoje/data/data.dart';
import 'package:reau_hoje/routers/application_routers.dart';
import 'package:reau_hoje/views/mainScreen.dart';

class Starting extends StatefulWidget {
  @override
  _StartingState createState() => _StartingState();
}

class _StartingState extends State<Starting> {
  // O Projeto é Iniciado nessa tela Starting.
  // A Partir daqui será carregado as ultimas informações pré definidas
  // ou caso não haja, será enviado para a tela de Cadastro Primario.

  Future<BscFormat> walletvalue;
  bool yep = false;

  _loadmainscreen(BuildContext ctx) {
    if (yep == true)
      setState(() {
        Navigator.of(ctx).pushNamed(AppRoutes.MAINSCREEN);
      });
    return SizedBox(
      width: 0,
      height: 0,
    );
  }

  // if (snapshot.data.result != 'null') yep = true;
  //         print("result: " + snapshot.data.result);
  //         print("YEP: " + yep.toString());

  _carregar() {
    // return SizedBox();
    return FutureBuilder<BscFormat>(
      future: ProgramData().getWalletValue(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.result != 'null') yep = true;
          print("result: " + snapshot.data.result);
          print("YEP: " + yep.toString());
          return SizedBox();
        } else {
          yep = false;
          print("Whoa!");
          print(snapshot.error);
          return SizedBox(
            width: 0,
            height: 0,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print(ProgramData().minhaWallet);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 2, 204, 204),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _reauHojeLogo(),
          _barraCarregando(),
          Container(
            child: _carregar(),
          ),
        ],
      ),
    );
  }
}

_reauHojeLogo() {
  print(ProgramData().minhaWallet);
  return Expanded(
    flex: 2,
    child: Center(
      child: Text(
        "Reau Hoje",
        style: TextStyle(
            color: Color.fromARGB(255, 246, 246, 246),
            fontSize: 35,
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic),
      ),
    ),
  );
}

_barraCarregando() {
  return Container(
    color: Color.fromARGB(255, 40, 40, 40),
    height: 35, // Altura
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Texto Carregando, Aguarde...
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            "Carregando aguarde...",
            // Prorpiedades do texto
            style: TextStyle(
                color: Color.fromARGB(255, 246, 246, 246),
                fontFamily: "Roboto",
                fontWeight: FontWeight.w400),
          ),
        ),
        Expanded(child: Container()),

        // Barra de Carregamento Circular
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              valueColor: new AlwaysStoppedAnimation<Color>(
                  Color.fromARGB(255, 246, 246, 246)),
            ),
          ),
        ),
      ],
    ),
  );
}
