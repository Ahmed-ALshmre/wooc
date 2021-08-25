import 'package:flutter/material.dart';

class ProviderClass extends ChangeNotifier {
  int _counter = 1;
  int get counter => _counter;

  void cartNumber(int number) {
    _counter = number;
    notifyListeners();
  }


}
