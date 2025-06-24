import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tempo_fit/l10n/l10n.dart';
import 'package:tempo_fit/providers/app_settings_provider.dart';
import 'package:tempo_fit/providers/exercise_log_provider.dart';
import 'package:tempo_fit/utils/firebase_analytics.dart';
import 'package:tempo_fit/utils/format.dart';
import 'package:tempo_fit/values/themes.dart';
import 'package:provider/provider.dart';

class ImageLogPage extends StatelessWidget {
  static String pageName = "PG_ImageLog";
  ImageLogPage({ super.key, required this.logKey }) {
    FirebaseAnalyticsService.sendScreenEvent(screenName: pageName);
  }

  final int logKey;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ExerciseLogProvider>(context);
    var initialLog = provider.imageItems.lastIndexWhere((element) => element.id == logKey);

    return Consumer<AppSettingsProvider>(
      builder: (context, appProvider, child) {

        return Container(
          color: Colors.black.withOpacity(0.5),
          child: PageView.builder(
            controller: PageController(
                viewportFraction: 0.85,
                initialPage: initialLog,
            ),
            onPageChanged: (int index) {
              try {
                FirebaseAnalyticsService.sendButtonEvent(
                    buttonName: "swipe",
                    screenName: pageName,
                    options: { "id" : "${provider.imageItems[index].id}" });
              } catch (e) {
                // nothing
              }
            },
            itemCount: provider.imageItems.length,
            itemBuilder: (BuildContext context, int index) {
              var item = provider.imageItems[index];

              return Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 32.0, 12.0, 32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 日付
                    Container(
                      color: appProvider.currentTheme.backgroundColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              FirebaseAnalyticsService.sendButtonEvent(buttonName: "close", screenName: pageName);

                              Navigator.of(context).pop();
                            },
                            icon: Icon(Icons.close, size: Theme.of(context).textTheme.labelLarge!.fontSize, color: appProvider.currentTheme.onBackgroundColor),
                          ),
                          Center(child: Text(
                            item.date,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.titleMedium?.apply(
                                color: appProvider.currentTheme.onBackgroundColor
                            ),
                          )),
                          IconButton(onPressed: null,
                              icon: Icon(Icons.circle, size: Theme.of(context).textTheme.labelLarge!.fontSize, color: appProvider.currentTheme.backgroundColor)
                          ),
                        ],
                      ),
                    ),
                    // 写真
                    Container(
                      color: appProvider.currentTheme.primaryAccentBaseColor,
                      child: Image.file(
                        File(item.imageUrl),
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    // ログ情報
                    Container(
                      color: appProvider.currentTheme.backgroundColor,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title,
                                    style: Theme.of(context).textTheme.labelLarge!.apply(
                                        color: appProvider.currentTheme.onBackgroundColor
                                    ),
                                  ),
                                  Text(
                                    item.memo,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.bodyMedium!.apply(
                                        color: appProvider.currentTheme.onBackgroundColor
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  L10n.of(context).historyLogCardSetLabel(item.set.toString()),
                                  style: Theme.of(context).textTheme.labelLarge!.apply(
                                      color: appProvider.currentTheme.onBackgroundColor
                                  ),
                                ),
                                Text(
                                  formatStringHhMmSs(item.totalMilliSecond),
                                  style: Theme.of(context).textTheme.bodyMedium!.apply(
                                      color: appProvider.currentTheme.onBackgroundColor
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]
                ),
              );
            },
          ),
        );
      },
    );
  }
}