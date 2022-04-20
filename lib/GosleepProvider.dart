import 'package:flutter/material.dart';

class GosleepProvider with ChangeNotifier{
  int _mBleState = 0;
  int get state => _mBleState;

  void changeState(int _state){
    _mBleState = _state;
    notifyListeners();          // 구독하는 모든 대상에 알림.
  }
}