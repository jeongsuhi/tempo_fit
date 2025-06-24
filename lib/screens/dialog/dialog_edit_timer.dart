import 'package:flutter/material.dart';
import 'package:tempo_fit/l10n/l10n.dart';
import 'package:tempo_fit/providers/app_settings_provider.dart';
import 'package:tempo_fit/providers/timer_set_provider.dart';
import 'package:tempo_fit/screens/item/timer_pickers.dart';
import 'package:tempo_fit/screens/toast.dart';
import 'package:tempo_fit/utils/firebase_analytics.dart';
import 'package:tempo_fit/values/themes.dart';
import 'package:tempo_fit/typeAdapter/timer_set.dart';
import 'package:provider/provider.dart';

void showTimerEditDialog(BuildContext context, VoidCallback onCancel) async {
  String dialogName = "DA_TimerEdit";

  FirebaseAnalyticsService.sendDialogEvent(dialogName: dialogName);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return GestureDetector(
          onTap: () {
            FirebaseAnalyticsService.sendButtonEvent(buttonName: "cancel", screenName: dialogName);

            Navigator.of(context).pop();
            onCancel();
          },
          child: const TimerEditDialog(),
      );
    }
  );
}

class TimerEditDialog extends StatelessWidget {
  final String dialogName = "DA_TimerEdit";

  const TimerEditDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<AppSettingsProvider, TimerSetProvider>(
        builder: (context, appProvider, timerSetProvider, child) {
          var current = timerSetProvider.current;
          final l10n = L10n.of(context);

          return Dialog(
            backgroundColor: current.isFavorite ? appProvider.currentTheme.primaryBaseColor
                : appProvider.currentTheme.backgroundColor,
            insetPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
            child: Container(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          FirebaseAnalyticsService.sendButtonEvent(buttonName: "close", screenName: dialogName);

                          timerSetProvider.resetCurrentItem();
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.close_outlined, color: appProvider.currentTheme.onBackgroundColor),
                        iconSize: 24,
                      ),
                      IconButton(
                        onPressed: () {
                          FirebaseAnalyticsService.sendButtonEvent(
                              buttonName: "favorite",
                              screenName: dialogName,
                              options: { "turn to" : "${!current.isFavorite}" });

                          timerSetProvider.change(isFavorite: !current.isFavorite);
                        },
                        tooltip: l10n.timerFavoriteTip,
                        icon: iconColor(current, appProvider.currentTheme),
                        iconSize: 32,
                      ),
                    ],
                  ),
                  buildTimerPickers(appProvider.currentTheme, context, current, (title, set, actTimeMinute, actTimeSecond, restTimeMinute, restTimeSecond) {
                        timerSetProvider.change(
                        title: title,
                        set: set,
                        actTimeMinute: actTimeMinute,
                        actTimeSecond: actTimeSecond,
                        restTimeMinute: restTimeMinute,
                        restTimeSecond: restTimeSecond
                    );
                  }),
                  const SizedBox(
                    height: 32,
                  ),
                  // save btn
                  SizedBox(
                    width: 160,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () => {
                        FirebaseAnalyticsService.sendButtonEvent(buttonName: "save", screenName: dialogName),

                        timerSetProvider.updateCurrentItem(),
                        showToast(l10n.toastSaveComplete),
                        Navigator.of(context).pop(),
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(appProvider.currentTheme.primaryColor),
                        overlayColor: MaterialStateProperty.all<Color>(appProvider.currentTheme.primaryOverlayColor),
                      ),
                      child: Text(
                        l10n.buttonSave,
                        style: Theme.of(context).textTheme.titleLarge!.apply(
                            color: appProvider.currentTheme.onPrimaryColor
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  // delete btn
                  SizedBox(
                    width: 160,
                    height: 40,
                    child: TextButton(
                      onPressed: () => {
                        FirebaseAnalyticsService.sendButtonEvent(buttonName: "delete", screenName: dialogName),

                        timerSetProvider.deleteItem(),
                        Navigator.pop(context),
                        showToast(l10n.toastDeleteComplete),
                      },
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all<Color>(appProvider.currentTheme.inactiveOverlayColor),
                      ),
                      child: Text(
                        l10n.buttonDelete,
                        style: Theme.of(context).textTheme.titleMedium!.apply(
                            color: appProvider.currentTheme.onBackgroundColor
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
    );
  }
}

Icon iconColor(TimerSet item, Themes themes) {
  if (item.isFavorite) {
    return Icon(Icons.local_fire_department, color: themes.primaryColor);
  } else {
    return Icon(Icons.local_fire_department_outlined, color: themes.onBaseColor);
  }
}
