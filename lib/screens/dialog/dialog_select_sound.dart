import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:tempo_fit/l10n/l10n.dart';
import 'package:tempo_fit/providers/app_settings_provider.dart';
import 'package:tempo_fit/providers/sound_test_provider.dart';
import 'package:tempo_fit/screens/toast.dart';
import 'package:tempo_fit/utils/firebase_analytics.dart';
import 'package:tempo_fit/values/sounds.dart';
import 'package:tempo_fit/values/themes.dart';
import 'package:provider/provider.dart';

void showSelectSoundDialog(BuildContext context) async {
  String dialogName = "DA_SelectSound";
  final currentSound =
      Provider.of<AppSettingsProvider>(context, listen: false).currentSound;
  Provider.of<SoundTestProvider>(context, listen: false)
      .testSoundId(currentSound.id);

  FirebaseAnalyticsService.sendDialogEvent(dialogName: dialogName);

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            FirebaseAnalyticsService.sendButtonEvent(
                buttonName: "cancel", screenName: dialogName);
            Navigator.of(context).pop();
          },
          child: SelectSoundDialog(),
        );
      });
}

class SelectSoundDialog extends StatelessWidget {
  final String dialogName = "DA_SelectSound";
  SelectSoundDialog({super.key});
  final audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SoundTestProvider>(context);
    final appProvider = Provider.of<AppSettingsProvider>(context);
    final l10n = L10n.of(context);

    audioPlayer.setVolume(2.0);

    List<Widget> buildIconButtons() {
      return Sound.values
          .map((value) => Container(
              decoration: BoxDecoration(
                color: (value.id == provider.testSound.id)
                    ? appProvider.currentTheme.primaryAccentBaseColor
                    : appProvider.currentTheme.backgroundColor,
                borderRadius: BorderRadius.circular(50),
              ),
              child: IconButton(
                onPressed: () async {
                  await audioPlayer.stop();

                  FirebaseAnalyticsService.sendButtonEvent(
                      buttonName: "soundIcon",
                      screenName: dialogName,
                      options: {"id": value.id});

                  provider.testSoundId(value.id);
                  if (value != Sound.none) {
                    await audioPlayer.play(AssetSource(value.ready));
                  }
                },
                splashColor: appProvider.currentTheme.primaryOverlayColor,
                highlightColor: appProvider.currentTheme.primaryOverlayColor,
                icon: Icon(
                  value.icon,
                  color: appProvider.currentTheme.onBackgroundColor,
                  size: Theme.of(context).textTheme.displayMedium!.fontSize,
                ),
                isSelected: (value.id == provider.testSound.id),
                selectedIcon: Icon(
                  value.icon,
                  color: appProvider.currentTheme.primaryColor,
                  size: Theme.of(context).textTheme.displayMedium!.fontSize,
                ),
              )))
          .toList();
    }

    return Dialog(
      backgroundColor: appProvider.currentTheme.backgroundColor,
      insetPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16.0, 40.0, 16.0, 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: buildIconButtons(),
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              width: 160,
              height: 48,
              child: ElevatedButton(
                onPressed: () async => {
                  await audioPlayer.stop(),
                  FirebaseAnalyticsService.sendButtonEvent(
                      buttonName: "apply",
                      screenName: dialogName,
                      options: {"id": provider.testSound.id}),
                  Provider.of<AppSettingsProvider>(context, listen: false)
                      .saveSoundId(provider.testSound.id),
                  Navigator.of(context).pop(),
                  showToast(l10n.toastApplyComplete)
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(
                      appProvider.currentTheme.primaryColor),
                  overlayColor: WidgetStateProperty.all<Color>(
                      appProvider.currentTheme.primaryOverlayColor),
                ),
                child: Text(
                  l10n.buttonApply,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .apply(color: appProvider.currentTheme.onPrimaryColor),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              width: 160,
              height: 48,
              child: TextButton(
                onPressed: () async => {
                  FirebaseAnalyticsService.sendButtonEvent(
                      buttonName: "cancel", screenName: dialogName),
                  await audioPlayer.stop(),
                  await audioPlayer.dispose(),
                  Navigator.of(context).pop(),
                },
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all<Color>(
                      appProvider.currentTheme.backgroundOverlayColor),
                ),
                child: Text(
                  l10n.buttonClose,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .apply(color: appProvider.currentTheme.onBackgroundColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
