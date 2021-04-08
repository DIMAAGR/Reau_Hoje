import 'package:flutter/material.dart';
import 'package:reau_hoje/data/data.dart';
import 'package:reau_hoje/routers/application_routers.dart';

class FirstTake extends StatefulWidget {
  @override
  //final ProgramData program = ProgramData();
  _FirstTakeState createState() => _FirstTakeState();
}

class _FirstTakeState extends State<FirstTake> {
  bool hasNamed = false;

  //Nome do Usuário
  String myname = "";

  //Informações do usuário
  String username = '';
  String myWallet = '';

  @override
  Widget build(BuildContext context) {
    return hasNamed == false
        ? Scaffold(
            body: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 128.0, left: 16),
                        child: Text(
                          "Olá! Ainda não nos Conhecemos!",
                          style: TextStyle(
                              color: Color.fromARGB(255, 40, 40, 40),
                              fontSize: 30,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w800,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(
                          "Qual é o seu nome?",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Color.fromARGB(255, 40, 40, 40),
                              fontSize: 18,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                      _nameTextBox(),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24, right: 24),
                      child: _continueButton(),
                    ),
                  ],
                ),
              ],
            ),
          )
        : Scaffold(
            body: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 128.0, left: 16),
                        child: Text(
                          myname + " eu ainda não sei sua carteira!",
                          style: TextStyle(
                              color: Color.fromARGB(255, 40, 40, 40),
                              fontSize: 30,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w800,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(
                          "Por favor insira sua carteira!",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Color.fromARGB(255, 40, 40, 40),
                              fontSize: 18,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                      _walletTextBox(),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24, right: 24),
                      child: _continueButton(),
                    ),
                  ],
                ),
              ],
            ),
          );
  }

  _continueButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(225, 238, 238, 238),
          borderRadius: BorderRadius.circular(60),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(60),
          onTap: () async {
            if (hasNamed == false) {
              MyPreferences.setUserName(username);
              myname = MyPreferences.getUserName();
              setState(() {
                hasNamed = true;
              });
            } else {
              MyPreferences.setWallet(myWallet);
              Navigator.of(context).pushNamed(AppRoutes.MYWALLET);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0), // Tamanho do Circulo
            child: Icon(
              Icons.arrow_forward_ios,
              size: 23,
              color: Color.fromARGB(255, 114, 114, 114),
            ),
          ),
        ),
      ),
    );
  }

  //TextBox
  _nameTextBox() {
    return new Padding(
      padding: const EdgeInsets.only(left: 16, top: 24),
      child: Container(
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 240, 240, 240),
            borderRadius: BorderRadius.circular(20)),
        height: 40,
        width: MediaQuery.of(context).size.width * 0.860,
        child: new TextFormField(
          initialValue: "",
          decoration: InputDecoration(
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            //fillColor: Colors.green
          ),
          onChanged: ((mySubmit) async {
            username = mySubmit;
          }),
        ),
      ),
    );
  }

  _walletTextBox() {
    return new Padding(
      padding: const EdgeInsets.only(left: 16, top: 24),
      child: Container(
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 240, 240, 240),
            borderRadius: BorderRadius.circular(20)),
        height: 40,
        width: MediaQuery.of(context).size.width * 0.860,
        child: new TextFormField(
          initialValue: "",
          decoration: InputDecoration(
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            //fillColor: Colors.green
          ),
          onChanged: ((mySubmit) async {
            myWallet = mySubmit;
            print(myWallet);
          }),
        ),
      ),
    );
  }
} 

// Uma Carteira tem 47 Digitos