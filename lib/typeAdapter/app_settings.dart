import 'package:hive/hive.dart';

part 'app_settings.g.dart';

@HiveType(typeId: 3)
class AppSettings {
  @HiveField(0) String themeColorId;
  @HiveField(1) String soundId;
  @HiveField(2) bool isReviewed;
  @HiveField(3) String dateSeeVideoAd;
  @HiveField(4) String userId;

  AppSettings({
    this.themeColorId = "",
    this.soundId = "",
    this.isReviewed = false,
    this.dateSeeVideoAd = "",
    this.userId = "",
  });

  AppSettings copy() {
    return AppSettings(
      themeColorId: themeColorId,
      soundId: soundId,
      isReviewed: isReviewed,
      dateSeeVideoAd: dateSeeVideoAd,
      userId: userId,
    );
  }
}
