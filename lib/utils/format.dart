import 'package:intl/intl.dart';
import 'regexp.dart';

String twoDigits(int number) {
  return number.toString().padLeft(2, '0');
}
String threeDigits(int number) {
  return number.toString().padLeft(3, '0');
}

String formatStringMmSsXx(int value) {
  Duration duration = Duration(milliseconds: value);

  var minutes = twoDigits(duration.inMinutes.remainder(60));
  var seconds = twoDigits(duration.inSeconds.remainder(60));
  var milliSeconds = threeDigits(duration.inMilliseconds.remainder(1000)).substring(0, 2);

  // mm:ss.xx
  return '$minutes:$seconds.$milliSeconds';
}

String formatStringMmSs(int value) {
  Duration duration = Duration(milliseconds: value);

  var minutes = twoDigits(duration.inMinutes.remainder(60));
  var seconds = twoDigits(duration.inSeconds.remainder(60));

  // mm:ss
  return '$minutes:$seconds';
}

String formatStringHhMmSs(int value) {
  Duration duration = Duration(milliseconds: value);

  var hours = twoDigits(duration.inHours.remainder(24));
  var minutes = twoDigits(duration.inMinutes.remainder(60));
  var seconds = twoDigits(duration.inSeconds.remainder(60));

  // hh:mm:ss
  return '$hours:$minutes:$seconds';
}

String formatStringHourMinuteSecond(int value, String hourLabel, String minuteLabel, String secondLabel) {
  Duration duration = Duration(milliseconds: value);

  var hours = twoDigits(duration.inHours.remainder(24));
  var minutes = twoDigits(duration.inMinutes.remainder(60));
  var seconds = twoDigits(duration.inSeconds.remainder(60));

  hours = (hours == "00") ? "" : "$hours$hourLabel ";
  minutes = (hours.isEmpty && minutes == "00") ? "" : "$minutes$minuteLabel ";

  // hh時 mm分 ss秒
  return '$hours$minutes$seconds$secondLabel';
}

String formatStringHh(int value) {
  Duration duration = Duration(milliseconds: value);
  // hh:mm:ss 中 hh
  return twoDigits(duration.inHours.remainder(24));
}

String formatStringMm(int value) {
  Duration duration = Duration(milliseconds: value);
  // hh:mm:ss 中 mm
  return twoDigits(duration.inMinutes.remainder(60));
}

String formatStringSs(int value) {
  Duration duration = Duration(milliseconds: value);
  // hh:mm:ss 中 ss
  return twoDigits(duration.inSeconds.remainder(60));
}

String formatDateTime(DateTime dateTime) {
  return DateFormat('yyyy/MM/dd HH:mm:ss').format(dateTime);
}

DateTime parseDateTime(String dateTimeString) {
  return DateFormat('yyyy/MM/dd HH:mm:ss').parse(dateTimeString);
}

String formatStringMmmm(DateTime date) {
  return DateFormat.MMMM().format(date);
}

int? extractNumbersToInt(String value) {
  var extractNumbers = value.replaceAll(notNumber(), '');
  return extractNumbers.isEmpty ? null : int.parse(extractNumbers);
}