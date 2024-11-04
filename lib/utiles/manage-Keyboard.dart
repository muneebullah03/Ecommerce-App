import 'package:flutter/material.dart';

class Managekeyboard {
  static void hideKeyBoard(BuildContext context) {
    FocusScopeNode currentFucos = FocusScope.of(context);
    if (!currentFucos.hasPrimaryFocus) {
      currentFucos.unfocus();
    }
  }
}
