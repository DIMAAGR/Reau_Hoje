import 'package:flutter/material.dart';

/// O Widget Difference mostra a diferença/ Variação na cotação do REAU
/// Mais Especificadamente dos seus REAUS.
/// Ele recebe 3 variaveis [Difference] que mostra a diferença atual, e o
/// [diffstring] que mostra o texto que será apresentado no modulo de diferença.
/// São Dois tipos de Differença que serão definidos pelo booleano [updown]
/// ele verificará se o valor subio ou desceu e definirá o tipo de widget que será gerado
/// caso tudo dê errado ele gerará um widget com o nome error!

class Difference extends StatefulWidget {
  /// a variavel [difference] recebe a diferença entre a ultima e a atual cotação
  final double difference;

  /// a variável [diffstring] recebe o texto a ser apresentado
  final String diffstring;

  /// a variável [updown] mostra se houve um aumento ou uma perca do valor
  final bool updown;

  Difference({this.updown, this.difference, this.diffstring});

  @override
  _DifferenceState createState() => _DifferenceState();
}

class _DifferenceState extends State<Difference> {
  @override
  Widget build(BuildContext context) {
    //cria uma variavel intermediaria ao differenceString
    String diff;

    ///Verifica se a variavel [diffstring] foi recebida (não recebeu NULL)
    /// Caso o valor seja diferente de nulo ele definirá a variavel intermediaria com o [diffstring]
    /// caso o valor seja nulo ele definirá a variavel como 0.00%
    if (widget.diffstring == null) {
      diff = "0.00%";
    } else {
      diff = widget.diffstring;
    }
    if (widget.updown)
      return Padding(
        padding: const EdgeInsets.only(right: 16.0, top: 12.0),
        child: Container(
          height: 28,
          width: 64 + diff.length.toDouble() * 2.5,
          decoration: BoxDecoration(
              color: Colors.greenAccent[700],
              borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: Row(
              children: [
                Icon(
                  Icons.keyboard_arrow_up,
                  color: Colors.white,
                ),
                Text(
                  diff,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
        ),
      );
    else if (!widget.updown)
      return Padding(
        padding: const EdgeInsets.only(right: 16.0, top: 12.0),
        child: Container(
          height: 28,
          width: 64 + diff.length.toDouble() * 2.3,
          decoration: BoxDecoration(
              color: Colors.redAccent[700],
              borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: Row(
              children: [
                Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white,
                ),
                Text(
                  diff,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
        ),
      );
    else {
      return Padding(
        padding: const EdgeInsets.only(right: 16.0, top: 12.0),
        child: Container(
          height: 28,
          width: 64 + diff.length.toDouble() * 2.3,
          decoration: BoxDecoration(
              color: Colors.redAccent[700],
              borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: Row(
              children: [
                Text(
                  "error",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
