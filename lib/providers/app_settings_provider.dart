import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tempo_fit/typeAdapter/app_settings.dart';
import 'package:tempo_fit/utils/format.dart';
import 'package:tempo_fit/values/sounds.dart';
import 'package:tempo_fit/values/themes.dart';

class AppSettingsProvider extends ChangeNotifier {

  // 内部データ
  late Box<AppSettings> _appSettingsBox;
  static const keyAppSettings = "KEY_APP_SETTINGS";

  /// 現在の設定
  late AppSettings currentSettings;

  /// テーマカラーID
  Themes get currentTheme => currentSettings.themeColorId.isEmpty ? Themes.darkRedWhite
      : Themes.values.firstWhere((element) => element.id == currentSettings.themeColorId );
  /// サウンドID
  Sound get currentSound => currentSettings.soundId.isEmpty ? Sound.electronicSound
      : Sound.values.firstWhere((element) => element.id == currentSettings.soundId );
  /// 広告非表示状態かどうか
  /// 非表示状態なら true, それ以外 false
  bool get isActiveNoCommercials => currentSettings.dateSeeVideoAd.isEmpty ? false
      : parseDateTime(currentSettings.dateSeeVideoAd)
          .add(const Duration(days: 3))
          .isAfter(DateTime.now().toUtc());


  void saveThemeColorId(String id) {
    if (Themes.values.map((e) => e.id).contains(id)) {
      var edited = currentSettings.copy();
      edited.themeColorId = id;
      _appSettingsBox.put(keyAppSettings, edited);

      currentSettings = edited;
      notifyListeners();
    } else {
      false;
    }
  }

  void saveSoundId(String id) {
    if (Sound.values.map((e) => e.id).contains(id)) {
      var edited = currentSettings.copy();
      edited.soundId = id;
      _appSettingsBox.put(keyAppSettings, edited);

      currentSettings = edited;
      notifyListeners();
    } else {
      false;
    }
  }

  void saveDateSeeVideoAd(String date) {
    var edited = currentSettings.copy();
    edited.dateSeeVideoAd = date;
    _appSettingsBox.put(keyAppSettings, edited);

    currentSettings = edited;
    notifyListeners();
  }

  Future<void> _init(Box<AppSettings> appSettingsBox) async {
    _appSettingsBox = appSettingsBox;

    var value = _appSettingsBox.get(keyAppSettings, defaultValue: AppSettings()) as AppSettings;
    currentSettings = value;

    notifyListeners();
  }

  AppSettingsProvider(Box<AppSettings> appSettingsBox) {
    _init(appSettingsBox);
  }
}