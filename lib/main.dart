import 'dart:io';
import 'dart:math' as math;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tempo_fit/firebase_options.dart';
import 'package:tempo_fit/l10n/l10n.dart';
import 'package:tempo_fit/providers/ad_provider.dart';
import 'package:tempo_fit/providers/app_settings_provider.dart';
import 'package:tempo_fit/providers/exercise_log_provider.dart';
import 'package:tempo_fit/providers/log_mode_provider.dart';
import 'package:tempo_fit/providers/page_index_provider.dart';
import 'package:tempo_fit/providers/sound_test_provider.dart';
import 'package:tempo_fit/providers/theme_test_provider.dart';
import 'package:tempo_fit/providers/timer_provider.dart';
import 'package:tempo_fit/providers/timer_set_provider.dart';
import 'package:tempo_fit/screens/page_home.dart';
import 'package:tempo_fit/typeAdapter/app_settings.dart';
import 'package:tempo_fit/typeAdapter/exercise_log.dart';
import 'package:tempo_fit/utils/firebase_analytics.dart';
import 'package:tempo_fit/values/themes.dart';
import 'package:tempo_fit/typeAdapter/timer_set.dart';
import 'package:provider/provider.dart';

void main() async {
  const keyUserId = "KEY_USER_ID";

  // 初期化
  WidgetsFlutterBinding.ensureInitialized();

  // firebase
  await Firebase.initializeApp(
      name: "Tempo Fit", options: DefaultFirebaseOptions.currentPlatform);
  FirebaseAnalyticsService().init();

  // admob
  await MobileAds.instance.initialize();

  // hive DB
  await Hive.initFlutter();
  Hive.registerAdapter(AppSettingsAdapter());
  Hive.registerAdapter(TimerSetAdapter());
  Hive.registerAdapter(ExerciseLogAdapter());

  // アプリ設定値取得のためここでopen
  late Box<AppSettings> appSettingsBox;
  appSettingsBox = await Hive.openBox('appSettings');

  // FAへユーザー情報送信処理
  var value = appSettingsBox.get(keyUserId);

  if (value == null) {
    // ユーザーIDが登録されてなければ、作成し保存する
    // 5桁のID
    String newUserId =
        (math.Random().nextInt(100000 - 10000) + 10000).toString();
    value = AppSettings(userId: newUserId);
    appSettingsBox.put(keyUserId, value);
  }

  FirebaseAnalyticsService.sendUserId(userId: value.userId);
  FirebaseAnalyticsService.updateIsAdVisible(value.dateSeeVideoAd);
  sendUserInfo();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => AppSettingsProvider(appSettingsBox),
      ),
      ChangeNotifierProvider(
        create: (context) => ADProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => PageIndexProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => TimerSetProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => TimerProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => ExerciseLogProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => LogModeProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => ThemeTestProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => SoundTestProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}

Future<void> sendUserInfo() async {
  late String osVersion;
  late String deviceName;
  String os = Platform.operatingSystem;
  String language = Platform.localeName;

  // device info
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  debugPrint("setFirebaseAnalytics called. $defaultTargetPlatform");

  if (defaultTargetPlatform == TargetPlatform.android) {
    final androidInfo = await deviceInfoPlugin.androidInfo;
    osVersion = androidInfo.version.release;
    deviceName = androidInfo.device;
  } else if (defaultTargetPlatform == TargetPlatform.iOS) {
    final iosInfo = await deviceInfoPlugin.iosInfo;
    osVersion = iosInfo.systemVersion;
    deviceName = iosInfo.utsname.machine;
  } else {
    throw UnsupportedError(
      'defaultTargetPlatform is not android nor iOS',
    );
  }

  FirebaseAnalyticsService.sendUser(
      os: os, osVersion: osVersion, deviceName: deviceName, language: language);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // 縦固定
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Consumer<AppSettingsProvider>(
        builder: (context, appProvider, child) {
      return MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: appProvider.currentTheme.primaryColor),
          scaffoldBackgroundColor: appProvider.currentTheme.backgroundColor,
          bottomSheetTheme: BottomSheetThemeData(
            backgroundColor: appProvider.currentTheme.backgroundColor,
            surfaceTintColor: appProvider.currentTheme.backgroundColor,
          ),
          dialogTheme: DialogTheme(
            backgroundColor: appProvider.currentTheme.backgroundColor,
            surfaceTintColor: appProvider.currentTheme.backgroundColor,
          ).data,
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: {
              TargetPlatform.android: ZoomPageTransitionsBuilder(),
              TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
            },
          ),
          useMaterial3: true,
        ),
        navigatorObservers: <NavigatorObserver>[
          FirebaseAnalyticsService.observer
        ],
        localizationsDelegates: const [
          L10n.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ja'),
          Locale('ko'),
          Locale('en'),
        ],
        home: MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: const TextScaler.linear(1),
          ),
          child: HomePage(),
        ),
      );
    });
  }
}
