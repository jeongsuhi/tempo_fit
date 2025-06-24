import 'package:flutter/material.dart';
import 'package:tempo_fit/l10n/l10n.dart';
import 'package:tempo_fit/values/themes.dart';
import 'package:tempo_fit/typeAdapter/timer_set.dart';
import 'package:tempo_fit/utils/format.dart';

Widget buildTimerTile(
    Themes currentTheme,
    BuildContext context,
    int otherItemsLength,
    int index,
    List<TimerSet> items,
    Function(TimerSet) onPressed,
    Function(TimerSet) onLongPressed,
    Function(TimerSet) onIconPressed) {
  final l10n = L10n.of(context);

  var itemIndex = index - otherItemsLength;
  var item = items[itemIndex];

  return Padding(
      padding: index == (timerTileItemCount(items, otherItemsLength) - 1)
          ? const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 100.0)
          : const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 4.0),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        tileColor: backgroundColor(item, currentTheme),
        title: Text(
          item.title,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .apply(color: currentTheme.onBackgroundColor),
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 80,
                    child: Text(
                      l10n.timerTileWorkoutLabel,
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .apply(color: currentTheme.onBackgroundColor),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 2.0, 4.0),
                      child: Text(
                        '${item.actTimeMinute}:${twoDigits(item.actTimeSecond)}',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .apply(color: currentTheme.onBackgroundColor),
                      ))
                ]),
            Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 80,
                    child: Text(
                      l10n.timerTileRestLabel,
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .apply(color: currentTheme.onBackgroundColor),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(2.0, 0.0, 0.0, 4.0),
                      child: Text(
                        '${item.restTimeMinute}:${twoDigits(item.restTimeSecond)}',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .apply(color: currentTheme.onBackgroundColor),
                      ))
                ]),
            Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 40,
                    child: Text(
                      '　',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 2.0, 4.0),
                      child: Text(
                        l10n.timerTileSetLabel(item.set.toString()),
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .apply(color: currentTheme.onBackgroundColor),
                      ))
                ])
          ],
        ),
        trailing: IconButton(
          icon: iconColor(item, currentTheme),
          iconSize: 32,
          onPressed: () => {onIconPressed(item)},
        ),
        onTap: () => {onPressed(item)},
        onLongPress: () => {onLongPressed(item)},
      ));
}

Widget buildCheckboxTimerTile(
    Themes currentTheme,
    BuildContext context,
    int otherItemsLength,
    int index,
    List<TimerSet> items,
    List<TimerSet> selectedItems,
    Function(TimerSet, bool) onChanged) {
  final l10n = L10n.of(context);

  var itemIndex = index - otherItemsLength;
  var item = items[itemIndex];

  return Padding(
      padding: index == (timerTileItemCount(items, otherItemsLength) - 1)
          ? const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 100.0)
          : const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 4.0),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        tileColor: backgroundColor(item, currentTheme),
        leading: Checkbox(
          value: selectedItems.contains(item),
          activeColor: currentTheme.activeColor,
          checkColor: currentTheme.onPrimaryColor,
          onChanged: (value) {
            onChanged(item, value!);
          },
        ),
        title: Text(
          item.title,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .apply(color: currentTheme.onBackgroundColor),
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 80,
                    child: Text(
                      l10n.timerTileWorkoutLabel,
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .apply(color: currentTheme.onBackgroundColor),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 2.0, 4.0),
                      child: Text(
                        '${item.actTimeMinute}:${twoDigits(item.actTimeSecond)}',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .apply(color: currentTheme.onBackgroundColor),
                      ))
                ]),
            Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 80,
                    child: Text(
                      l10n.timerTileRestLabel,
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .apply(color: currentTheme.onBackgroundColor),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(2.0, 0.0, 0.0, 4.0),
                      child: Text(
                        '${item.restTimeMinute}:${twoDigits(item.restTimeSecond)}',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .apply(color: currentTheme.onBackgroundColor),
                      ))
                ]),
            Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 40,
                    child: Text(
                      '　',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 2.0, 4.0),
                      child: Text(
                        l10n.timerTileSetLabel(item.set.toString()),
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .apply(color: currentTheme.onBackgroundColor),
                      ))
                ])
          ],
        ),
        onTap: () => {onChanged(item, !item.isFavorite)},
      ));
}

Color backgroundColor(TimerSet item, Themes currentTheme) {
  if (item.isFavorite) {
    return currentTheme.primaryBaseColor;
  } else {
    return currentTheme.baseColor;
  }
}

Icon iconColor(TimerSet item, Themes currentTheme) {
  if (item.isFavorite) {
    return Icon(Icons.local_fire_department, color: currentTheme.primaryColor);
  } else {
    return Icon(Icons.local_fire_department_outlined,
        color: currentTheme.onBaseColor);
  }
}

int timerTileItemCount(List<dynamic> items, int otherItemsLength) {
  if (items.isEmpty) {
    return otherItemsLength + 1;
  } else {
    return (items.length + otherItemsLength);
  }
}
