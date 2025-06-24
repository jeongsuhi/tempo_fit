import 'package:flutter/material.dart';
import 'package:tempo_fit/typeAdapter/timer_set.dart';

class TimerProvider extends ChangeNotifier {

  // 現在扱っているタイマー
  TimerSet _current = TimerSet();
  TimerSet get current => _current;

  // 次を選ぶからタイマーを変えたか
  bool _isNewTimerReady = false;
  bool get isNewTimerReady => _isNewTimerReady;

  void selectTimer(TimerSet item) {
    _current = item.copy();
    _isNewTimerReady = true;

    notifyListeners();
  }

  void onReady() {
    _isNewTimerReady = false;
  }

  void reset() {
    _current = TimerSet();

    notifyListeners();
  }

}
