import 'package:flutter/material.dart';
import 'package:tempo_fit/l10n/l10n.dart';
import 'package:tempo_fit/values/themes.dart';
import 'package:tempo_fit/typeAdapter/timer_set.dart';
import 'package:tempo_fit/utils/decoration.dart';
import 'package:numberpicker/numberpicker.dart';

Widget buildTimerPickers(
    Themes currentTheme,
    BuildContext context,
    TimerSet current,
    Function(String? title, int? set, int? actTimeMinute, int? actTimeSecond, int? restTimeMinute, int? restTimeSecond) onChange
) {
  final l10n = L10n.of(context);

  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: TextFormField(
          initialValue: current.title,
          keyboardType: TextInputType.text,
          decoration: decorationUnderline(currentTheme, hint: l10n.timerTitleInputHint),
          style: TextStyle(
            color: currentTheme.onBackgroundColor
          ),
          maxLines: 1,
          maxLength: 24,
          onChanged: (value) {
            onChange(value, null, null, null, null, null);
          },
        ),
      ),
      const SizedBox(
        height: 8,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.timerWorkoutLabel,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodySmall?.apply(
                    color: currentTheme.primaryColor
                ),
              ),
              Row(
                  children: [
                    NumberPicker(
                      value: current.actTimeMinute,
                      minValue: 00,
                      maxValue: 59,
                      itemWidth: _widthOnFontSize(context),
                      itemHeight: _heightOnFontSize(context),
                      zeroPad: true,
                      itemCount: 3,
                      textStyle: Theme.of(context).textTheme.bodyMedium?.apply(
                          color: currentTheme.primaryColor
                      ),
                      selectedTextStyle: Theme.of(context).textTheme.headlineSmall?.apply(
                          color: currentTheme.primaryColor
                      ),
                      onChanged: (value) {
                        onChange(null, null, value, null, null, null);
                      },
                    ),
                    Text(
                      l10n.timerMinuteLabel,
                      style: Theme.of(context).textTheme.bodyMedium?.apply(
                          color: currentTheme.primaryColor
                      ),
                    ),
                    NumberPicker(
                      value: current.actTimeSecond,
                      minValue: 00,
                      maxValue: 59,
                      infiniteLoop: true,
                      itemWidth: _widthOnFontSize(context),
                      itemHeight: _heightOnFontSize(context),
                      zeroPad: true,
                      itemCount: 3,
                      textStyle: Theme.of(context).textTheme.bodyMedium?.apply(
                          color: currentTheme.primaryColor
                      ),
                      selectedTextStyle: Theme.of(context).textTheme.headlineSmall?.apply(
                          color: currentTheme.primaryColor
                      ),
                      onChanged: (value) {
                        onChange(null, null, null, value, null, null);
                      },
                    ),
                    Text(
                      l10n.timerSecondLabel,
                      style: Theme.of(context).textTheme.bodyMedium?.apply(
                          color: currentTheme.primaryColor
                      ),
                    )
                  ]
              )
            ],
          ),
          const SizedBox(
            width: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.timerRestLabel,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodySmall?.apply(
                    color: currentTheme.restColor
                ),
              ),
              Row(
                  children: [
                    NumberPicker(
                      value: current.restTimeMinute,
                      minValue: 00,
                      maxValue: 59,
                      itemWidth: _widthOnFontSize(context),
                      itemHeight: _heightOnFontSize(context),
                      zeroPad: true,
                      itemCount: 3,
                      textStyle: Theme.of(context).textTheme.bodyMedium?.apply(
                          color: currentTheme.restColor
                      ),
                      selectedTextStyle: Theme.of(context).textTheme.headlineSmall?.apply(
                          color: currentTheme.restColor
                      ),
                      onChanged: (value) {
                        onChange(null, null, null, null, value, null);
                      },
                    ),
                    Text(
                      l10n.timerMinuteLabel,
                      style: Theme.of(context).textTheme.bodyMedium?.apply(
                          color: currentTheme.restColor
                      ),
                    ),
                    NumberPicker(
                      value: current.restTimeSecond,
                      minValue: 00,
                      maxValue: 59,
                      infiniteLoop: true,
                      itemWidth: _widthOnFontSize(context),
                      itemHeight: _heightOnFontSize(context),
                      zeroPad: true,
                      itemCount: 3,
                      textStyle: Theme.of(context).textTheme.bodyMedium?.apply(
                          color: currentTheme.restColor
                      ),
                      selectedTextStyle: Theme.of(context).textTheme.headlineSmall?.apply(
                          color: currentTheme.restColor
                      ),
                      onChanged: (value) {
                        onChange(null, null, null, null, null, value);
                      },
                    ),
                    Text(
                      l10n.timerSecondLabel,
                      style: Theme.of(context).textTheme.bodyMedium?.apply(
                          color: currentTheme.restColor
                      ),
                    )
                  ]
              )
            ],
          ),
          const SizedBox(
            width: 8,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                l10n.timerSetLabel,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodySmall?.apply(
                    color: currentTheme.onBackgroundColor
                ),
              ),
              NumberPicker(
                value: current.set,
                minValue: 1,
                maxValue: 99,
                itemWidth: _widthOnFontSize(context),
                itemHeight: _heightOnFontSize(context),
                itemCount: 3,
                textStyle: Theme.of(context).textTheme.bodyMedium?.apply(
                    color: currentTheme.onBackgroundColor
                ),
                selectedTextStyle: Theme.of(context).textTheme.headlineSmall?.apply(
                    color: currentTheme.onBackgroundColor
                ),
                onChanged: (value) {
                  onChange(null, value, null, null, null, null);
                },
              ),
            ],
          ),
        ],
      ),

    ],
  );
}

double _heightOnFontSize(context) {
  return (Theme.of(context).textTheme.headlineSmall!.fontSize!) * 1.4;
}
double _widthOnFontSize(context) {
  return (Theme.of(context).textTheme.headlineSmall!.fontSize!) * 1.8;
}