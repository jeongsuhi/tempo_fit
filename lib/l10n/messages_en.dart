// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static m0(number) => "${number}";

  static m1(number) => "Remove ${number} timers";

  static m2(number) => "You have selected ${number} timers";

  static m3(number) => "${number}";

  static m4(number) => "${number} SET";

  static m5(year, month, dates) => "${month}, ${year} \n${dates} days you worked out";

  static m6(number) => "${number} SET";

  static m7(number) => "${number} SET";

  static m8(number) => "Total Workout Time ${number}";

  static m9(app) => "Check out this awesome app: ${app}";

  static m10(number) => "${number} SET";

  @override
  final Map<String, dynamic> messages = _notInlinedMessages(_notInlinedMessages);

  static Map<String, dynamic> _notInlinedMessages(_) => {
      'albumEmptyCardLabel': MessageLookupByLibrary.simpleMessage('You can check your workout photos here, \nif you saved your photos. \nLet\'s work out!'),
    'albumLogCardLabel': m0,
    'alertFailureLaunchApplication': MessageLookupByLibrary.simpleMessage('Failed to launch application'),
    'alertInputMissingHistorySet': MessageLookupByLibrary.simpleMessage('Please enter SET'),
    'alertInputMissingHistoryTotalTime': MessageLookupByLibrary.simpleMessage('Please enter the total workout time'),
    'alertInputMissingTimerRestTime': MessageLookupByLibrary.simpleMessage('Please enter the rest time'),
    'alertInputMissingTimerWorkoutTime': MessageLookupByLibrary.simpleMessage('Please enter the workout time'),
    'alertNotAvailableApplication': MessageLookupByLibrary.simpleMessage('No applications available to launch'),
    'announceDeleteTimer': m1,
    'announceSelectedTimer': m2,
    'appName': MessageLookupByLibrary.simpleMessage('Tempo Fit'),
    'buttonApply': MessageLookupByLibrary.simpleMessage('APPLY'),
    'buttonCancel': MessageLookupByLibrary.simpleMessage('CANCEL'),
    'buttonChoosePicture': MessageLookupByLibrary.simpleMessage('Choose a picture'),
    'buttonClose': MessageLookupByLibrary.simpleMessage('CLOSE'),
    'buttonContinueTimer': MessageLookupByLibrary.simpleMessage('CONTINUE'),
    'buttonDelete': MessageLookupByLibrary.simpleMessage('DELETE'),
    'buttonDeleteHistory': MessageLookupByLibrary.simpleMessage('Delete this log'),
    'buttonDeletePicture': MessageLookupByLibrary.simpleMessage('Delete a picture'),
    'buttonFinishTimer': MessageLookupByLibrary.simpleMessage('FINISH'),
    'buttonOK': MessageLookupByLibrary.simpleMessage('OK'),
    'buttonPauseTimer': MessageLookupByLibrary.simpleMessage('PAUSE'),
    'buttonSave': MessageLookupByLibrary.simpleMessage('SAVE'),
    'buttonSaveTimer': MessageLookupByLibrary.simpleMessage('SAVE SETTING'),
    'buttonSelectAllTimer': MessageLookupByLibrary.simpleMessage('Select ALL'),
    'buttonSelectNextTimer': MessageLookupByLibrary.simpleMessage('SELECT NEXT'),
    'buttonStart': MessageLookupByLibrary.simpleMessage('START'),
    'buttonTakePicture': MessageLookupByLibrary.simpleMessage('Take a picture'),
    'confirmDeleteTimer': MessageLookupByLibrary.simpleMessage('Are you sure you want to delete the timer?'),
    'confirmFinishTimer': MessageLookupByLibrary.simpleMessage('Do you want to end the timer?'),
    'emailParameterBody': MessageLookupByLibrary.simpleMessage('Please feel free to write your inquiry\n\n\n\n------------\nApplication: Tempo Fit\nApp version: \nYour device Model: \nYour device OS version: \nThanks:)'),
    'emailParameterSubject': MessageLookupByLibrary.simpleMessage('Tempo Fit Customer Inquiry'),
    'footerLabelHistory': MessageLookupByLibrary.simpleMessage('History'),
    'footerLabelTimer': MessageLookupByLibrary.simpleMessage('Timer'),
    'historyDateCardLabel': m3,
    'historyEmptyCardLabel': MessageLookupByLibrary.simpleMessage('You can check your exercise log here. \nLet\'s work out!'),
    'historyLogCardSetLabel': m4,
    'historyMemoEmptyLabel': MessageLookupByLibrary.simpleMessage('No Notes'),
    'historyMemoInputHint': MessageLookupByLibrary.simpleMessage('You can write notes'),
    'historyMemoInputLabel': MessageLookupByLibrary.simpleMessage('Note'),
    'historyMonthCardLabel': m5,
    'historyPictureLabel': MessageLookupByLibrary.simpleMessage('Leave today\'s success'),
    'historySetInputLabel': MessageLookupByLibrary.simpleMessage('SET'),
    'historySetInputPrefix': MessageLookupByLibrary.simpleMessage(' SET '),
    'historySetLabel': m6,
    'historyTimerLabel': MessageLookupByLibrary.simpleMessage('Timer Settings'),
    'historyTimerRestLabel': MessageLookupByLibrary.simpleMessage('REST'),
    'historyTimerSetPrefix': m7,
    'historyTimerWorkoutLabel': MessageLookupByLibrary.simpleMessage('WORKOUT'),
    'historyTitleInputHint': MessageLookupByLibrary.simpleMessage('Put the title for this log'),
    'historyTitleInputLabel': MessageLookupByLibrary.simpleMessage('Title'),
    'historyTotalTimeInputHintHour': MessageLookupByLibrary.simpleMessage('h'),
    'historyTotalTimeInputHintMinute': MessageLookupByLibrary.simpleMessage('mm'),
    'historyTotalTimeInputHintSecond': MessageLookupByLibrary.simpleMessage('ss'),
    'historyTotalTimeInputLabel': MessageLookupByLibrary.simpleMessage('TOTAL WORKOUT'),
    'historyTotalTimeInputPrefixHour': MessageLookupByLibrary.simpleMessage(' h '),
    'historyTotalTimeInputPrefixMinute': MessageLookupByLibrary.simpleMessage(' m '),
    'historyTotalTimeInputPrefixSecond': MessageLookupByLibrary.simpleMessage(' s '),
    'historyTotalTimeLabel': m8,
    'historyTotalTimeLabelHour': MessageLookupByLibrary.simpleMessage('h'),
    'historyTotalTimeLabelMinute': MessageLookupByLibrary.simpleMessage('min'),
    'historyTotalTimeLabelSecond': MessageLookupByLibrary.simpleMessage('sec'),
    'settingsLabelContactUs': MessageLookupByLibrary.simpleMessage('Contact Us'),
    'settingsLabelLicense': MessageLookupByLibrary.simpleMessage('License'),
    'settingsLabelNoCommercials': MessageLookupByLibrary.simpleMessage('NO ADs for 3days'),
    'settingsLabelReviewApp': MessageLookupByLibrary.simpleMessage('Review this App'),
    'settingsLabelShareApp': MessageLookupByLibrary.simpleMessage('Share this App'),
    'settingsLabelSound': MessageLookupByLibrary.simpleMessage('Change Timer Sound'),
    'settingsLabelThemeColor': MessageLookupByLibrary.simpleMessage('Change App Color'),
    'settingsLabelVersion': MessageLookupByLibrary.simpleMessage('Version'),
    'settingsTitle': MessageLookupByLibrary.simpleMessage('Settings'),
    'shareParameterBody': m9,
    'shareParameterSubject': MessageLookupByLibrary.simpleMessage('Download Now!'),
    'timerFavoriteTip': MessageLookupByLibrary.simpleMessage('Tap to be at the top'),
    'timerLabelAct': MessageLookupByLibrary.simpleMessage('WORK'),
    'timerLabelDone': MessageLookupByLibrary.simpleMessage('DONE'),
    'timerLabelReady': MessageLookupByLibrary.simpleMessage('READY'),
    'timerLabelRest': MessageLookupByLibrary.simpleMessage('REST'),
    'timerListBottomSheetTitle': MessageLookupByLibrary.simpleMessage('Tap to Start'),
    'timerMinuteLabel': MessageLookupByLibrary.simpleMessage('min'),
    'timerPanel0': MessageLookupByLibrary.simpleMessage('Add timer set and Start it!'),
    'timerPanel1': MessageLookupByLibrary.simpleMessage('Click on the card to START work out!'),
    'timerRestLabel': MessageLookupByLibrary.simpleMessage('  REST'),
    'timerSavePhotoLabel': MessageLookupByLibrary.simpleMessage('Tap &\nRecord'),
    'timerSecondLabel': MessageLookupByLibrary.simpleMessage('sec'),
    'timerSetLabel': MessageLookupByLibrary.simpleMessage('SET'),
    'timerSetList': MessageLookupByLibrary.simpleMessage('Your set list'),
    'timerSetListEmpty': MessageLookupByLibrary.simpleMessage('You can register timers that you always use'),
    'timerTileRestLabel': MessageLookupByLibrary.simpleMessage('REST'),
    'timerTileSetLabel': m10,
    'timerTileWorkoutLabel': MessageLookupByLibrary.simpleMessage('WORKOUT'),
    'timerTitleInputHint': MessageLookupByLibrary.simpleMessage('You can set timer\'s name'),
    'timerWorkoutLabel': MessageLookupByLibrary.simpleMessage('  WORKOUT'),
    'toastApplyComplete': MessageLookupByLibrary.simpleMessage('Apply complete'),
    'toastDeleteComplete': MessageLookupByLibrary.simpleMessage('Delete complete'),
    'toastSaveComplete': MessageLookupByLibrary.simpleMessage('Save complete'),
    'validCommercials': MessageLookupByLibrary.simpleMessage('Thank you for watching the ad again for us, but your settings are still valid'),
    'validCommercialsStart': MessageLookupByLibrary.simpleMessage('From now on, in-app ads will not be displayed for three days')
  };
}
