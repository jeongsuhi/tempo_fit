import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tempo_fit/l10n/l10n.dart';
import 'package:tempo_fit/providers/app_settings_provider.dart';
import 'package:tempo_fit/providers/exercise_log_provider.dart';
import 'package:provider/provider.dart';
import 'package:tempo_fit/screens/page_image_log.dart';
import 'package:tempo_fit/typeAdapter/exercise_log.dart';
import 'package:tempo_fit/utils/firebase_analytics.dart';
import 'package:collection/collection.dart';
import 'package:tempo_fit/utils/format.dart';
import 'package:tempo_fit/utils/navigator.dart';
import 'package:tempo_fit/values/themes.dart';

class ExerciseAlbumListPage extends StatelessWidget {
  static String pageName = "PG_ExerciseAlbumList";
  ExerciseAlbumListPage({super.key}) {
    FirebaseAnalyticsService.sendScreenEvent(screenName: pageName);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer2<AppSettingsProvider, ExerciseLogProvider>(
        builder: (context, appProvider, provider, child) {

          List<dynamic> groupByMonth(List<ExerciseLog> items) {

            var results = [];

            // Map<year, List<year'sLog>>
            var yearGroup = items.groupListsBy((obj) => parseDateTime(obj.date).year.toString());
            yearGroup.forEach((year, yearValues) {

              // Map<month, List<month'sLog>>
              var monthGroup = yearValues.groupListsBy((obj) => formatStringMmmm(parseDateTime(obj.date)));
              monthGroup.forEach((month, monthValues) {

                monthValues.sort((a, b) {
                  int result = parseDateTime(a.date).compareTo(parseDateTime(b.date));
                  if (result != 0) return result;
                  return a.id.compareTo(b.id);
                });

                List<ImageLogCard> logCards = [];
                String? before;
                for (var value in monthValues.reversed) {
                  var now = parseDateTime(value.date).day.toString();

                  if (now == before) {
                    // 日付が変わってなければ、日付なし
                    logCards.add(ImageLogCard(label: null, log: value));
                  } else {
                    // 日付が変わったら、日付あり
                    logCards.add(ImageLogCard(label: L10n.of(context).albumLogCardLabel(now.toString()), log: value));
                  }

                  before = now;
                }

                results.add(MonthCard(
                  label: "$month $year" ,
                  logs: logCards,
                ));
              });
            });

            return results;
          }

          List<Widget> buildImageLogs(List<ImageLogCard> cards) {
            return cards.map((card) =>
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 4, 0, 6),
                child: Container(
                  width: MediaQuery.of(context).size.width / 3.5,
                  color: appProvider.currentTheme.backgroundColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 日付
                      Text(
                        card.label ?? "",
                        style: Theme.of(context).textTheme.titleMedium!.apply(
                            color: appProvider.currentTheme.onBackgroundColor
                        ),
                      ),
                      // 写真
                      GestureDetector(
                        onTap: () {
                          FirebaseAnalyticsService.sendButtonEvent(buttonName: "image", screenName: pageName);

                          navigateZoomInTransparent(context, ImageLogPage(logKey: card.log.id));
                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width / 3.5,
                            height: MediaQuery.of(context).size.width / 3.5,
                            color: appProvider.currentTheme.primaryAccentBaseColor,
                            child: Image.file(
                              File(card.log.imageUrl),
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                            )
                        ),
                      ),
                      // タイトル
                      Text(
                        card.log.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleLarge!.apply(
                            color: appProvider.currentTheme.onBackgroundColor
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ).toList();
          }

          List<dynamic> items = (provider.imageItems.isEmpty) ? List.of([
            EmptyCard(message: L10n.of(context).albumEmptyCardLabel),
          ]) : groupByMonth(provider.imageItems);

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              var item = items[index];

              if (item.runtimeType == EmptyCard) {
                item as EmptyCard;
                return Padding(
                    padding: const EdgeInsets.fromLTRB(8, 24, 8, 24),
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        item.message,
                        style: Theme.of(context).textTheme.titleLarge!.apply(
                            color: appProvider.currentTheme.onBackgroundColor
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ));
              } else if (item.runtimeType == MonthCard) {
                item as MonthCard;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(4, 6, 0, 0),
                      child: Text(
                        item.label,
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodyLarge!.apply(
                            color: appProvider.currentTheme.onBackgroundColor
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                      children: buildImageLogs(item.logs),
                      ),
                    )
                  ],
                );

              } else {
                return null;
              }
            },
          );
        },
      ),
    );
  }
}

class MonthCard {
  final String label;
  final List<ImageLogCard> logs;

  MonthCard({
    required this.label,
    required this.logs,
  });
}

class ImageLogCard {
  String? label;
  final ExerciseLog log;

  ImageLogCard({
    this.label,
    required this.log,
  });
}

class EmptyCard {
  final String message;

  EmptyCard({
    required this.message,
  });
}