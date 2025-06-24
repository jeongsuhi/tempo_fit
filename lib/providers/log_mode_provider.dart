import 'package:flutter/material.dart';

class LogModeProvider extends ChangeNotifier {

  // 現在の表示モード
  bool _isAlbumMode = false;
  bool get isAlbumMode => _isAlbumMode;

  String get modeName => _isAlbumMode ? "ALBUM" : "LOG";

  void changeShowMode() {
    _isAlbumMode = !_isAlbumMode;

    notifyListeners();
  }
}
