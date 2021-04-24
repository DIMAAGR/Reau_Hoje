import 'dart:async';
import 'package:flutter/material.dart';
import 'package:reau_hoje/data/data.dart';
import 'package:reau_hoje/routers/application_routers.dart';
import 'package:reau_hoje/views/Calculator/calculator_screen.dart';
import 'package:reau_hoje/views/hello.dart';
import 'package:reau_hoje/views/main_screen/body/main_screen.dart';
import 'package:reau_hoje/views/myWallet.dart';
import 'package:reau_hoje/views/starting.dart';

Future main() async {
  // O Hello Application indica que o aplicativo foi iniciado!
  debugPrint("Hello Aplication!!!");

  //Garante a inicialização Obrigatoria dos Widgets
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa as preferências Personalizadas carregando-as
  await MyPreferences.init();

  // Inicia o Aplicativo!
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //  SharedPreferences.setMockInitialValues({});
    return MaterialApp(
      title: 'Reau Hoje',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      // home: MyPreferences.getWallet().isEmpty ? FirstTake() : Starting(),
      routes: {
        AppRoutes.HOME: (ctx) => MainScreen(),
        AppRoutes.STARTING: (ctx) => Starting(),
        AppRoutes.HELLO: (ctx) => FirstTake(),
        AppRoutes.MYWALLET: (ctx) => MyWallet(),
        AppRoutes.MAINSCREEN: (ctx) => MainScreen(),
        AppRoutes.CALCULATOR: (ctx) => Calculator(),
      },
    );
  }
}
