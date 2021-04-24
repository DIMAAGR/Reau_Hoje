import 'package:flutter/material.dart';
import 'package:reau_hoje/data/connections/reauconnection.dart';
import 'package:reau_hoje/routers/application_routers.dart';
import 'package:reau_hoje/views/main_screen/components/app_btn.dart';

class ScreenButtons extends StatelessWidget {
  final ReauConnection rc;
  const ScreenButtons({
    this.rc,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.only(
                    top: 8, bottom: 16, left: 16, right: 8),
                child: AppBtn(
                  active: true,
                  text: "Minha\nCarteira",
                  function: () {},
                  icon: Icon(
                    Icons.account_balance_wallet,
                    size: 35,
                    color: Colors.black54,
                  ),
                )),
            Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 16, right: 8),
                child: AppBtn(
                  active: true,
                  text: "Calculadora",
                  function: () {
                    Navigator.of(context).pushNamed(AppRoutes.CALCULATOR);
                  },
                  icon: Icon(
                    Icons.calculate,
                    size: 35,
                    color: Colors.black54,
                  ),
                )),
            Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 16, right: 8),
                child: AppBtn(
                  icon: Icon(
                    Icons.settings,
                    size: 35,
                    color: Colors.black54,
                  ),
                  function: () {},
                  active: true,
                  text: "Configurações",
                )),
            Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 16, right: 8),
                child: AppBtn(
                  text: "Analises",
                  function: () {},
                  icon: Icon(
                    Icons.bar_chart,
                    size: 35,
                    color: Colors.white,
                  ),
                  active: false,
                )),
            Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 16, right: 8),
                child: AppBtn(
                  text: "Transferir",
                  function: () {},
                  icon: Icon(
                    Icons.send,
                    size: 35,
                    color: Colors.white,
                  ),
                  active: false,
                )),
          ],
        ),
      ),
    );
  }
}
