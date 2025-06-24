import 'package:flutter/material.dart';
import 'package:tempo_fit/values/themes.dart';

class ThemeTestProvider extends ChangeNotifier {

  /// テーマカラーID
  late Themes testTheme;

  void testThemeColorId(String id) {
    testTheme = Themes.values.firstWhere((element) => element.id == id );
    notifyListeners();
  }
}