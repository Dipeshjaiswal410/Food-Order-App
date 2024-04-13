import 'package:flutter/material.dart';

class TimerProvider extends ChangeNotifier {
  int _splashScreenTime = 2;
  int get splashScreenTime => _splashScreenTime;

  updateTime() {
    _splashScreenTime--;
    notifyListeners();
  }
}
