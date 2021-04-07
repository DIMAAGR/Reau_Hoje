import 'package:flutter/material.dart';
import 'package:reau_hoje/data/data.dart';
import 'package:reau_hoje/views/hello.dart';
import 'package:reau_hoje/views/starting.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProgramData().minhaWallet == "none" ? FirstTake() : Starting();
  }
}
