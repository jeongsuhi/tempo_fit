import 'package:flutter/material.dart';
import 'package:tempo_fit/values/sounds.dart';

class SoundTestProvider extends ChangeNotifier {

  /// 音ID
  late Sound testSound;

  void testSoundId(String id) {
    testSound = Sound.values.firstWhere((element) => element.id == id );
    notifyListeners();
  }
}