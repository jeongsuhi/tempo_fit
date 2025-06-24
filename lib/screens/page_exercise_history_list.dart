import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tempo_fit/l10n/l10n.dart';
import 'package:tempo_fit/providers/app_settings_provider.dart';
import 'package:tempo_fit/providers/exercise_log_provider.dart';
import 'package:tempo_fit/screens/bottomSheets/bottom_sheet_exercise_log.dart';
import 'package:tempo_fit/typeAdapter/exercise_log.dart';
import 'package:tempo_fit/utils/firebase_analytics.dart';
import 'package:tempo_fit/values/themes.dart';
import 'package:tempo_fit/utils/format.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class ExerciseHistoryListPage extends StatelessWidget {
  static String pageName = "PG_ExerciseHistoryList";
  ExerciseHistoryListPage({super.key}) {
    FirebaseAnalyticsService.sendScreenEvent(screenName: pageName);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer2<AppSettingsProvider, ExerciseLogProvider>(
        builder: (context, appProvider, provider, child) {

          List<dynamic> groupByMonth(List<ExerciseLog> items, Map<String, List<String>> inVisibleLogs) {

            var results = [];

            // Map<year, List<year'sLog>>
            var yearGroup = items.groupListsBy((obj) => parseDateTime(obj.date).year.toString());

            yearGroup.forEach((year, yearValues) {
              // Map<month, List<month'sLog>>
              var monthGroup = yearValues.groupListsBy((obj) => formatStringMmmm(parseDateTime(obj.date)));

              monthGroup.forEach((month, monthValues) {
                // Map<day, List<day'sLog>>
                var dayGroup = monthValues.groupListsBy((obj) => parseDateTime(obj.date).day);
                // 年月ラベルを追加
                results.add(MonthCard(year: year.toString(), month: month, exerciseCount: dayGroup.keys.length.toString()));

                if (inVisibleLogs.containsKey(year) && (inVisibleLogs[year]?.contains(month) ?? false)) {
                  // 日付ラベルと履歴カードを追加しない
                } else {
                  dayGroup.forEach((day, dayValues) {
                    // 日付ラベルを追加
                    results.add(DateCard(label: L10n.of(context).historyDateCardLabel(day.toString())));
                    // 履歴カード達を追加
                    results.addAll(dayValues.mapIndexed((index, log) =>
                        LogCard(
                            log: log,
                            isFirst: index == 0,
                            isLast: (index == dayValues.length -1))
                    ));
                  });
                }

              });
            });

            return results;
          }

          List<dynamic> items = (provider.items.isEmpty) ?
            List.of([
              EmptyCard(message: L10n.of(context).historyEmptyCardLabel),
            ])
          : groupByMonth(provider.items, provider.inVisibleList);


          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              var item = items[index];

              if (item.runtimeType == EmptyCard) {
                item as EmptyCard;
                return Container(
                  alignment: Alignment.center,
                  height: 160,
                  child: Text(
                    item.message,
                    style: Theme.of(context).textTheme.titleLarge!.apply(
                        color: appProvider.currentTheme.onBackgroundColor
                    ),
                    textAlign: TextAlign.center,
                  ),
                );

              } else if (item.runtimeType == MonthCard) {
                item as MonthCard;
                return InkWell(
                  onTap: () {
                    provider.changeVisibleLog(item.year, item.month);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 80,
                    color: appProvider.currentTheme.primaryColor,
                    child: Text(
                      L10n.of(context).historyMonthCardLabel(item.year, item.month, item.exerciseCount),
                      style: Theme.of(context).textTheme.titleLarge!.apply(
                          color: appProvider.currentTheme.onPrimaryColor
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );

              } else if (item.runtimeType == DateCard) {
                item as DateCard;
                return Container(
                  alignment: Alignment.centerLeft,
                  height: 32,
                  color: appProvider.currentTheme.baseColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      item.label,
                      style: Theme.of(context).textTheme.labelMedium!.apply(
                          color: appProvider.currentTheme.onBaseColor
                      ),
                    ),
                  ),
                );

              } else if (item.runtimeType == LogCard) {
                item as LogCard;
                return InkWell(
                  onTap: () {
                    FirebaseAnalyticsService.sendButtonEvent(
                        buttonName: "LogCard",
                        screenName: pageName,
                        options: { "id" : "${item.log.id}" });

                    provider.selectItem(item.log);

                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return ExerciseLogBottomSheet();
                      },
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    color: appProvider.currentTheme.backgroundColor,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(8, (item.isFirst ? 8.0 : 4.0), 8, (item.isLast ? 8.0 : 4.0)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Container(
                              width: 60,
                              height: 60,
                              color: appProvider.currentTheme.primaryAccentBaseColor,
                              child: item.log.imageUrl.isEmpty ? Image.asset(
                                provider.getDefaultImage(item.log.id),
                                fit: BoxFit.cover,
                              ) : Image.file(
                                File(item.log.imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    (item).log.title,
                                    style: Theme.of(context).textTheme.labelMedium!.apply(
                                        color: appProvider.currentTheme.onBaseColor
                                    ),
                                  ),
                                  Text(
                                    (item).log.memo,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.bodyMedium!.apply(
                                        color: appProvider.currentTheme.onBaseColor
                                    ),
                                  ),
                                ],
                              ),
                            ),),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                L10n.of(context).historyLogCardSetLabel(item.log.set.toString()),
                                style: Theme.of(context).textTheme.labelMedium!.apply(
                                  color: appProvider.currentTheme.onBaseColor
                                ),
                              ),
                              Text(
                                formatStringHhMmSs((item).log.totalMilliSecond),
                                style: Theme.of(context).textTheme.bodyMedium!.apply(
                                    color: appProvider.currentTheme.onBaseColor
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return null;
              }
            }
          );
        },
      ),
    );
  }
}

class MonthCard {
  final String year;
  final String month;
  final String exerciseCount;

  MonthCard({
    required this.year,
    required this.month,
    required this.exerciseCount,
  });
}

class DateCard {
  final String label;

  DateCard({
    required this.label,
  });
}

class LogCard {
  final ExerciseLog log;
  final bool isFirst;
  final bool isLast;

  LogCard({
    required this.log,
    required this.isFirst,
    required this.isLast,
  });
}

class EmptyCard {
  final String message;

  EmptyCard({
    required this.message,
  });
}