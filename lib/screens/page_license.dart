import 'package:flutter/material.dart';
import 'package:tempo_fit/l10n/l10n.dart';
import 'package:tempo_fit/utils/firebase_analytics.dart';
import 'package:tempo_fit/values/app.dart';

class MyLicensePage extends StatelessWidget {
  static String pageName = "PG_MyLicense";

  MyLicensePage({super.key}) {
    FirebaseAnalyticsService.sendScreenEvent(screenName: pageName);
  }

  @override
  Widget build(BuildContext context) {
    return LicensePage(
      applicationName: L10n.of(context).appName, // アプリの名前
      applicationVersion: App.version.value, // バージョン
      applicationIcon: const Icon(Icons.local_fire_department), // アプリのアイコン
      applicationLegalese: 'All rights reserved', // 著作権表示
    );
  }
}