import 'package:flutter/material.dart';
import 'package:tempo_fit/l10n/l10n.dart';
import 'package:tempo_fit/providers/app_settings_provider.dart';
import 'package:tempo_fit/providers/timer_provider.dart';
import 'package:tempo_fit/providers/timer_set_provider.dart';
import 'package:tempo_fit/screens/item/timer_tile.dart';
import 'package:tempo_fit/utils/firebase_analytics.dart';
import 'package:tempo_fit/values/themes.dart';
import 'package:provider/provider.dart';

class TimerSetListBottomSheet extends StatelessWidget {
  static String sheetName = "ST_TimerSetList";

  TimerSetListBottomSheet({super.key}) {
    FirebaseAnalyticsService.sendBottomSheetEvent(sheetName: sheetName);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TimerSetProvider>(context);
    final appProvider = Provider.of<AppSettingsProvider>(context);

    return DraggableScrollableSheet(
      expand: false,
      maxChildSize: 1.0,
      builder: (BuildContext context, ScrollController scrollController) {

        return ListView.builder(
            controller: scrollController,
            itemCount: timerTileItemCount(provider.items, 1),
            itemBuilder: (context, index) {
              if (index == 0) {
                return Container(
                  alignment: Alignment.center,
                  child: Text(
                    L10n.of(context).timerListBottomSheetTitle,
                    style: Theme.of(context).textTheme.bodyLarge!.apply(
                      color: appProvider.currentTheme.onBackgroundColor
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                return buildTimerTile(appProvider.currentTheme, context, 1, index, provider.items,
                    (value) {
                      // onTap
                      FirebaseAnalyticsService.sendButtonEvent(buttonName: "start", screenName: sheetName);

                      Provider.of<TimerProvider>(context, listen: false).selectTimer(value);
                      Navigator.of(context).pop();
                    },
                    (value) {
                      // onLongPress -> nothing
                    },
                    (value) {
                      // trailing Icon onPressed
                    });
              }
          });
      });
  }

}

