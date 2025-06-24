import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tempo_fit/l10n/l10n.dart';
import 'package:tempo_fit/providers/ad_provider.dart';
import 'package:tempo_fit/providers/app_settings_provider.dart';
import 'package:tempo_fit/providers/timer_provider.dart';
import 'package:tempo_fit/providers/timer_set_provider.dart';
import 'package:tempo_fit/screens/dialog/dialog_edit_timer.dart';
import 'package:tempo_fit/screens/item/timer_tile.dart';
import 'package:tempo_fit/screens/page_timer.dart';
import 'package:tempo_fit/utils/firebase_analytics.dart';
import 'package:tempo_fit/values/themes.dart';
import 'package:provider/provider.dart';
import '../utils/navigator.dart';

class TimerSetListPage extends StatelessWidget {
  static String pageName = "PG_TimerSetList";

  TimerSetListPage({super.key}) {
    FirebaseAnalyticsService.sendScreenEvent(screenName: pageName);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer3<TimerSetProvider, AppSettingsProvider, ADProvider>(
        builder: (context, timerSetProvider, appProvider, adProvider, child) {
          List<Widget> buildSetListHeader() {
            return timerSetProvider.isDeleteMode
                ? [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: timerSetProvider.isSelectedAll,
                          activeColor: appProvider.currentTheme.activeColor,
                          checkColor: appProvider.currentTheme.onPrimaryColor,
                          onChanged: (value) {
                            FirebaseAnalyticsService.sendButtonEvent(
                                buttonName: "allDelete",
                                screenName: pageName,
                                options: {"turn to": "$value"});

                            timerSetProvider.changeSelectAll(value!);
                          },
                        ),
                        Text(
                          L10n.of(context).buttonSelectAllTimer,
                          style: Theme.of(context).textTheme.titleMedium!.apply(
                              color:
                                  appProvider.currentTheme.onBackgroundColor),
                        ),
                      ],
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.close_outlined,
                          size: 24.0,
                          color: appProvider.currentTheme.onBackgroundColor,
                        ),
                        onPressed: () => {
                              FirebaseAnalyticsService.sendButtonEvent(
                                  buttonName: "ModeIcon",
                                  screenName: pageName,
                                  options: {"turn to": "normal"}),
                              timerSetProvider.changeMode()
                            })
                  ]
                : [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                      child: Text(
                        L10n.of(context).timerSetList,
                        style: Theme.of(context).textTheme.titleMedium!.apply(
                            color: appProvider.currentTheme.onBackgroundColor),
                      ),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.delete_outline,
                          size: 24.0,
                          color: appProvider.currentTheme.onBackgroundColor,
                        ),
                        onPressed: () => {
                              FirebaseAnalyticsService.sendButtonEvent(
                                  buttonName: "ModeIcon",
                                  screenName: pageName,
                                  options: {"turn to": "delete"}),
                              timerSetProvider.changeMode()
                            })
                  ];
          }

          return ListView.builder(
            itemCount: timerTileItemCount(timerSetProvider.items, 2),
            itemBuilder: (context, index) {
              if (index == 0) {
                return (!appProvider.isActiveNoCommercials &&
                        adProvider.isNativeAdLoaded)
                    ? Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 4),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            minWidth: 320, // minimum recommended width
                            minHeight: 320, // minimum recommended height
                            maxWidth: 400,
                            maxHeight: 400,
                          ),
                          child: AdWidget(
                            ad: adProvider.timerSetListScreenNativeAd,
                          ),
                        ))
                    : const SizedBox();
              } else if (index == 1) {
                return Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: buildSetListHeader(),
                    ));
              } else {
                if (timerSetProvider.items.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 4.0),
                    child: Center(
                        child: Text(L10n.of(context).timerSetListEmpty,
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .apply(
                                    color: appProvider
                                        .currentTheme.onBackgroundColor),
                            textAlign: TextAlign.center)),
                  );
                } else {
                  return timerSetProvider.isDeleteMode
                      ? buildCheckboxTimerTile(
                          appProvider.currentTheme,
                          context,
                          2,
                          index,
                          timerSetProvider.items,
                          timerSetProvider.selectedItems,
                          (value, isChecked) {
                            // check box or tile pressed
                            timerSetProvider.selectedItem(value, isChecked);
                          },
                        )
                      : buildTimerTile(appProvider.currentTheme, context, 2,
                          index, timerSetProvider.items, (value) {
                          // onTap
                          FirebaseAnalyticsService.sendButtonEvent(
                              buttonName: "start timer", screenName: pageName);

                          adProvider.disposeTimerSetListNativeAd(
                              appProvider.isActiveNoCommercials);
                          adProvider.initTimerSetListNativeAd(
                              appProvider.isActiveNoCommercials,
                              appProvider.currentTheme);

                          Provider.of<TimerProvider>(context, listen: false)
                              .selectTimer(value);
                          navigateZoomIn(context, TimerPage());
                        }, (value) {
                          // onLongPress
                          FirebaseAnalyticsService.sendButtonEvent(
                              buttonName: "edit timer", screenName: pageName);

                          timerSetProvider.selectItem(value);
                          showTimerEditDialog(context, () {
                            timerSetProvider.resetCurrentItem();
                          });
                        }, (value) {
                          // trailing Icon onPressed
                          FirebaseAnalyticsService.sendButtonEvent(
                              buttonName: "favorite",
                              screenName: pageName,
                              options: {"turn to": "${!value.isFavorite}"});

                          timerSetProvider.editFavorite(
                              value.id, !value.isFavorite);
                        });
                }
              }
            },
          );
        },
      ),
    );
  }
}
