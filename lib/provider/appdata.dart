import 'package:flutter/material.dart';

class MyModel extends ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  void incrementCounter() {
    _counter++;
    notifyListeners(); // Notifies the UI about the change
  }
}
