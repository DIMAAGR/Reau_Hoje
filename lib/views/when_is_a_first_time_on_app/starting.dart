import 'package:flutter/material.dart';

class Starting extends StatefulWidget {
  @override
  _StartingState createState() => _StartingState();
}

class _StartingState extends State<Starting> {
  // O Projeto é Iniciado nessa tela Starting.
  // A Partir daqui será carregado as ultimas informações pré definidas
  // ou caso não haja, será enviado para a tela de Cadastro Primario.

  bool yep = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 2, 204, 204),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _reauHojeLogo(),
          _barraCarregando(),
          Container(),
        ],
      ),
    );
  }
}

_reauHojeLogo() {
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
