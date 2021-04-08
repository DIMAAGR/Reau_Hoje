import 'package:flutter/material.dart';
import 'package:reau_hoje/data/data.dart';

class MainScreen extends StatelessWidget {
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
                      child: Text(
                        "R\$ 46,35",
                        style: TextStyle(
                            fontSize: 55,
                            color: Color.fromARGB(255, 248, 248, 248),
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                  Text(
                    MyPreferences.getWallet(),
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
}
