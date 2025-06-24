import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:tempo_fit/utils/format.dart';

class FirebaseAnalyticsService {
  static late final FirebaseAnalytics analytics;
  static late final FirebaseAnalyticsObserver observer;
  static late final String currentUserId;
  static late String isAdVisible;

  void init() {
    analytics = FirebaseAnalytics.instance;
    observer = FirebaseAnalyticsObserver(analytics: analytics);
  }

  /// ユーザーID送信
  static Future<void> sendUserId({
    required String userId,
  }) async {
    try {
      currentUserId = userId;
      analytics.setUserId(id: userId);
    } catch(e) {
      // ignored, really.
    }
    debugPrint("firebase analytics userId: $userId, currentUserId: $currentUserId");
  }

  /// 広告状態更新
  static void updateIsAdVisible(
    String dateSeeVideoAd,
  ) {
    isAdVisible = dateSeeVideoAd.isEmpty ? "NONE"
        : parseDateTime(dateSeeVideoAd).add(const Duration(days: 3)).isAfter(DateTime.now().toUtc()) ? "NO"
        : "YES";
  }

  /// ユーザー情報送信
  static Future<void> sendUser({
    required String os,
    required String osVersion,
    required String deviceName,
    required String language,
  }) async {

    analytics.setUserProperty(
        name: 'os',
        value: os);
    analytics.setUserProperty(
        name: 'os_version',
        value: osVersion);
    analytics.setUserProperty(
        name: 'device_name',
        value: deviceName);
    analytics.setUserProperty(
        name: 'language',
        value: language);

    debugPrint("firebase analytics sendUser os: $os, osVersion: $osVersion, deviceName: $deviceName, language: $language");
  }

  /// 画面表示イベント送信
  static Future<void> sendScreenEvent({
    required String screenName,
    Map<String, String>? options
  }) async {
    analytics.logScreenView(
        screenName: screenName,
        parameters: {
          'user_id': currentUserId,
          'ad_isVisible': isAdVisible,
        });
  }

  /// シート表示イベント送信
  static Future<void> sendBottomSheetEvent({
    required String sheetName,
    Map<String, String>? options
  }) async {
    analytics.logEvent(
        name: AnalyticsEvent.bottomSheet.name,
        parameters: {
          'user_id': currentUserId,
          'ad_isVisible': isAdVisible,
          'name': sheetName,
        });
  }

  /// ダイアログ表示イベント送信
  static Future<void> sendDialogEvent({
    required String dialogName
  }) async {
    analytics.logEvent(
        name: AnalyticsEvent.dialog.name,
        parameters: {
          'user_id': currentUserId,
          'ad_isVisible': isAdVisible,
          'name': dialogName,
        });
  }

  /// ボタンタップイベント送信
  static Future<void> sendButtonEvent({
    required String buttonName,
    required String screenName,
    Map<String, String>? options
  }) async {
    var params = {
      'user_id': currentUserId,
      'ad_isVisible': isAdVisible,
      'screen_name': screenName,
      'name': buttonName,
    };

    if (options != null) {
      params.addAll(options);
    }

    analytics.logEvent(
        name: AnalyticsEvent.buttonClick.name,
        parameters: params);
  }

  /// 端末ボタンタップイベント送信
  static Future<void> sendSoftwareButtonEvent() async {
    analytics.logEvent(
        name: AnalyticsEvent.buttonClick.name,
        parameters: {
          'user_id': currentUserId,
          'ad_isVisible': isAdVisible,
          'buttonName': 'back key',
        });
  }

  /// 広告選択イベント送信
  static Future<void> sendSelectAdEvent({
    required String adName,
    Map<String, String>? options
  }) async {
    var params = {
      'user_id': currentUserId,
      'ad_isVisible': isAdVisible,
      'adName': adName,
    };

    if (options != null) {
      params.addAll(options);
    }

    analytics.logEvent(
        name: AnalyticsEvent.selectAd.name,
        parameters: params);
  }

  /// 広告表示イベント送信
  static Future<void> sendAdShowEvent({
    required String adName,
    Map<String, String>? options
  }) async {
    var params = {
      'user_id': currentUserId,
      'ad_isVisible': isAdVisible,
      'adName': adName,
    };

    if (options != null) {
      params.addAll(options);
    }

    analytics.logEvent(
        name: AnalyticsEvent.adShow.name,
        parameters: params);
  }

  /// 共有イベント送信
  static Future<void> sendShareEvent({
    Map<String, String>? options
  }) async {
    var params = {
      'user_id': currentUserId,
      'ad_isVisible': isAdVisible,
    };

    if (options != null) {
      params.addAll(options);
    }

    analytics.logEvent(
        name: AnalyticsEvent.share.name,
        parameters: params);
  }
}

enum AnalyticsEvent {
  dialog,
  bottomSheet,
  buttonClick,
  selectItem,
  selectAd,
  adShow,
  share,
}

extension AnalyticsEventExtension on AnalyticsEvent {
  String get name {
    switch (this) {
      case AnalyticsEvent.dialog:
        return "dialog_view";
      case AnalyticsEvent.bottomSheet:
        return "bottom_sheet_view";
      case AnalyticsEvent.buttonClick:
        return "button_click";
      case AnalyticsEvent.selectItem:
        return "select_item";
      case AnalyticsEvent.selectAd:
        return "select_ad";
      case AnalyticsEvent.adShow:
        return "ad_show";
      case AnalyticsEvent.share:
        return "share";
    }
  }
}