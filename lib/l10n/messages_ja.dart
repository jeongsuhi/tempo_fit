// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ja locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = MessageLookup();

typedef String? MessageIfAbsent(
    String? messageStr, List<Object>? args);

class MessageLookup extends MessageLookupByLibrary {
  @override
  String get localeName => 'ja';

  static m0(number) => "${number}";

  static m1(number) => "${number}個のタイマーを削除";

  static m2(number) => "${number}個のタイマーを選択中";

  static m3(number) => "${number}日";

  static m4(number) => "${number} セット";

  static m5(year, month, dates) => "${year}年${month}\n${dates}日運動しました";

  static m6(number) => "${number} セット";

  static m7(number) => "${number} セット";

  static m8(number) => "総運動時間 ${number}";

  static m9(app) => "アプリをダウンロードしてサービス満喫！\n\nクリックしてアプリストアに行く\n${app}";

  static m10(number) => "${number} セット";

  @override
  final Map<String, dynamic> messages = _notInlinedMessages(_notInlinedMessages);

  static Map<String, dynamic> _notInlinedMessages(_) => {
      'albumEmptyCardLabel': MessageLookupByLibrary.simpleMessage('登録した写真をまとめてみれます'),
    'albumLogCardLabel': m0,
    'alertFailureLaunchApplication': MessageLookupByLibrary.simpleMessage('アプリを起動することができませんでした'),
    'alertInputMissingHistorySet': MessageLookupByLibrary.simpleMessage('セットは1以上の数字を入力してください'),
    'alertInputMissingHistoryTotalTime': MessageLookupByLibrary.simpleMessage('総運動時間を入力してください'),
    'alertInputMissingTimerRestTime': MessageLookupByLibrary.simpleMessage('休憩時間を入力してください'),
    'alertInputMissingTimerWorkoutTime': MessageLookupByLibrary.simpleMessage('運動時間を入力してください'),
    'alertNotAvailableApplication': MessageLookupByLibrary.simpleMessage('利用できるアプリがありません'),
    'announceDeleteTimer': m1,
    'announceSelectedTimer': m2,
    'appName': MessageLookupByLibrary.simpleMessage('テンポフィット'),
    'buttonApply': MessageLookupByLibrary.simpleMessage('適用'),
    'buttonCancel': MessageLookupByLibrary.simpleMessage('キャンセル'),
    'buttonChoosePicture': MessageLookupByLibrary.simpleMessage('ギャラリーから選択'),
    'buttonClose': MessageLookupByLibrary.simpleMessage('閉じる'),
    'buttonContinueTimer': MessageLookupByLibrary.simpleMessage('続ける'),
    'buttonDelete': MessageLookupByLibrary.simpleMessage('削除'),
    'buttonDeleteHistory': MessageLookupByLibrary.simpleMessage('この記録を削除'),
    'buttonDeletePicture': MessageLookupByLibrary.simpleMessage('写真を削除する'),
    'buttonFinishTimer': MessageLookupByLibrary.simpleMessage('終了'),
    'buttonOK': MessageLookupByLibrary.simpleMessage('はい'),
    'buttonPauseTimer': MessageLookupByLibrary.simpleMessage('停止'),
    'buttonSave': MessageLookupByLibrary.simpleMessage('保存'),
    'buttonSaveTimer': MessageLookupByLibrary.simpleMessage('設定を保存'),
    'buttonSelectAllTimer': MessageLookupByLibrary.simpleMessage('すべて'),
    'buttonSelectNextTimer': MessageLookupByLibrary.simpleMessage('次を選ぶ'),
    'buttonStart': MessageLookupByLibrary.simpleMessage('開始'),
    'buttonTakePicture': MessageLookupByLibrary.simpleMessage('写真を撮る'),
    'confirmDeleteTimer': MessageLookupByLibrary.simpleMessage('タイマーを削除しますか？'),
    'confirmFinishTimer': MessageLookupByLibrary.simpleMessage('タイマーを終了しますか？'),
    'emailParameterBody': MessageLookupByLibrary.simpleMessage('（内容を入力してください）\n\n\n\nーーーーーーーーーーーーーーー\nアプリ: テンポフィット\nアプリバージョン： \n端末： \n端末OS version： \nありがとうございます'),
    'emailParameterSubject': MessageLookupByLibrary.simpleMessage('Tempo Fit お問い合わせ'),
    'footerLabelHistory': MessageLookupByLibrary.simpleMessage('履歴'),
    'footerLabelTimer': MessageLookupByLibrary.simpleMessage('タイマー'),
    'historyDateCardLabel': m3,
    'historyEmptyCardLabel': MessageLookupByLibrary.simpleMessage('運動しましょ！'),
    'historyLogCardSetLabel': m4,
    'historyMemoEmptyLabel': MessageLookupByLibrary.simpleMessage('メモはありません'),
    'historyMemoInputHint': MessageLookupByLibrary.simpleMessage('メモを記入できます'),
    'historyMemoInputLabel': MessageLookupByLibrary.simpleMessage('メモ'),
    'historyMonthCardLabel': m5,
    'historyPictureLabel': MessageLookupByLibrary.simpleMessage('写真で記録できます'),
    'historySetInputLabel': MessageLookupByLibrary.simpleMessage('セット'),
    'historySetInputPrefix': MessageLookupByLibrary.simpleMessage(' セット '),
    'historySetLabel': m6,
    'historyTimerLabel': MessageLookupByLibrary.simpleMessage('タイマー情報'),
    'historyTimerRestLabel': MessageLookupByLibrary.simpleMessage('休憩'),
    'historyTimerSetPrefix': m7,
    'historyTimerWorkoutLabel': MessageLookupByLibrary.simpleMessage('運動'),
    'historyTitleInputHint': MessageLookupByLibrary.simpleMessage('この記録にタイトルをつけます'),
    'historyTitleInputLabel': MessageLookupByLibrary.simpleMessage('タイトル'),
    'historyTotalTimeInputHintHour': MessageLookupByLibrary.simpleMessage('h'),
    'historyTotalTimeInputHintMinute': MessageLookupByLibrary.simpleMessage('mm'),
    'historyTotalTimeInputHintSecond': MessageLookupByLibrary.simpleMessage('ss'),
    'historyTotalTimeInputLabel': MessageLookupByLibrary.simpleMessage('総運動時間'),
    'historyTotalTimeInputPrefixHour': MessageLookupByLibrary.simpleMessage(' 時 '),
    'historyTotalTimeInputPrefixMinute': MessageLookupByLibrary.simpleMessage(' 分 '),
    'historyTotalTimeInputPrefixSecond': MessageLookupByLibrary.simpleMessage(' 秒 '),
    'historyTotalTimeLabel': m8,
    'historyTotalTimeLabelHour': MessageLookupByLibrary.simpleMessage('時'),
    'historyTotalTimeLabelMinute': MessageLookupByLibrary.simpleMessage('分'),
    'historyTotalTimeLabelSecond': MessageLookupByLibrary.simpleMessage('秒'),
    'settingsLabelContactUs': MessageLookupByLibrary.simpleMessage('お問い合わせ'),
    'settingsLabelLicense': MessageLookupByLibrary.simpleMessage('ライセンス'),
    'settingsLabelNoCommercials': MessageLookupByLibrary.simpleMessage('3日間広告を見ない'),
    'settingsLabelReviewApp': MessageLookupByLibrary.simpleMessage('アプリを評価'),
    'settingsLabelShareApp': MessageLookupByLibrary.simpleMessage('アプリを共有'),
    'settingsLabelSound': MessageLookupByLibrary.simpleMessage('タイマー音を変更'),
    'settingsLabelThemeColor': MessageLookupByLibrary.simpleMessage('テーマカラーを変更'),
    'settingsLabelVersion': MessageLookupByLibrary.simpleMessage('バージョン'),
    'settingsTitle': MessageLookupByLibrary.simpleMessage('設定'),
    'shareParameterBody': m9,
    'shareParameterSubject': MessageLookupByLibrary.simpleMessage('記録もできる！運動用タイマー　今すぐダウンロード✨'),
    'timerFavoriteTip': MessageLookupByLibrary.simpleMessage('タップして上へ'),
    'timerLabelAct': MessageLookupByLibrary.simpleMessage('WORK'),
    'timerLabelDone': MessageLookupByLibrary.simpleMessage('DONE'),
    'timerLabelReady': MessageLookupByLibrary.simpleMessage('READY'),
    'timerLabelRest': MessageLookupByLibrary.simpleMessage('REST'),
    'timerListBottomSheetTitle': MessageLookupByLibrary.simpleMessage('タップしてスタート'),
    'timerMinuteLabel': MessageLookupByLibrary.simpleMessage('分'),
    'timerPanel0': MessageLookupByLibrary.simpleMessage('＋ボタンでタイマーを設定できます'),
    'timerPanel1': MessageLookupByLibrary.simpleMessage('カードをタップして運動をスタートしましょ！'),
    'timerRestLabel': MessageLookupByLibrary.simpleMessage('  休憩'),
    'timerSavePhotoLabel': MessageLookupByLibrary.simpleMessage('タップで\n写真登録'),
    'timerSecondLabel': MessageLookupByLibrary.simpleMessage('秒'),
    'timerSetLabel': MessageLookupByLibrary.simpleMessage('セット'),
    'timerSetList': MessageLookupByLibrary.simpleMessage('登録したタイマー'),
    'timerSetListEmpty': MessageLookupByLibrary.simpleMessage('よく使うタイマーを登録できます'),
    'timerTileRestLabel': MessageLookupByLibrary.simpleMessage('休憩'),
    'timerTileSetLabel': m10,
    'timerTileWorkoutLabel': MessageLookupByLibrary.simpleMessage('運動'),
    'timerTitleInputHint': MessageLookupByLibrary.simpleMessage('このタイマーのタイトルをつけます'),
    'timerWorkoutLabel': MessageLookupByLibrary.simpleMessage('  運動'),
    'toastApplyComplete': MessageLookupByLibrary.simpleMessage('適用完了'),
    'toastDeleteComplete': MessageLookupByLibrary.simpleMessage('削除完了'),
    'toastSaveComplete': MessageLookupByLibrary.simpleMessage('保存完了'),
    'validCommercials': MessageLookupByLibrary.simpleMessage('既に広告が見えません'),
    'validCommercialsStart': MessageLookupByLibrary.simpleMessage('これから３日間、広告が見えません')
  };
}
