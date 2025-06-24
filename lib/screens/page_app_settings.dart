import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tempo_fit/l10n/l10n.dart';
import 'package:tempo_fit/providers/ad_provider.dart';
import 'package:tempo_fit/providers/app_settings_provider.dart';
import 'package:tempo_fit/providers/exercise_log_provider.dart';
import 'package:tempo_fit/screens/dialog/dialog_alert.dart';
import 'package:tempo_fit/screens/dialog/dialog_select_sound.dart';
import 'package:tempo_fit/screens/dialog/dialog_select_theme.dart';
import 'package:tempo_fit/screens/page_license.dart';
import 'package:tempo_fit/utils/firebase_analytics.dart';
import 'package:tempo_fit/utils/format.dart';
import 'package:tempo_fit/values/app.dart';
import 'package:tempo_fit/values/themes.dart';
import 'package:tempo_fit/utils/navigator.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

class AppSettingsPage extends StatelessWidget {
  static String pageName = "PG_AppSettings";
  AppSettingsPage({super.key}) {
    FirebaseAnalyticsService.sendScreenEvent(screenName: pageName);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<AppSettingsProvider, ExerciseLogProvider, ADProvider>(
      builder: (context, appProvider, provider, adProvider, child) {
        // 早めにロードしておく
        adProvider.initNoCommercialsVideoAd();

        /// メーラーを起動
        Future openEmail() async {
          final Uri emailLaunchUri = Uri(
            scheme: 'mailto',
            path: App.contact.value,
            queryParameters: {
              'subject': L10n.of(context).emailParameterSubject,
              'body': L10n.of(context).emailParameterBody,
            },
          );

          try {
            bool canLaunchValue = await canLaunchUrl(emailLaunchUri);

            if (canLaunchValue) {
              dynamic launchResult = await launchUrl(emailLaunchUri);
              debugPrint('openEmail /launchUrl result: $launchResult');
            } else {
              showOkDialog(context, appProvider.currentTheme,
                  L10n.of(context).alertFailureLaunchApplication);
            }
          } catch (e) {
            showOkDialog(context, appProvider.currentTheme,
                L10n.of(context).alertNotAvailableApplication);
          }
        }

        /// アプリ評価画面に遷移
        Future openAppStore() async {
          final appStoreLaunchUri = App.store.uri!;

          try {
            bool canLaunchValue = await canLaunchUrl(appStoreLaunchUri);

            if (canLaunchValue) {
              dynamic launchResult = await launchUrl(appStoreLaunchUri);
              debugPrint('appStoreLaunchUri result: $launchResult');
            } else {
              showOkDialog(context, appProvider.currentTheme,
                  L10n.of(context).alertFailureLaunchApplication);
            }
          } catch (e) {
            showOkDialog(context, appProvider.currentTheme,
                L10n.of(context).alertNotAvailableApplication);
          }
        }

        /// 広告を表示しない
        void showNoCommercialsVideoAd() {
          if (appProvider.isActiveNoCommercials) {
            // 広告非表示が有効
            showOkDialog(context, appProvider.currentTheme,
                L10n.of(context).validCommercials);
          } else {
            FirebaseAnalyticsService.sendSelectAdEvent(adName: "reward_noAd");
            // 広告非表示が無効
            if (adProvider.isRewardedAdLoaded) {
              adProvider.noCommercialsVideoAd.show(onUserEarnedReward:
                  (AdWithoutView ad, RewardItem rewardItem) {
                debugPrint('onUserEarnedReward called.');
                // Reward the user for watching an ad.
                appProvider
                    .saveDateSeeVideoAd(formatDateTime(DateTime.now().toUtc()));
                showOkDialog(context, appProvider.currentTheme,
                    L10n.of(context).validCommercialsStart);
              });
            }
          }
        }

        /// シェアする
        void shareApp() {
          final String appStoreLaunchUri = App.store.value;

          FirebaseAnalyticsService.sendShareEvent();

          SharePlus.instance.share(ShareParams(
              title: L10n.of(context).shareParameterSubject,
              text: 'check out my website https://example.com'));
        }

        /// 設定項目のラベル
        String getSettingsTitle(Settings item) {
          switch (item) {
            case Settings.themeColor:
              return L10n.of(context).settingsLabelThemeColor;
            case Settings.sound:
              return L10n.of(context).settingsLabelSound;
            case Settings.noCommercials:
              return L10n.of(context).settingsLabelNoCommercials;
            case Settings.share:
              return L10n.of(context).settingsLabelShareApp;
            case Settings.review:
              return L10n.of(context).settingsLabelReviewApp;
            case Settings.contactUs:
              return L10n.of(context).settingsLabelContactUs;
            case Settings.license:
              return L10n.of(context).settingsLabelLicense;
            case Settings.version:
              return L10n.of(context).settingsLabelVersion;
          }
        }

        return Scaffold(
          appBar: AppBar(
            backgroundColor: appProvider.currentTheme.backgroundColor,
            foregroundColor: appProvider.currentTheme.onBackgroundColor,
            elevation: 8,
            shadowColor: appProvider.currentTheme.activeColor,
            title: Text(L10n.of(context).settingsTitle),
          ),
          body: ListView.builder(
            itemCount: Settings.values.length,
            itemBuilder: (context, index) {
              var item = Settings.values[index];

              return ListTile(
                tileColor: appProvider.currentTheme.backgroundColor,
                title: Text(
                  getSettingsTitle(item),
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .apply(color: appProvider.currentTheme.onBackgroundColor),
                ),
                subtitle: (item == Settings.version)
                    ? Text(
                        App.version.value,
                        style: Theme.of(context).textTheme.bodySmall!.apply(
                            color: appProvider.currentTheme.onBackgroundColor),
                      )
                    : null,
                leading: Icon(item.icon,
                    color: appProvider.currentTheme.onBackgroundColor),
                onTap: item.isClickable
                    ? () {
                        FirebaseAnalyticsService.sendButtonEvent(
                            buttonName: item.name, screenName: pageName);

                        switch (item) {
                          case Settings.themeColor:
                            showSelectThemeDialog(context);
                          case Settings.sound:
                            showSelectSoundDialog(context);
                          case Settings.noCommercials:
                            showNoCommercialsVideoAd();
                          case Settings.share:
                            shareApp();
                          case Settings.review:
                            openAppStore();
                          case Settings.contactUs:
                            openEmail();
                          case Settings.license:
                            navigateFadeIn(context, MyLicensePage());
                          case Settings.version:
                            null;
                        }
                      }
                    : null,
              );
            },
          ),
        );
      },
    );
  }
}

enum Settings {
  /// テーマカラー設定
  themeColor,

  /// 音設定
  sound,

  /// 広告を消す
  noCommercials,

  /// シェア
  share,

  /// 評価
  review,

  /// お問い合わせ
  contactUs,

  /// ライセンス
  license,

  /// バージョン情報
  version
}

extension SettingsExtension on Settings {
  bool get isClickable {
    switch (this) {
      case Settings.version:
        return false;
      default:
        return true;
    }
  }

  IconData get icon {
    switch (this) {
      case Settings.themeColor:
        return Icons.format_paint_rounded;
      case Settings.sound:
        return Icons.music_note;
      case Settings.noCommercials:
        return Icons.smart_display_rounded;
      case Settings.share:
        return Icons.share_outlined;
      case Settings.review:
        return Icons.auto_awesome;
      case Settings.contactUs:
        return Icons.info_outline;
      case Settings.license:
        return Icons.notes;
      case Settings.version:
        return Icons.local_fire_department;
    }
  }
}
