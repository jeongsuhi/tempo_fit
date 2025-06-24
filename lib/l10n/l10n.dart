import 'package:flutter/widgets.dart';
import 'package:tempo_fit/l10n/l10n_delegate.dart';
import 'package:tempo_fit/l10n/messages_all_locales.dart';
import 'package:intl/intl.dart';

/// 言語リソースを扱う
class L10n {

  /// localeは端末設定・アプリの指定を踏まえて最適なものが渡ってくる
  static Future<L10n> load(Locale locale) async {
    final name = locale.countryCode == null || locale.countryCode!.isEmpty
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);

    // 言語リソース読み込み
    await initializeMessages(localeName);
    // デフォルト言語を設定
    Intl.defaultLocale = localeName;
    // 自身を返す
    return L10n();
  }

  // Widgetツリーから自身を取り出す
  static L10n of(BuildContext context) {
    return Localizations.of<L10n>(context, L10n)!;
  }

  static const LocalizationsDelegate<L10n> delegate = L10nDelegate();

  /// template (English)
  /// 追加したらやること
  /// 1. arbファイル(文言リソースのJSONファイル)の作成
  // flutter packages pub run intl_translation:extract_to_arb \
  //     --locale=en \
  //     --output-dir=lib/l10n \
  //     lib/l10n/l10n.dart
  /// 2. 生成された雛形のintl_messages.arbをコピーしてintl_ja.arb, intl_ko.arbを修正
  /// 3. arbファイル群から多言語対応に必要なクラスを生成
  // flutter packages pub run intl_translation:generate_from_arb \
  //     --output-dir=lib/l10n \
  //     --no-use-deferred-loading \
  //     lib/l10n/l10n.dart \
  //     lib/l10n/intl_*.arb
  String get appName => Intl.message('Tempo Fit', name: 'appName',);

  /// Home
  String get footerLabelTimer => Intl.message('Timer', name: 'footerLabelTimer',);
  String get footerLabelHistory => Intl.message('History', name: 'footerLabelHistory',);

  /// Timer
  String get timerLabelReady => Intl.message('READY', name: 'timerLabelReady',);
  String get timerLabelAct => Intl.message('WORK', name: 'timerLabelAct',);
  String get timerLabelRest => Intl.message('REST', name: 'timerLabelRest',);
  String get timerLabelDone => Intl.message('DONE', name: 'timerLabelDone',);
  String get timerPanel0 => Intl.message('Add timer set and Start it!', name:  'timerPanel0',);
  String get timerPanel1 => Intl.message('Click on the card to START work out!', name:  'timerPanel1',);
  String get timerSetList => Intl.message('Your set list', name:  'timerSetList',);
  String get timerSetListEmpty => Intl.message('You can register timers that you always use', name:  'timerSetListEmpty',);
  String get timerFavoriteTip => Intl.message('Tap to be at the top', name:  'timerFavoriteTip',);
  String get timerListBottomSheetTitle => Intl.message('Tap to Start', name: 'timerListBottomSheetTitle',);
  String get timerTileWorkoutLabel => Intl.message('WORKOUT', name: 'timerTileWorkoutLabel',);
  String get timerTileRestLabel => Intl.message('REST', name: 'timerTileRestLabel',);
  String get timerWorkoutLabel => Intl.message('  WORKOUT', name: 'timerWorkoutLabel',);
  String get timerRestLabel => Intl.message('  REST', name: 'timerRestLabel',);
  String get timerSetLabel => Intl.message('SET', name: 'timerSetLabel',);
  String get timerMinuteLabel => Intl.message('min', name: 'timerMinuteLabel',);
  String get timerSecondLabel => Intl.message('sec', name: 'timerSecondLabel',);
  String get timerTitleInputHint => Intl.message("You can set timer's name", name: 'timerTitleInputHint');
  String get timerSavePhotoLabel => Intl.message("Tap &\nRecord", name: 'timerSavePhotoLabel');
  String timerTileSetLabel(String number) => Intl.message('$number SET', name: 'timerTileSetLabel', args: [number],);
  String announceDeleteTimer(String number) => Intl.message('Remove $number timers', name: 'announceDeleteTimer', args: [number],);
  String announceSelectedTimer(String number) => Intl.message('You have selected $number timers', name: 'announceSelectedTimer', args: [number],);

  /// History
  String get historyEmptyCardLabel => Intl.message("You can check your exercise log here. \nLet's work out!", name: 'historyEmptyCardLabel',);
  String get historyTitleInputLabel => Intl.message('Title', name: 'historyTitleInputLabel',);
  String get historyTitleInputHint => Intl.message('Put the title for this log', name: 'historyTitleInputHint',);
  String get historySetInputLabel => Intl.message('SET', name: 'historySetInputLabel',);
  String get historySetInputPrefix => Intl.message(' SET ', name: 'historySetInputPrefix',);
  String get historyTotalTimeInputLabel => Intl.message('TOTAL WORKOUT', name: 'historyTotalTimeInputLabel',);
  String get historyTotalTimeInputHintHour => Intl.message('h', name: 'historyTotalTimeInputHintHour',);
  String get historyTotalTimeInputPrefixHour => Intl.message(' h ', name: 'historyTotalTimeInputPrefixHour',);
  String get historyTotalTimeInputHintMinute => Intl.message('mm', name: 'historyTotalTimeInputHintMinute',);
  String get historyTotalTimeInputPrefixMinute => Intl.message(' m ', name: 'historyTotalTimeInputPrefixMinute',);
  String get historyTotalTimeInputHintSecond => Intl.message('ss', name: 'historyTotalTimeInputHintSecond',);
  String get historyTotalTimeInputPrefixSecond => Intl.message(' s ', name: 'historyTotalTimeInputPrefixSecond',);
  String get historyTotalTimeLabelHour => Intl.message('h', name: 'historyTotalTimeLabelHour',);
  String get historyTotalTimeLabelMinute => Intl.message('min', name: 'historyTotalTimeLabelMinute',);
  String get historyTotalTimeLabelSecond => Intl.message('sec', name: 'historyTotalTimeLabelSecond',);
  String get historyMemoInputLabel => Intl.message('Note', name: 'historyMemoInputLabel',);
  String get historyMemoInputHint => Intl.message('You can write notes', name: 'historyMemoInputHint',);
  String get historyTimerLabel => Intl.message('Timer Settings', name: 'historyTimerLabel',);
  String get historyTimerWorkoutLabel => Intl.message('WORKOUT', name: 'historyTimerWorkoutLabel',);
  String get historyTimerRestLabel => Intl.message('REST', name: 'historyTimerRestLabel',);
  String get historyMemoEmptyLabel => Intl.message('No Notes', name: 'historyMemoEmptyLabel',);
  String get historyPictureLabel => Intl.message("Leave today's success", name: 'historyPictureLabel',);
  String historyMonthCardLabel(String year, String month, String dates) => Intl.message("$month, $year \n$dates days you worked out", name: 'historyMonthCardLabel', args: [year, month, dates],);
  String historyDateCardLabel(String number) => Intl.message('$number', name: 'historyDateCardLabel', args: [number],);
  String historyLogCardSetLabel(String number) => Intl.message('$number SET', name: 'historyLogCardSetLabel', args: [number],);
  String historySetLabel(String number) => Intl.message('$number SET', name: 'historySetLabel', args: [number],);
  String historyTotalTimeLabel(String number) => Intl.message('Total Workout Time $number', name: 'historyTotalTimeLabel', args: [number],);
  String historyTimerSetPrefix(String number) => Intl.message('$number SET', name: 'historyTimerSetPrefix', args: [number],);

  /// album
  String get albumEmptyCardLabel => Intl.message("You can check your workout photos here, \nif you saved your photos. \nLet's work out!", name: 'albumEmptyCardLabel',);
  String albumLogCardLabel(String number) => Intl.message('$number', name: 'albumLogCardLabel', args: [number],);

  /// settings
  String get settingsTitle => Intl.message('Settings', name: 'settingsTitle',);
  String get settingsLabelThemeColor => Intl.message('Change App Color', name: 'settingsLabelThemeColor',);
  String get settingsLabelSound => Intl.message('Change Timer Sound', name: 'settingsLabelSound',);
  String get settingsLabelNoCommercials => Intl.message('NO ADs for 3days', name: 'settingsLabelNoCommercials',);
  String get settingsLabelShareApp => Intl.message('Share this App', name: 'settingsLabelShareApp',);
  String get settingsLabelReviewApp => Intl.message('Review this App', name: 'settingsLabelReviewApp',);
  String get settingsLabelContactUs => Intl.message('Contact Us', name: 'settingsLabelContactUs',);
  String get settingsLabelLicense => Intl.message('License', name: 'settingsLabelLicense',);
  String get settingsLabelVersion => Intl.message('Version', name: 'settingsLabelVersion',);
  String get emailParameterSubject => Intl.message("Tempo Fit Customer Inquiry", name: 'emailParameterSubject',);
  String get emailParameterBody => Intl.message('Please feel free to write your inquiry\n\n\n\n------------\nApplication: Tempo Fit\nApp version: \nYour device Model: \nYour device OS version: \nThanks:)', name: 'emailParameterBody',);
  String get validCommercials => Intl.message('Thank you for watching the ad again for us, but your settings are still valid', name: 'validCommercials',);
  String get validCommercialsStart => Intl.message('From now on, in-app ads will not be displayed for three days', name: 'validCommercialsStart',);
  String get shareParameterSubject => Intl.message('Download Now!', name: 'shareParameterSubject',);
  String shareParameterBody(String app) => Intl.message('Check out this awesome app: $app', name: 'shareParameterBody', args: [app]);

  /// dialog
  String get confirmDeleteTimer => Intl.message('Are you sure you want to delete the timer?', name: 'confirmDeleteTimer',);
  String get confirmFinishTimer => Intl.message('Do you want to end the timer?', name: 'confirmFinishTimer',);
  String get alertInputMissingHistorySet => Intl.message('Please enter SET', name: 'alertInputMissingHistorySet',);
  String get alertInputMissingHistoryTotalTime => Intl.message('Please enter the total workout time', name: 'alertInputMissingHistoryTotalTime',);
  String get alertInputMissingTimerWorkoutTime => Intl.message('Please enter the workout time', name: 'alertInputMissingTimerWorkoutTime',);
  String get alertInputMissingTimerRestTime => Intl.message('Please enter the rest time', name: 'alertInputMissingTimerRestTime',);
  String get alertFailureLaunchApplication => Intl.message('Failed to launch application', name: 'alertFailureLaunchApplication',);
  String get alertNotAvailableApplication => Intl.message('No applications available to launch', name: 'alertNotAvailableApplication',);

  /// button
  String get buttonOK => Intl.message('OK', name: 'buttonOK',);
  String get buttonApply => Intl.message('APPLY', name: 'buttonApply',);
  String get buttonClose => Intl.message('CLOSE', name: 'buttonClose',);
  String get buttonCancel => Intl.message('CANCEL', name: 'buttonCancel',);
  String get buttonSave => Intl.message('SAVE', name: 'buttonSave',);
  String get buttonStart => Intl.message('START', name: 'buttonStart',);
  String get buttonDelete => Intl.message('DELETE', name: 'buttonDelete',);
  String get buttonSaveTimer => Intl.message('SAVE SETTING', name: 'buttonSaveTimer',);
  String get buttonFinishTimer => Intl.message('FINISH', name: 'buttonFinishTimer',);
  String get buttonSelectNextTimer => Intl.message('SELECT NEXT', name: 'buttonSelectNextTimer',);
  String get buttonPauseTimer => Intl.message('PAUSE', name: 'buttonPauseTimer',);
  String get buttonContinueTimer => Intl.message('CONTINUE', name: 'buttonContinueTimer',);
  String get buttonSelectAllTimer => Intl.message('Select ALL', name: 'buttonSelectAllTimer',);
  String get buttonDeleteHistory => Intl.message('Delete this log', name: 'buttonDeleteHistory',);
  String get buttonChoosePicture => Intl.message('Choose a picture', name: 'buttonChoosePicture',);
  String get buttonTakePicture => Intl.message('Take a picture', name: 'buttonTakePicture',);
  String get buttonDeletePicture => Intl.message('Delete a picture', name: 'buttonDeletePicture',);

  /// toast
  String get toastDeleteComplete => Intl.message('Delete complete', name: 'toastDeleteComplete',);
  String get toastSaveComplete => Intl.message('Save complete', name: 'toastSaveComplete',);
  String get toastApplyComplete => Intl.message('Apply complete', name: 'toastApplyComplete',);
}