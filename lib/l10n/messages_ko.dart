// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ko locale. All the
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
  String get localeName => 'ko';

  static m0(number) => "${number}";

  static m1(number) => "${number}개의 타이머를 삭제";

  static m2(number) => "${number}개의 타이머를 선택했어요";

  static m3(number) => "${number}일";

  static m4(number) => "${number} 세트";

  static m5(year, month, dates) => "${year}년 ${month} \n${dates}일 운동했어요";

  static m6(number) => "${number} 세트";

  static m7(number) => "${number} 세트";

  static m8(number) => "총 운동 시간 ${number}";

  static m9(app) => "앱을 다운로드하여 당신의 건강을 관리하세요!\n\n클릭하여 앱 스토어로 이동:\n${app}";

  static m10(number) => "${number} 세트";

  @override
  final Map<String, dynamic> messages = _notInlinedMessages(_notInlinedMessages);

  static Map<String, dynamic> _notInlinedMessages(_) => {
      'albumEmptyCardLabel': MessageLookupByLibrary.simpleMessage('등록한 사진을 확인할 수 있어요'),
    'albumLogCardLabel': m0,
    'alertFailureLaunchApplication': MessageLookupByLibrary.simpleMessage('앱을 시작할 수 없어요'),
    'alertInputMissingHistorySet': MessageLookupByLibrary.simpleMessage('세트에 1이상의 숫자를 입력하세요'),
    'alertInputMissingHistoryTotalTime': MessageLookupByLibrary.simpleMessage('총 운동 시간을 입력하세요'),
    'alertInputMissingTimerRestTime': MessageLookupByLibrary.simpleMessage('휴식 시간을 입력하세요'),
    'alertInputMissingTimerWorkoutTime': MessageLookupByLibrary.simpleMessage('운동 시간을 입력하세요'),
    'alertNotAvailableApplication': MessageLookupByLibrary.simpleMessage('사용할 수 있는 앱이 없어요'),
    'announceDeleteTimer': m1,
    'announceSelectedTimer': m2,
    'appName': MessageLookupByLibrary.simpleMessage('템포핏'),
    'buttonApply': MessageLookupByLibrary.simpleMessage('적용'),
    'buttonCancel': MessageLookupByLibrary.simpleMessage('취소'),
    'buttonChoosePicture': MessageLookupByLibrary.simpleMessage('갤러리에서 사진 선택'),
    'buttonClose': MessageLookupByLibrary.simpleMessage('닫기'),
    'buttonContinueTimer': MessageLookupByLibrary.simpleMessage('계속'),
    'buttonDelete': MessageLookupByLibrary.simpleMessage('삭제'),
    'buttonDeleteHistory': MessageLookupByLibrary.simpleMessage('이 기록을 삭제'),
    'buttonDeletePicture': MessageLookupByLibrary.simpleMessage('현재 사진을 삭제'),
    'buttonFinishTimer': MessageLookupByLibrary.simpleMessage('끝내기'),
    'buttonOK': MessageLookupByLibrary.simpleMessage('네'),
    'buttonPauseTimer': MessageLookupByLibrary.simpleMessage('정지'),
    'buttonSave': MessageLookupByLibrary.simpleMessage('저장'),
    'buttonSaveTimer': MessageLookupByLibrary.simpleMessage('설정을 저장'),
    'buttonSelectAllTimer': MessageLookupByLibrary.simpleMessage('모두 선택'),
    'buttonSelectNextTimer': MessageLookupByLibrary.simpleMessage('다음 타이머로'),
    'buttonStart': MessageLookupByLibrary.simpleMessage('시작'),
    'buttonTakePicture': MessageLookupByLibrary.simpleMessage('사진을 촬영'),
    'confirmDeleteTimer': MessageLookupByLibrary.simpleMessage('타이머를 삭제하시겠어요?'),
    'confirmFinishTimer': MessageLookupByLibrary.simpleMessage('타이머를 종료하시겠어요?'),
    'emailParameterBody': MessageLookupByLibrary.simpleMessage('(문의 사항을 입력해주세요)\n\n\n\n------------\n앱: 템포핏\n앱 버전: \n단말기 모델: \n단말기 OS version: \n감사합니다.'),
    'emailParameterSubject': MessageLookupByLibrary.simpleMessage('템포핏 문의'),
    'footerLabelHistory': MessageLookupByLibrary.simpleMessage('이력'),
    'footerLabelTimer': MessageLookupByLibrary.simpleMessage('타이머'),
    'historyDateCardLabel': m3,
    'historyEmptyCardLabel': MessageLookupByLibrary.simpleMessage('운동하세요!'),
    'historyLogCardSetLabel': m4,
    'historyMemoEmptyLabel': MessageLookupByLibrary.simpleMessage('메모 없음'),
    'historyMemoInputHint': MessageLookupByLibrary.simpleMessage('이 기록에 메모를 남길 수 있어요'),
    'historyMemoInputLabel': MessageLookupByLibrary.simpleMessage('메모'),
    'historyMonthCardLabel': m5,
    'historyPictureLabel': MessageLookupByLibrary.simpleMessage('사진을 기록할 수 있어요'),
    'historySetInputLabel': MessageLookupByLibrary.simpleMessage('세트'),
    'historySetInputPrefix': MessageLookupByLibrary.simpleMessage(' 세트 '),
    'historySetLabel': m6,
    'historyTimerLabel': MessageLookupByLibrary.simpleMessage('타이머 정보'),
    'historyTimerRestLabel': MessageLookupByLibrary.simpleMessage('휴식'),
    'historyTimerSetPrefix': m7,
    'historyTimerWorkoutLabel': MessageLookupByLibrary.simpleMessage('운동'),
    'historyTitleInputHint': MessageLookupByLibrary.simpleMessage('이 기록의 이름을 쓰세요'),
    'historyTitleInputLabel': MessageLookupByLibrary.simpleMessage('이름'),
    'historyTotalTimeInputHintHour': MessageLookupByLibrary.simpleMessage('h'),
    'historyTotalTimeInputHintMinute': MessageLookupByLibrary.simpleMessage('mm'),
    'historyTotalTimeInputHintSecond': MessageLookupByLibrary.simpleMessage('ss'),
    'historyTotalTimeInputLabel': MessageLookupByLibrary.simpleMessage('총 운동 시간'),
    'historyTotalTimeInputPrefixHour': MessageLookupByLibrary.simpleMessage(' 시 '),
    'historyTotalTimeInputPrefixMinute': MessageLookupByLibrary.simpleMessage(' 분 '),
    'historyTotalTimeInputPrefixSecond': MessageLookupByLibrary.simpleMessage(' 초 '),
    'historyTotalTimeLabel': m8,
    'historyTotalTimeLabelHour': MessageLookupByLibrary.simpleMessage('시'),
    'historyTotalTimeLabelMinute': MessageLookupByLibrary.simpleMessage('분'),
    'historyTotalTimeLabelSecond': MessageLookupByLibrary.simpleMessage('초'),
    'settingsLabelContactUs': MessageLookupByLibrary.simpleMessage('문의하기'),
    'settingsLabelLicense': MessageLookupByLibrary.simpleMessage('라이센스'),
    'settingsLabelNoCommercials': MessageLookupByLibrary.simpleMessage('3일간 광고끄기'),
    'settingsLabelReviewApp': MessageLookupByLibrary.simpleMessage('앱을 평가하기'),
    'settingsLabelShareApp': MessageLookupByLibrary.simpleMessage('앱을 공유하기'),
    'settingsLabelSound': MessageLookupByLibrary.simpleMessage('타이머 소리 변경'),
    'settingsLabelThemeColor': MessageLookupByLibrary.simpleMessage('테마 컬러 변경'),
    'settingsLabelVersion': MessageLookupByLibrary.simpleMessage('버전'),
    'settingsTitle': MessageLookupByLibrary.simpleMessage('설정'),
    'shareParameterBody': m9,
    'shareParameterSubject': MessageLookupByLibrary.simpleMessage('템포핏으로 운동하고 기록하고! 지금 다운로드하세요 ^^'),
    'timerFavoriteTip': MessageLookupByLibrary.simpleMessage('탭해서 맨 위로'),
    'timerLabelAct': MessageLookupByLibrary.simpleMessage('WORK'),
    'timerLabelDone': MessageLookupByLibrary.simpleMessage('DONE'),
    'timerLabelReady': MessageLookupByLibrary.simpleMessage('READY'),
    'timerLabelRest': MessageLookupByLibrary.simpleMessage('REST'),
    'timerListBottomSheetTitle': MessageLookupByLibrary.simpleMessage('탭해서 바로 시작'),
    'timerMinuteLabel': MessageLookupByLibrary.simpleMessage('분'),
    'timerPanel0': MessageLookupByLibrary.simpleMessage('+ 버튼으로 타이머를 설정할 수 있어요'),
    'timerPanel1': MessageLookupByLibrary.simpleMessage('카드를 탭하여 운동을 시작하세요!'),
    'timerRestLabel': MessageLookupByLibrary.simpleMessage('  휴식'),
    'timerSavePhotoLabel': MessageLookupByLibrary.simpleMessage('탭하고\n사진등록'),
    'timerSecondLabel': MessageLookupByLibrary.simpleMessage('초'),
    'timerSetLabel': MessageLookupByLibrary.simpleMessage('세트'),
    'timerSetList': MessageLookupByLibrary.simpleMessage('등록한 타이머'),
    'timerSetListEmpty': MessageLookupByLibrary.simpleMessage('자주 사용하는 타이머를 저장하세요'),
    'timerTileRestLabel': MessageLookupByLibrary.simpleMessage('휴식'),
    'timerTileSetLabel': m10,
    'timerTileWorkoutLabel': MessageLookupByLibrary.simpleMessage('운동'),
    'timerTitleInputHint': MessageLookupByLibrary.simpleMessage('이 타이머의 이름을 쓰세요'),
    'timerWorkoutLabel': MessageLookupByLibrary.simpleMessage('  운동'),
    'toastApplyComplete': MessageLookupByLibrary.simpleMessage('적용 완료'),
    'toastDeleteComplete': MessageLookupByLibrary.simpleMessage('삭제 완료'),
    'toastSaveComplete': MessageLookupByLibrary.simpleMessage('저장 완료'),
    'validCommercials': MessageLookupByLibrary.simpleMessage('이미 광고가 보이지 않습니다'),
    'validCommercialsStart': MessageLookupByLibrary.simpleMessage('지금부터 3일간 광고가 보이지 않습니다')
  };
}
