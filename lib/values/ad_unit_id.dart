
enum AdUnitId {
  appOpen,
  adaptiveBanner,
  fixedSizeBanner,
  interstitial,
  interstitialVideo,
  rewarded,
  rewardedInterstitial,
  nativeAdvanced,
  nativeAdvancedVideo,
}

extension AppExtension on AdUnitId {

  String get iOSDemo {
    switch (this) {
      case AdUnitId.appOpen:
        return "ca-app-pub-3940256099942544/5575463023";
      case AdUnitId.adaptiveBanner:
        return "ca-app-pub-3940256099942544/2435281174";
      case AdUnitId.fixedSizeBanner:
        return "ca-app-pub-3940256099942544/2934735716";
      case AdUnitId.interstitial:
        return "ca-app-pub-3940256099942544/4411468910";
      case AdUnitId.interstitialVideo:
        return "ca-app-pub-3940256099942544/5135589807";
      case AdUnitId.rewarded:
        return "ca-app-pub-3940256099942544/1712485313";
      case AdUnitId.rewardedInterstitial:
        return "ca-app-pub-3940256099942544/6978759866";
      case AdUnitId.nativeAdvanced:
        return "ca-app-pub-3940256099942544/3986624511";
      case AdUnitId.nativeAdvancedVideo:
        return "ca-app-pub-3940256099942544/2521693316";
    }
  }

  String get androidDemo {
    switch (this) {
      case AdUnitId.appOpen:
        return "ca-app-pub-3940256099942544/9257395921";
      case AdUnitId.adaptiveBanner:
        return "ca-app-pub-3940256099942544/9214589741";
      case AdUnitId.fixedSizeBanner:
        return "ca-app-pub-3940256099942544/6300978111";
      case AdUnitId.interstitial:
        return "ca-app-pub-3940256099942544/1033173712";
      case AdUnitId.interstitialVideo:
        return "ca-app-pub-3940256099942544/8691691433";
      case AdUnitId.rewarded:
        return "ca-app-pub-3940256099942544/5224354917";
      case AdUnitId.rewardedInterstitial:
        return "ca-app-pub-3940256099942544/5354046379";
      case AdUnitId.nativeAdvanced:
        return "ca-app-pub-3940256099942544/2247696110";
      case AdUnitId.nativeAdvancedVideo:
        return "ca-app-pub-3940256099942544/1044960115";
    }
  }

  String get android {
    switch (this) {
      case AdUnitId.appOpen:
        return "ca-app-pub-3940256099942544/9257395921"; //for demo
      case AdUnitId.adaptiveBanner:
        return "ca-app-pub-3940256099942544/9214589741"; //for demo
      case AdUnitId.fixedSizeBanner:
        return "ca-app-pub-1656835020590051/8386544219";
      case AdUnitId.interstitial:
        return "ca-app-pub-3940256099942544/1033173712"; //for demo
      case AdUnitId.interstitialVideo:
        return "ca-app-pub-3940256099942544/8691691433"; //for demo
      case AdUnitId.rewarded:
        return "ca-app-pub-1656835020590051/6271183625";
      case AdUnitId.rewardedInterstitial:
        return "ca-app-pub-3940256099942544/5354046379"; //for demo
      case AdUnitId.nativeAdvanced:
        return "ca-app-pub-1656835020590051/3063400508";
      case AdUnitId.nativeAdvancedVideo:
        return "ca-app-pub-3940256099942544/1044960115"; //for demo
    }
  }
}