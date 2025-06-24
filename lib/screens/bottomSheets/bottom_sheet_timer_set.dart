import 'package:flutter/material.dart';
import 'package:tempo_fit/l10n/l10n.dart';
import 'package:tempo_fit/providers/ad_provider.dart';
import 'package:tempo_fit/providers/app_settings_provider.dart';
import 'package:tempo_fit/providers/timer_provider.dart';
import 'package:tempo_fit/providers/timer_set_provider.dart';
import 'package:tempo_fit/screens/dialog/dialog_alert.dart';
import 'package:tempo_fit/screens/item/timer_pickers.dart';
import 'package:tempo_fit/screens/page_timer.dart';
import 'package:tempo_fit/screens/toast.dart';
import 'package:tempo_fit/utils/firebase_analytics.dart';
import 'package:tempo_fit/values/themes.dart';
import 'package:tempo_fit/typeAdapter/timer_set.dart';
import 'package:provider/provider.dart';
import '../../utils/navigator.dart';

class TimerSetBottomSheet extends StatelessWidget {
  static String sheetName = "ST_TimerSet";

  TimerSetBottomSheet({super.key}) {
    FirebaseAnalyticsService.sendBottomSheetEvent(sheetName: sheetName);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TimerSetProvider>(context);
    final appProvider = Provider.of<AppSettingsProvider>(context);
    final adProvider = Provider.of<ADProvider>(context);
    final l10n = L10n.of(context);

    bool verifyTimeSet(TimerSet data) {
      bool result = true;

      if (data.actTimeMinute == 0 && data.actTimeSecond == 0) {
        // 運動時間を入力してください
        result = false;
        showOkDialog(context, appProvider.currentTheme, l10n.alertInputMissingTimerWorkoutTime);
      }
      if (data.set > 1 && data.restTimeMinute == 0 && data.restTimeSecond == 0) {
        // 休憩時間を入力してください
        result = false;
        showOkDialog(context, appProvider.currentTheme, l10n.alertInputMissingTimerRestTime);
      }

      return result;
    }

    return SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            // keyboard inset
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  buildTimerPickers(appProvider.currentTheme, context, provider.current, (title, set, actTimeMinute, actTimeSecond, restTimeMinute, restTimeSecond) {
                    provider.change(
                        title: title,
                        set: set,
                        actTimeMinute: actTimeMinute,
                        actTimeSecond: actTimeSecond,
                        restTimeMinute: restTimeMinute,
                        restTimeSecond: restTimeSecond
                    );
                  }),
                  const SizedBox(
                    height: 20,
                  ),

                  // start btn
                  SizedBox(
                    width: 240,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        FirebaseAnalyticsService.sendButtonEvent(buttonName: "start", screenName: sheetName);

                        if (verifyTimeSet(provider.current)) {
                          adProvider.disposeTimerSetListNativeAd(appProvider.isActiveNoCommercials);
                          adProvider.initTimerSetListNativeAd(appProvider.isActiveNoCommercials, appProvider.currentTheme);

                          Provider.of<TimerProvider>(context, listen: false).selectTimer(provider.current);
                          Navigator.pop(context);
                          navigateZoomIn(context, TimerPage());
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(appProvider.currentTheme.primaryColor),
                        overlayColor: MaterialStateProperty.all<Color>(appProvider.currentTheme.primaryOverlayColor),
                      ),
                      child: Text(
                        L10n.of(context).buttonStart,
                        style: Theme.of(context).textTheme.titleLarge!.apply(
                            color: appProvider.currentTheme.onPrimaryColor
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 16,
                  ),

                  // save setting btn
                  SizedBox(
                    width: 240,
                    height: 60,
                    child: OutlinedButton(
                      onPressed: () {
                        FirebaseAnalyticsService.sendButtonEvent(buttonName: "save", screenName: sheetName);

                        if (verifyTimeSet(provider.current)) {
                          provider.registerItem();
                          showToast(l10n.toastSaveComplete);
                          Navigator.pop(context);
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(appProvider.currentTheme.backgroundColor),
                          overlayColor: MaterialStateProperty.all<Color>(appProvider.currentTheme.backgroundOverlayColor),
                          side: MaterialStateProperty.all<BorderSide>(BorderSide(
                              color: appProvider.currentTheme.onBackgroundColor,
                              width: 1
                          ))
                      ),
                      child: Text(
                        l10n.buttonSaveTimer,
                        style: Theme.of(context).textTheme.titleLarge!.apply(
                          color: appProvider.currentTheme.onBackgroundColor,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 24,
                  ),
                ]
            ),
          ),
        ),
    );
  }
}

