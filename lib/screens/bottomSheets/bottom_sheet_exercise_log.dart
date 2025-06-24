import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tempo_fit/l10n/l10n.dart';
import 'package:tempo_fit/providers/app_settings_provider.dart';
import 'package:tempo_fit/providers/exercise_log_provider.dart';
import 'package:tempo_fit/screens/dialog/dialog_alert.dart';
import 'package:tempo_fit/screens/dialog/dialog_select_photo.dart';
import 'package:tempo_fit/screens/toast.dart';
import 'package:tempo_fit/typeAdapter/exercise_log.dart';
import 'package:tempo_fit/utils/firebase_analytics.dart';
import 'package:tempo_fit/values/themes.dart';
import 'package:tempo_fit/utils/decoration.dart';
import 'package:tempo_fit/utils/format.dart';
import 'package:tempo_fit/utils/regexp.dart';
import 'package:provider/provider.dart';

class ExerciseLogBottomSheet extends StatelessWidget {
  static String sheetName = "ST_ExerciseLog";

  ExerciseLogBottomSheet({super.key}) {
    FirebaseAnalyticsService.sendBottomSheetEvent(sheetName: sheetName);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ExerciseLogProvider>(context);
    final appProvider = Provider.of<AppSettingsProvider>(context);
    final l10n = L10n.of(context);

    var item = provider.current!;

    var hh = formatStringHh(item.totalMilliSecond);
    var mm = formatStringMm(item.totalMilliSecond);
    var ss = formatStringSs(item.totalMilliSecond);

    int convertMilliseconds() {
      return Duration(
          hours: hh.isEmpty ? 0 : int.parse(hh),
          minutes: mm.isEmpty ? 0 : int.parse(mm),
          seconds: ss.isEmpty ? 0 : int.parse(ss)
      ).inMilliseconds;
    }

    bool verifyLog(ExerciseLog data) {
      bool result = true;

      if (data.set == 0) {
        // 運動時間を入力してください
        result = false;
        showOkDialog(context, appProvider.currentTheme, l10n.alertInputMissingHistorySet);
      }
      if (data.totalMilliSecond == 0) {
        // 休憩時間を入力してください
        result = false;
        showOkDialog(context, appProvider.currentTheme, l10n.alertInputMissingHistoryTotalTime);
      }

      return result;
    }

    Widget buildEditableContent() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    FirebaseAnalyticsService.sendButtonEvent(buttonName: "close", screenName: sheetName);

                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.close, size: Theme.of(context).textTheme.displaySmall!.fontSize, color: appProvider.currentTheme.onBackgroundColor)
              ),
              Text(
                item.date,
                maxLines: 1,
                style: Theme.of(context).textTheme.titleMedium?.apply(
                    color: appProvider.currentTheme.onBackgroundColor
                ),
              ),
              IconButton(
                  onPressed: () {
                    FirebaseAnalyticsService.sendButtonEvent(buttonName: "save", screenName: sheetName);

                    if (verifyLog(item)) {
                      provider.editItem();
                      showToast(l10n.toastSaveComplete);
                      Navigator.of(context).pop();
                    }
                  },
                  icon: Icon(Icons.save, size: Theme.of(context).textTheme.displaySmall!.fontSize, color: appProvider.currentTheme.onBackgroundColor)
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  fit: StackFit.loose,
                  clipBehavior: Clip.none,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 3,
                        height: MediaQuery.of(context).size.width / 3,
                        color: appProvider.currentTheme.primaryAccentBaseColor,
                        child: item.imageUrl.isEmpty ? Image.asset(
                          provider.getDefaultImage(item.id),
                          fit: BoxFit.cover,
                        ) : Image.file(
                          File(item.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      right: MediaQuery.of(context).size.width / 3 - 32,
                      bottom: 8,
                      child: Container(
                        decoration: BoxDecoration(
                          color: appProvider.currentTheme.backgroundOverlayColor,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: IconButton(
                          onPressed: () => {
                            FirebaseAnalyticsService.sendButtonEvent(
                              buttonName: "selectPhoto", screenName: sheetName
                            ),

                            showSelectPhotoDialog(context, item.id, () {
                              // 更新
                              provider.change(null, null, null, provider.getImage(item.id), null);
                            }),
                          },
                          icon: Icon(
                            Icons.camera_alt,
                            color: appProvider.currentTheme.onBackgroundColor,
                            size: Theme.of(context).textTheme.displaySmall!.fontSize,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Column(
              children: [
                TextFormField(
                  initialValue: item.title,
                  keyboardType: TextInputType.text,
                  maxLength: 24,
                  maxLines: 1,
                  decoration: decorationUnderline(
                      appProvider.currentTheme,
                      label: l10n.historyTitleInputLabel,
                      hint: l10n.historyTitleInputHint),
                  style: TextStyle(
                      color: appProvider.currentTheme.onBackgroundColor
                  ),
                  onChanged: (value) {
                    provider.change(value, null, null, null, null);
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        l10n.historySetInputLabel,
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodyLarge!.apply(
                            color: appProvider.currentTheme.onBackgroundColor,
                        ),
                      ),
                      Expanded(child:Container()),
                      SizedBox(
                        width: 40,
                        child: TextFormField(
                          initialValue: item.set.toString(),
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(2),
                            FilteringTextInputFormatter.allow(onlyNumber()),
                          ],
                          decoration: decorationFilled(appProvider.currentTheme),
                          style: TextStyle(
                              color: appProvider.currentTheme.onBackgroundColor
                          ),
                          onChanged: (value) {
                            var edited = extractNumbersToInt(value);
                            provider.change(null, edited ?? 0, null, null, null);
                          },
                        ),
                      ),
                      Text(
                        l10n.historySetInputPrefix,
                        style: Theme.of(context).textTheme.bodyMedium!.apply(
                          color: appProvider.currentTheme.onBackgroundColor,
                        ),
                      ),
                    ]
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      l10n.historyTotalTimeInputLabel,
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.bodyLarge!.apply(
                          color: appProvider.currentTheme.onBackgroundColor
                      ),
                    ),
                    Expanded(child:Container()),
                    SizedBox(
                      width: 40,
                      child: TextFormField(
                        initialValue: hh.toString(),
                        keyboardType: TextInputType.number,
                        maxLines: 1,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(2),
                          FilteringTextInputFormatter.allow(onlyNumber()),
                        ],
                        decoration: decorationFilled(
                            appProvider.currentTheme,
                            hint: l10n.historyTotalTimeInputHintHour),
                        style: TextStyle(
                            color: appProvider.currentTheme.onBackgroundColor
                        ),
                        onChanged: (value) {
                          hh = value;
                          provider.change(null, null, convertMilliseconds(), null, null);
                        },
                      ),
                    ),
                    Text(
                      l10n.historyTotalTimeInputPrefixHour,
                      style: Theme.of(context).textTheme.bodyMedium!.apply(
                        color: appProvider.currentTheme.onBackgroundColor,
                      ),
                    ),
                    SizedBox(
                      width: 40,
                      child: TextFormField(
                        initialValue: mm.toString(),
                        keyboardType: TextInputType.number,
                        maxLines: 1,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(2),
                          FilteringTextInputFormatter.allow(under60()),
                        ],
                        decoration: decorationFilled(
                            appProvider.currentTheme,
                            hint: l10n.historyTotalTimeInputHintMinute),
                        style: TextStyle(
                            color: appProvider.currentTheme.onBackgroundColor
                        ),
                        onChanged: (value) {
                          mm = value;
                          provider.change(null, null, convertMilliseconds(), null, null);
                        },
                      ),
                    ),
                    Text(
                      l10n.historyTotalTimeInputPrefixMinute,
                      style: Theme.of(context).textTheme.bodyMedium!.apply(
                        color: appProvider.currentTheme.onBackgroundColor,
                      ),
                    ),
                    SizedBox(
                      width: 40,
                      child: TextFormField(
                        initialValue: ss.toString(),
                        keyboardType: TextInputType.number,
                        maxLines: 1,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(2),
                          FilteringTextInputFormatter.allow(under60()),
                        ],
                        decoration: decorationFilled(
                          appProvider.currentTheme,
                          hint: l10n.historyTotalTimeInputHintSecond,),
                        style: TextStyle(
                            color: appProvider.currentTheme.onBackgroundColor
                        ),
                        onChanged: (value) {
                          ss = value;
                          provider.change(null, null, convertMilliseconds(), null, null);
                        },
                      ),
                    ),
                    Text(
                      l10n.historyTotalTimeInputPrefixSecond,
                      style: Theme.of(context).textTheme.bodyMedium!.apply(
                        color: appProvider.currentTheme.onBackgroundColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  initialValue: item.memo.toString(),
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  maxLength: 154,
                  decoration: decorationOutline(
                      appProvider.currentTheme,
                      label: l10n.historyMemoInputLabel,
                      hint: l10n.historyMemoInputHint),
                  style: TextStyle(
                      color: appProvider.currentTheme.onBackgroundColor
                  ),
                  onChanged: (value) {
                    provider.change(null, null, null, null, value);
                  },
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            color: appProvider.currentTheme.baseColor,
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  l10n.historyTimerLabel,
                  style: Theme.of(context).textTheme.bodyMedium!.apply(
                    color: appProvider.currentTheme.onBaseColor,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 80,
                            child: Text(
                              l10n.historyTimerWorkoutLabel,
                              style: Theme.of(context).textTheme.labelSmall!.apply(
                                color: appProvider.currentTheme.onBaseColor,
                              ),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 2.0, 4.0),
                              child: Text(
                                formatStringMmSs(item.timerActTimeMilliSecond),
                                style: Theme.of(context).textTheme.titleLarge!.apply(
                                  color: appProvider.currentTheme.onBaseColor,
                                ),
                              )
                          )
                        ]
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 80,
                            child: Text(
                              l10n.historyTimerRestLabel,
                              style: Theme.of(context).textTheme.labelSmall!.apply(
                                color: appProvider.currentTheme.onBaseColor,
                              ),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(2.0, 0.0, 0.0, 4.0),
                              child: Text(
                                formatStringMmSs(item.timerRestTimeMilliSecond),
                                style: Theme.of(context).textTheme.titleLarge!.apply(
                                  color: appProvider.currentTheme.onBaseColor,
                                ),
                              )
                          )
                        ]
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 40,
                            child: Text(
                              '　',
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ),

                          Padding(
                              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 2.0, 4.0),
                              child: Text(
                                l10n.historyTimerSetPrefix(item.timerSet.toString()),
                                style: Theme.of(context).textTheme.titleLarge!.apply(
                                  color: appProvider.currentTheme.onBaseColor,
                                ),
                              )
                          )
                        ]
                    )
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          SizedBox(
            width: 240,
            height: 40,
            child: TextButton(
              onPressed: () => {
                FirebaseAnalyticsService.sendButtonEvent(buttonName: "delete", screenName: sheetName),

                provider.deleteItem(),
                showToast(l10n.toastDeleteComplete),
                Navigator.pop(context),
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(appProvider.currentTheme.backgroundColor),
                overlayColor: MaterialStateProperty.all<Color>(appProvider.currentTheme.primaryBaseColor),
              ),
              child: Text(
                l10n.buttonDeleteHistory,
                style: Theme.of(context).textTheme.titleMedium!.apply(
                    color: appProvider.currentTheme.primaryColor
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
        ],
      );
    }

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.9,
      builder: (BuildContext context, ScrollController scrollController) {

        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              // keyboard inset
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: buildEditableContent(),
          ),
        );
      },
    );
  }
}

