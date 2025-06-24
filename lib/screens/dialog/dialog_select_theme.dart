import 'package:flutter/material.dart';
import 'package:tempo_fit/l10n/l10n.dart';
import 'package:tempo_fit/providers/app_settings_provider.dart';
import 'package:tempo_fit/providers/theme_test_provider.dart';
import 'package:tempo_fit/screens/toast.dart';
import 'package:tempo_fit/utils/firebase_analytics.dart';
import 'package:tempo_fit/values/themes.dart';
import 'package:provider/provider.dart';

void showSelectThemeDialog(BuildContext context) async {
  String dialogName = "DA_SelectTheme";
  final currentTheme =
      Provider.of<AppSettingsProvider>(context, listen: false).currentTheme;
  Provider.of<ThemeTestProvider>(context, listen: false)
      .testThemeColorId(currentTheme.id);

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
          child: const SelectThemeDialog(),
        );
      });
}

class SelectThemeDialog extends StatelessWidget {
  final String dialogName = "DA_SelectTheme";
  const SelectThemeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeTestProvider>(context);
    final l10n = L10n.of(context);

    Widget buildBlinkCircle(Themes testTheme) {
      return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: testTheme.activeColor,
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(3, 3),
            ),
            BoxShadow(
              color: testTheme.activeColor,
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(3, -3),
            ),
            BoxShadow(
              color: testTheme.activeColor,
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(-3, -3),
              blurStyle: BlurStyle.solid,
            ),
            BoxShadow(
              color: testTheme.activeColor,
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(-3, 3),
            )
          ],
          color: Colors.transparent,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: testTheme.backgroundColor,
                  spreadRadius: 1,
                  blurRadius: 12,
                  offset: const Offset(3, 3),
                ),
                BoxShadow(
                  color: testTheme.backgroundColor,
                  spreadRadius: 1,
                  blurRadius: 12,
                  offset: const Offset(3, -3),
                ),
                BoxShadow(
                  color: testTheme.backgroundColor,
                  spreadRadius: 1,
                  blurRadius: 12,
                  offset: const Offset(-3, -3),
                  blurStyle: BlurStyle.solid,
                ),
                BoxShadow(
                  color: testTheme.backgroundColor,
                  spreadRadius: 1,
                  blurRadius: 12,
                  offset: const Offset(-3, 3),
                )
              ],
              color: testTheme.backgroundColor,
            ),
          ),
        ),
      );
    }

    List<Widget> buildIconButtons() {
      return Themes.values
          .map((value) => Container(
              decoration: BoxDecoration(
                color: value.backgroundColor,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: value.onBackgroundColor,
                  width: 1.0,
                ),
              ),
              child: IconButton(
                onPressed: () {
                  FirebaseAnalyticsService.sendButtonEvent(
                      buttonName: "themeIcon",
                      screenName: dialogName,
                      options: {"id": value.id});

                  provider.testThemeColorId(value.id);
                },
                splashColor: value.primaryOverlayColor,
                highlightColor: value.primaryOverlayColor,
                icon: Icon(
                  Icons.local_fire_department_outlined,
                  color: value.primaryColor,
                  size: Theme.of(context).textTheme.displayMedium!.fontSize,
                ),
                isSelected: (value.id == provider.testTheme.id),
                selectedIcon: Icon(
                  Icons.local_fire_department,
                  color: value.primaryColor,
                  size: Theme.of(context).textTheme.displayMedium!.fontSize,
                ),
              )))
          .toList();
    }

    return Dialog(
      backgroundColor: provider.testTheme.backgroundColor,
      insetPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16.0, 40.0, 16.0, 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.width / 2,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  buildBlinkCircle(provider.testTheme),
                  CircularProgressIndicator(
                    value: 0.65,
                    valueColor:
                        AlwaysStoppedAnimation(provider.testTheme.activeColor),
                    strokeWidth: 8,
                    backgroundColor: provider.testTheme.baseColor,
                  ),
                  Center(
                    child: Icon(
                      Icons.local_fire_department,
                      color: provider.testTheme.primaryColor,
                      size: Theme.of(context).textTheme.displayLarge!.fontSize,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: buildIconButtons(),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 160,
              height: 48,
              child: ElevatedButton(
                onPressed: () => {
                  FirebaseAnalyticsService.sendButtonEvent(
                      buttonName: "apply",
                      screenName: dialogName,
                      options: {"id": provider.testTheme.id}),
                  Provider.of<AppSettingsProvider>(context, listen: false)
                      .saveThemeColorId(provider.testTheme.id),
                  Navigator.of(context).pop(),
                  showToast(l10n.toastApplyComplete)
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(
                      provider.testTheme.primaryColor),
                  overlayColor: WidgetStateProperty.all<Color>(
                      provider.testTheme.primaryOverlayColor),
                ),
                child: Text(
                  l10n.buttonApply,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .apply(color: provider.testTheme.onPrimaryColor),
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
                onPressed: () => {
                  FirebaseAnalyticsService.sendButtonEvent(
                      buttonName: "cancel", screenName: dialogName),
                  Navigator.of(context).pop(),
                },
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all<Color>(
                      provider.testTheme.backgroundOverlayColor),
                ),
                child: Text(
                  l10n.buttonClose,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .apply(color: provider.testTheme.onBackgroundColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
