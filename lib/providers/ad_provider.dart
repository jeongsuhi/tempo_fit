import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tempo_fit/flavor.dart';
import 'package:tempo_fit/utils/firebase_analytics.dart';
import 'package:tempo_fit/values/ad_unit_id.dart';
import 'package:tempo_fit/values/themes.dart';

class ADProvider extends ChangeNotifier {
  /// AD
  final String nameNativeTimerSetList = "native_timerSetList";
  late NativeAd _nativeAd;
  NativeAd get timerSetListScreenNativeAd => _nativeAd;
  bool _nativeAdLoaded = false;
  bool get isNativeAdLoaded => _nativeAdLoaded;

  final String nameBannerTimer = "banner_timer";
  late BannerAd _bannerAd;
  BannerAd get timerScreenBannerAd => _bannerAd;

  final String nameNoAd = "reward_noAd";
  late RewardedAd _rewardedAd;
  RewardedAd get noCommercialsVideoAd => _rewardedAd;
  bool _rewardedAdLoaded = false;
  bool get isRewardedAdLoaded => _rewardedAdLoaded;

  void initTimerSetListNativeAd(bool skip, Themes currentTheme) {
    if (!skip) {
      _nativeAd = NativeAd(
          adUnitId: Platform.isAndroid
              ? isProduction()
                  ? AdUnitId.nativeAdvanced.android
                  : AdUnitId.nativeAdvanced.androidDemo
              : AdUnitId.nativeAdvanced.iOSDemo,
          listener: NativeAdListener(
            onAdLoaded: (ad) {
              FirebaseAnalyticsService.sendAdShowEvent(
                  adName: nameNativeTimerSetList,
                  options: {"callback": "onAdLoaded"});
              _nativeAdLoaded = true;
              notifyListeners();
            },
            onAdFailedToLoad: (ad, error) {
              FirebaseAnalyticsService.sendAdShowEvent(
                  adName: nameNativeTimerSetList,
                  options: {"callback": "onAdFailedToLoad"});
              ad.dispose();
            },
          ),
          request: const AdRequest(),
          nativeTemplateStyle: NativeTemplateStyle(
              templateType: TemplateType.medium,
              // Optional: Customize the ad's style.
              mainBackgroundColor: currentTheme.backgroundColor,
              cornerRadius: 16.0,
              callToActionTextStyle: NativeTemplateTextStyle(
                  textColor: currentTheme.activeColor,
                  backgroundColor: currentTheme.backgroundColor,
                  style: NativeTemplateFontStyle.monospace,
                  size: 16.0),
              primaryTextStyle: NativeTemplateTextStyle(
                  textColor: currentTheme.primaryColor,
                  backgroundColor: currentTheme.backgroundColor,
                  style: NativeTemplateFontStyle.italic,
                  size: 16.0),
              secondaryTextStyle: NativeTemplateTextStyle(
                  textColor: currentTheme.onBackgroundColor,
                  backgroundColor: currentTheme.backgroundColor,
                  style: NativeTemplateFontStyle.bold,
                  size: 12.0),
              tertiaryTextStyle: NativeTemplateTextStyle(
                  textColor: currentTheme.onBackgroundColor,
                  backgroundColor: currentTheme.backgroundColor,
                  style: NativeTemplateFontStyle.normal,
                  size: 12.0)))
        ..load();
    }
  }

  void disposeTimerSetListNativeAd(bool skip) {
    if (!skip && _nativeAdLoaded) {
      _nativeAd.dispose();
      _nativeAdLoaded = false;
      notifyListeners();
    }
  }

  void initTimerBannerAd(bool skip, int contextWidth) {
    if (!skip) {
      _bannerAd = BannerAd(
          adUnitId: Platform.isAndroid
              ? isProduction()
                  ? AdUnitId.fixedSizeBanner.android
                  : AdUnitId.fixedSizeBanner.androidDemo
              : AdUnitId.fixedSizeBanner.iOSDemo,
          size: AdSize(width: contextWidth, height: 80),
          request: const AdRequest(),
          listener: BannerAdListener(
            onAdLoaded: (ad) {
              FirebaseAnalyticsService.sendAdShowEvent(
                  adName: nameBannerTimer, options: {"callback": "onAdLoaded"});
              notifyListeners();
            },
            onAdFailedToLoad: (ad, error) {
              FirebaseAnalyticsService.sendAdShowEvent(
                  adName: nameBannerTimer,
                  options: {"callback": "onAdFailedToLoad"});

              ad.dispose();
            },
          ))
        ..load();
    }
  }

  void initNoCommercialsVideoAd() {
    if (!_rewardedAdLoaded) {
      RewardedAd.load(
          adUnitId: Platform.isAndroid
              ? isProduction()
                  ? AdUnitId.rewarded.android
                  : AdUnitId.rewarded.androidDemo
              : AdUnitId.fixedSizeBanner.iOSDemo,
          request: const AdRequest(),
          rewardedAdLoadCallback: RewardedAdLoadCallback(
            // Called when an ad is successfully received.
            onAdLoaded: (ad) {
              ad.fullScreenContentCallback =
                  FullScreenContentCallback(onAdShowedFullScreenContent: (ad) {
                // Called when the ad showed the full screen content.
                FirebaseAnalyticsService.sendAdShowEvent(
                    adName: nameNoAd,
                    options: {"callback": "onAdShowedFullScreenContent"});
              }, onAdImpression: (ad) {
                // Called when an impression occurs on the ad.
                FirebaseAnalyticsService.sendAdShowEvent(
                    adName: nameNoAd, options: {"callback": "onAdImpression"});
              }, onAdFailedToShowFullScreenContent: (ad, err) {
                // Called when the ad failed to show full screen content.
                // Dispose the ad here to free resources.
                FirebaseAnalyticsService.sendAdShowEvent(
                    adName: nameNoAd,
                    options: {"callback": "onAdFailedToShowFullScreenContent"});

                ad.dispose();
                _rewardedAdLoaded = false;
              }, onAdDismissedFullScreenContent: (ad) {
                // Called when the ad dismissed full screen content.
                // Dispose the ad here to free resources.
                FirebaseAnalyticsService.sendAdShowEvent(
                    adName: nameNoAd,
                    options: {"callback": "onAdDismissedFullScreenContent"});

                ad.dispose();
                _rewardedAdLoaded = false;
              }, onAdClicked: (ad) {
                // Called when a click is recorded for an ad.
                FirebaseAnalyticsService.sendAdShowEvent(
                    adName: nameNoAd, options: {"callback": "onAdClicked"});
              });

              _rewardedAd = ad;
              _rewardedAdLoaded = true;
              notifyListeners();
            },
            // Called when an ad request failed.
            onAdFailedToLoad: (LoadAdError error) {
              FirebaseAnalyticsService.sendAdShowEvent(
                  adName: nameNoAd, options: {"callback": "onAdFailedToLoad"});

              _rewardedAdLoaded = false;
            },
          ));
    }
  }
}
