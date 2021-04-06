import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Starting(),
    );
  }
}

// O Projeto é Iniciado nessa tela Starting.
// A Partir daqui será carregado as ultimas informações pré definidas
// ou caso não haja, será enviado para a tela de Cadastro Primario.

class Starting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _barraCarregando(),
        ],
      ),
    );
  }
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
            "Carregando, Aguarde...",
            // Prorpiedades do texto
            style: TextStyle(
                color: Color.fromARGB(255, 246, 246, 246),
                fontFamily: "Roboto",
                fontWeight: FontWeight.w100),
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
