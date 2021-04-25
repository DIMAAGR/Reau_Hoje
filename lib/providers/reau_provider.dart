import 'package:flutter/cupertino.dart';
import 'package:reau_hoje/data/connections/reauConnection/reauconnection.dart';

class ReauProvider with ChangeNotifier {
  ReauConnection rc;

  setReauConnection(ReauConnection reauc) => rc = reauc;

  enableWalletOpt() {
    rc.disableEvents(eventType: "verifyReauPrice", setFunc: true);
    notifyListeners();
  }
}
