import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tempo_fit/l10n/l10n.dart';
import 'package:tempo_fit/providers/app_settings_provider.dart';
import 'package:tempo_fit/providers/log_mode_provider.dart';
import 'package:tempo_fit/providers/timer_set_provider.dart';
import 'package:tempo_fit/screens/page_app_settings.dart';
import 'package:tempo_fit/screens/page_exercise_album_list.dart';
import 'package:tempo_fit/screens/page_exercise_history_list.dart';
import 'package:tempo_fit/utils/firebase_analytics.dart';
import 'package:tempo_fit/values/themes.dart';
import 'package:tempo_fit/utils/navigator.dart';
import 'package:provider/provider.dart';
import '../providers/page_index_provider.dart';
import 'bottomSheets/bottom_sheet_timer_set.dart';
import 'dialog/dialog_alert.dart';
import 'page_timer_set_list.dart';

class HomePage extends StatelessWidget {
  static String pageName = "PG_Home";

  HomePage({super.key}) {
    // 初期化
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );

    FirebaseAnalyticsService.sendScreenEvent(screenName: pageName);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    final timerSetListPage = TimerSetListPage();
    final exerciseHistoryListPage = ExerciseHistoryListPage();
    final exerciseAlbumListPage = ExerciseAlbumListPage();

    return Consumer4<AppSettingsProvider, PageIndexProvider, TimerSetProvider,
            LogModeProvider>(
        builder: (context, appProvider, pageIndexProvider, timerSetProvider,
            logModeProvider, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: appProvider.currentTheme.primaryColor,
          title: (pageIndexProvider.currentIndex == 0)
              ? null
              : Text(
                  logModeProvider.modeName,
                  style: Theme.of(context).textTheme.titleMedium!.apply(
                        color: appProvider.currentTheme.onPrimaryColor,
                      ),
                ),
          actions: [
            if (pageIndexProvider.currentIndex == 1)
              IconButton(
                icon: logModeProvider.isAlbumMode
                    ? const Icon(Icons.list)
                    : const Icon(Icons.window_rounded),
                splashColor: appProvider.currentTheme.primaryOverlayColor,
                highlightColor: appProvider.currentTheme.primaryOverlayColor,
                color: appProvider.currentTheme.onPrimaryColor,
                onPressed: () {
                  logModeProvider.changeShowMode();
                },
              ),
            IconButton(
              icon: const Icon(Icons.settings),
              color: appProvider.currentTheme.onPrimaryColor,
              onPressed: () {
                FirebaseAnalyticsService.sendButtonEvent(
                    buttonName: "AppSetting", screenName: pageName);

                navigateLeftSlide(context, AppSettingsPage());
              },
            ),
          ],
        ),
        body: Center(
            child: IndexedStack(
          index: pageIndexProvider.currentIndex,
          children: [
            timerSetListPage,
            logModeProvider.isAlbumMode
                ? exerciseAlbumListPage
                : exerciseHistoryListPage,
          ],
        )),
        floatingActionButton: ((pageIndexProvider.currentIndex == 0) &
                !timerSetProvider.isDeleteMode)
            ? FloatingActionButton(
                foregroundColor: appProvider.currentTheme.primaryOverlayColor,
                backgroundColor: appProvider.currentTheme.primaryColor,
                onPressed: () {
                  FirebaseAnalyticsService.sendButtonEvent(
                      buttonName: "floatingAction", screenName: pageName);

                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return TimerSetBottomSheet();
                    },
                  );
                },
                child: Icon(Icons.more_time,
                    color: appProvider.currentTheme.onPrimaryColor),
              )
            : null,
        bottomSheet: (timerSetProvider.isDeleteMode)
            ? Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: timerSetProvider.selectedItems.isEmpty
                        ? null
                        : () => {
                              FirebaseAnalyticsService.sendButtonEvent(
                                  buttonName: "DeleteTimer",
                                  screenName: pageName,
                                  options: {
                                    "count":
                                        "${timerSetProvider.selectedItems.length}"
                                  }),
                              showCancelableDialog(
                                  context,
                                  appProvider.currentTheme,
                                  l10n.confirmDeleteTimer, () {
                                timerSetProvider.deleteItems();
                              })
                            },
                    style: ButtonStyle(
                      backgroundColor: timerSetProvider.selectedItems.isEmpty
                          ? WidgetStateProperty.all(
                              appProvider.currentTheme.inactiveColor)
                          : WidgetStateProperty.all(
                              appProvider.currentTheme.primaryColor),
                      overlayColor: timerSetProvider.selectedItems.isEmpty
                          ? null
                          : WidgetStateProperty.all<Color>(
                              appProvider.currentTheme.primaryOverlayColor),
                    ),
                    child: Text(
                      l10n.announceDeleteTimer(
                          timerSetProvider.selectedItems.length.toString()),
                      style: Theme.of(context).textTheme.titleLarge!.apply(
                          color: timerSetProvider.selectedItems.isEmpty
                              ? appProvider.currentTheme.onInactiveColor
                              : appProvider.currentTheme.onPrimaryColor),
                    ),
                  ),
                ),
              )
            : null,
        bottomNavigationBar: (timerSetProvider.isDeleteMode)
            ? null
            : BottomNavigationBar(
                currentIndex: pageIndexProvider.currentIndex,
                backgroundColor: appProvider.currentTheme.backgroundColor,
                unselectedItemColor: appProvider.currentTheme.onBackgroundColor,
                selectedItemColor: appProvider.currentTheme.primaryColor,
                onTap: (index) {
                  FirebaseAnalyticsService.sendButtonEvent(
                      buttonName: "bottomNavigation",
                      screenName: pageName,
                      options: {"index": "$index"});

                  pageIndexProvider.updateIndex(index);
                },
                items: [
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.timer_outlined),
                    label: l10n.footerLabelTimer,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.list_alt),
                    label: l10n.footerLabelHistory,
                  ),
                ],
              ),
      );
    });
  }
}
