import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reau_hoje/data/connections/reauConnection/reauconnection.dart';
import 'package:reau_hoje/data/data.dart';
import 'package:reau_hoje/providers/reau_provider.dart';
import 'package:reau_hoje/routers/application_routers.dart';
import 'package:reau_hoje/views/Calculator/calculator_screen.dart';
import 'package:reau_hoje/views/hello.dart';
import 'package:reau_hoje/views/home.dart';
import 'package:reau_hoje/views/main_screen/body/main_screen.dart';
import 'package:reau_hoje/views/myWallet.dart';
import 'package:reau_hoje/views/settings_sceen/body/options_screens/select_language_view.dart';
import 'package:reau_hoje/views/settings_sceen/body/options_screens/select_currency_view.dart';
import 'package:reau_hoje/views/settings_sceen/body/settings_view.dart';
import 'package:reau_hoje/views/starting.dart';

ReauConnection rc;
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
    debugPrint("Starting Reau Connection... await...");
    rc = ReauConnection(enableConversor: false, verifyReauPrice: true);
    rc.defCurrentType("BRL");
    rc.startReauOptions();
    //  SharedPreferences.setMockInitialValues({});
    return MultiProvider(
      providers: [
        Provider<ReauProvider>(
          create: (_) => ReauProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Reau Hoje',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),

        // home: MyPreferences.getWallet().isEmpty ? FirstTake() : Starting(),
        routes: {
          AppRoutes.HOME: (ctx) => Home(rc: rc),
          AppRoutes.STARTING: (ctx) => Starting(),
          AppRoutes.HELLO: (ctx) => FirstTake(),
          AppRoutes.MYWALLET: (ctx) => MyWallet(),
          AppRoutes.MAINSCREEN: (ctx) => MainScreen(rc: rc),
          AppRoutes.CALCULATOR: (ctx) => Calculator(),
          AppRoutes.SETTINGS: (ctx) => SettingsScreen(),
          AppRoutes.SELECT_LANGUAGE_SETTINGS: (ctx) => SelectLanguageView(),
          AppRoutes.SELECT_CURRENCY_SETTINGS: (ctx) =>
              SelectCurrencyView(rc: rc),
        },
      ),
    );
  }
}
