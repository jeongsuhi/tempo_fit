import 'package:flutter/material.dart';
import 'package:tempo_fit/l10n/l10n.dart';
import 'package:tempo_fit/utils/firebase_analytics.dart';
import 'package:tempo_fit/values/themes.dart';

Future<void> showOkDialog(BuildContext context, Themes currentTheme, String content, {String title = ""}) async {
  String dialogName = "DA_Ok";

  FirebaseAnalyticsService.sendDialogEvent(dialogName: dialogName);

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: title.isEmpty ? null : Text(title,
          style: Theme.of(context).textTheme.bodyLarge!.apply(
            color: currentTheme.onBackgroundColor,
          ),
        ),
        content: Text("\n$content",
          style: Theme.of(context).textTheme.bodyMedium!.apply(
            color: currentTheme.onBackgroundColor,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              FirebaseAnalyticsService.sendButtonEvent(buttonName: "ok", screenName: dialogName);

              Navigator.of(context).pop();
            },
            child: Text(
              L10n.of(context).buttonOK,
              style: Theme.of(context).textTheme.labelLarge!.apply(
                color: currentTheme.primaryColor,
              ),
            ),
          ),
        ],
      );
    },
  );
}

Future<void> showCancelableDialog(BuildContext context, Themes currentTheme, String content, VoidCallback onOkPressed, {String title = ""}) async {
  String dialogName = "DA_Cancelable";

  FirebaseAnalyticsService.sendDialogEvent(dialogName: dialogName);

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: title.isEmpty ? null : Text(title),
        content: Text("\n$content",
          style: Theme.of(context).textTheme.bodyMedium!.apply(
            color: currentTheme.onBackgroundColor,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              FirebaseAnalyticsService.sendButtonEvent(buttonName: "ok", screenName: dialogName);

              Navigator.of(context).pop();
              onOkPressed();
            },
            child: Text(
              L10n.of(context).buttonOK,
              style: Theme.of(context).textTheme.labelLarge!.apply(
                color: currentTheme.primaryColor,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              FirebaseAnalyticsService.sendButtonEvent(buttonName: "cancel", screenName: dialogName);

              Navigator.of(context).pop();
            },
            child: Text(
              L10n.of(context).buttonCancel,
              style: Theme.of(context).textTheme.labelLarge!.apply(
                color: currentTheme.onBackgroundColor,
              ),
            ),
          ),
        ],
      );
    },
  );
}