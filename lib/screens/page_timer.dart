import 'dart:async';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tempo_fit/l10n/l10n.dart';
import 'package:tempo_fit/providers/ad_provider.dart';
import 'package:tempo_fit/providers/app_settings_provider.dart';
import 'package:tempo_fit/providers/exercise_log_provider.dart';
import 'package:tempo_fit/providers/timer_provider.dart';
import 'package:tempo_fit/screens/bottomSheets/bottom_sheet_timer_set_list.dart';
import 'package:tempo_fit/screens/dialog/dialog_alert.dart';
import 'package:tempo_fit/screens/dialog/dialog_select_photo.dart';
import 'package:tempo_fit/utils/firebase_analytics.dart';
import 'package:tempo_fit/values/sounds.dart';
import 'package:tempo_fit/values/themes.dart';
import 'package:tempo_fit/typeAdapter/timer_set.dart';
import 'package:provider/provider.dart';
import '../utils/format.dart';

class TimerPage extends StatefulWidget {
  static String pageName = "PG_Timer";
  TimerPage({super.key}) {
    FirebaseAnalyticsService.sendScreenEvent(screenName: pageName);
  }

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> with TickerProviderStateMixin {
  static String pageName = "PG_Timer";

  late TimerProvider _timerProvider;
  late AppSettingsProvider _appProvider;
  late ADProvider _adProvider;
  late TimerSet _currentTimer;

  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  final AudioPlayer _audioPlayer = AudioPlayer(playerId: "TEMPO_FIT_AUDIO");
  final audioContext = AudioContextConfig(duckAudio: true).build();
  var delayTime = const Duration(milliseconds: 300);

  Timer? _timer;
  int _timerMilliseconds = 3000;
  int _countedSet = 0;
  int _countedMilliseconds = 0;

  bool _isOnReady = true; // ready or not. default: true.
  bool? _isOnAct; // act or rest. default: null.
  bool _isOnPause = false; // on or not. default: false.
  bool _isFinished = true; // finished or not. default: false.

  int? _savedLogKey;

  @override
  void initState() {
    super.initState();

    AudioPlayer.global.setAudioContext(audioContext);
    _audioPlayer.onPlayerComplete.listen((_) {
      // 音が完了した時のコールバック
      // 元のボリュームに戻したい
      // todo this is not working
      _audioPlayer.setVolume(1.0);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appProvider = Provider.of<AppSettingsProvider>(context);
    _adProvider = Provider.of<ADProvider>(context);

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    _colorAnimation = ColorTween(
      begin: _appProvider.currentTheme.backgroundColor,
      end: _appProvider.currentTheme.activeColor.withOpacity(0.9),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    _timerProvider = Provider.of<TimerProvider>(context);

    // 更新
    _currentTimer = _timerProvider.current;

    if (_timerProvider.isNewTimerReady) {
      var contextWidth = MediaQuery.of(context).size.width.truncate();
      _adProvider.initTimerBannerAd(
          _appProvider.isActiveNoCommercials, contextWidth);
      startTimer(3000, isOnReady: true);
      playSoundReady();
      _timerProvider.onReady();
    }

    return WillPopScope(
      onWillPop: () async {
        FirebaseAnalyticsService.sendSoftwareButtonEvent();

        if (_timer?.isActive == true) {
          showCancelableDialog(
              context, _appProvider.currentTheme, l10n.confirmFinishTimer, () {
            stopTimer();
            Navigator.of(context).pop();
          });
          return false; // 戻らない
        } else {
          return true; // 戻る
        }
      },
      child: Scaffold(
        body: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Container(
              color: _appProvider.currentTheme.backgroundColor,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _appProvider.isActiveNoCommercials
                            ? const SizedBox()
                            : SafeArea(
                                child: SizedBox(
                                width: _adProvider
                                    .timerScreenBannerAd.size.width
                                    .toDouble(),
                                height: _adProvider
                                    .timerScreenBannerAd.size.height
                                    .toDouble(),
                                child: AdWidget(
                                  ad: _adProvider.timerScreenBannerAd,
                                ),
                              )),
                        _currentTimer.title.isEmpty
                            ? const SizedBox()
                            : Text(
                                _currentTimer.title,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(
                            _currentTimer.set,
                            (index) => _buildBlinkingSet(
                                _appProvider.currentTheme, index),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 64,
                      height: MediaQuery.of(context).size.width - 64,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          _buildBlinkCircle(_appProvider.currentTheme),
                          CircularProgressIndicator(
                            value: (_isOnReady | _isFinished)
                                ? 0.0
                                : (_isOnAct!
                                    ? (1.0 -
                                        (_timerMilliseconds /
                                            _getActMilliseconds()))
                                    : (1.0 -
                                        (_timerMilliseconds /
                                            _getRestMilliseconds()))),
                            valueColor: AlwaysStoppedAnimation(
                                _getProgressColor(_appProvider.currentTheme)),
                            strokeWidth: 8,
                            backgroundColor:
                                _appProvider.currentTheme.baseColor,
                          ),
                          _buildContainer(_appProvider.currentTheme, l10n),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        _buildFirstButton(_appProvider.currentTheme, l10n),
                        const SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          width: 240,
                          height: 60,
                          child: TextButton(
                            onPressed: () {
                              FirebaseAnalyticsService.sendButtonEvent(
                                  buttonName: "finish", screenName: pageName);

                              _isFinished
                                  ? {
                                      Navigator.of(context).pop(),
                                      _timerProvider.reset()
                                    }
                                  : _isOnReady
                                      ? {stopTimer(), _audioPlayer.stop()}
                                      : showCancelableDialog(
                                          context,
                                          _appProvider.currentTheme,
                                          l10n.confirmFinishTimer, () {
                                          stopTimer();
                                          _audioPlayer.stop();
                                          Navigator.of(context).pop();
                                        });
                            },
                            style: ButtonStyle(
                              overlayColor: WidgetStateProperty.all<Color>(
                                  _appProvider
                                      .currentTheme.unrecommendedOverlayColor),
                            ),
                            child: Text(
                              l10n.buttonFinishTimer,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .apply(
                                      color: _appProvider
                                          .currentTheme.onBackgroundColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBlinkingSet(Themes currentTheme, int index) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(2.0, 4.0, 2.0, 4.0),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: Theme.of(context).textTheme.labelLarge!.fontSize! * 2,
            maxWidth: 100.0,
          ),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: (_countedSet > index)
                  ? currentTheme.primaryColor
                  : currentTheme.unrecommendedColor,
              borderRadius: BorderRadius.circular(50),
              boxShadow: _buildBlinkShadow(index),
            ),
            child: Text('${index + 1}',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.apply(color: currentTheme.onPrimaryColor)),
          ),
        ),
      ),
    );
  }

  List<BoxShadow>? _buildBlinkShadow(int index) {
    if (_isOnReady) {
      // 準備中、全部光る
      return [
        BoxShadow(
          color: _colorAnimation.value ?? Colors.transparent,
          spreadRadius: 1,
          blurRadius: 10,
          offset: const Offset(2, 2),
        ),
        BoxShadow(
          color: _colorAnimation.value ?? Colors.transparent,
          spreadRadius: 1,
          blurRadius: 10,
          offset: const Offset(-2, -2),
        )
      ];
    } else if ((_isOnAct == true) & (_countedSet == index)) {
      // 運動中、かつ今のSETのみ光る
      return [
        BoxShadow(
          color: _colorAnimation.value ?? Colors.transparent,
          spreadRadius: 1,
          blurRadius: 10,
          offset: const Offset(2, 2),
        ),
        BoxShadow(
          color: _colorAnimation.value ?? Colors.transparent,
          spreadRadius: 1,
          blurRadius: 10,
          offset: const Offset(-2, -2),
        )
      ];
    } else {
      return null;
    }
  }

  Widget _buildBlinkCircle(Themes currentTheme) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: _isOnReady
            ? [
                BoxShadow(
                  color: _colorAnimation.value ?? Colors.transparent,
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: const Offset(3, 3),
                ),
                BoxShadow(
                  color: _colorAnimation.value ?? Colors.transparent,
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: const Offset(3, -3),
                ),
                BoxShadow(
                  color: _colorAnimation.value ?? Colors.transparent,
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: const Offset(-3, -3),
                  blurStyle: BlurStyle.solid,
                ),
                BoxShadow(
                  color: _colorAnimation.value ?? Colors.transparent,
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: const Offset(-3, 3),
                )
              ]
            : null,
        color: Colors.transparent,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: currentTheme.backgroundColor,
                spreadRadius: 1,
                blurRadius: 12,
                offset: const Offset(3, 3),
              ),
              BoxShadow(
                color: currentTheme.backgroundColor,
                spreadRadius: 1,
                blurRadius: 12,
                offset: const Offset(3, -3),
              ),
              BoxShadow(
                color: currentTheme.backgroundColor,
                spreadRadius: 1,
                blurRadius: 12,
                offset: const Offset(-3, -3),
                blurStyle: BlurStyle.solid,
              ),
              BoxShadow(
                color: currentTheme.backgroundColor,
                spreadRadius: 1,
                blurRadius: 12,
                offset: const Offset(-3, 3),
              )
            ],
            color: currentTheme.backgroundColor,
          ),
        ),
      ),
    );
  }

  Widget _buildContainer(Themes currentTheme, L10n l10n) {
    var logImage = getLogImage();

    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.transparent,
      ),
      child: !_isFinished
          ? Center(
              // 完了以外
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _isOnReady
                        ? l10n.timerLabelReady
                        : (_isOnAct == true)
                            ? l10n.timerLabelAct
                            : (_isOnAct == false)
                                ? l10n.timerLabelRest
                                : l10n.timerLabelDone,
                    style: Theme.of(context).textTheme.displaySmall?.apply(
                          color:
                              _getProgressTextColor(_appProvider.currentTheme),
                        ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(formatStringMmSsXx(_timerMilliseconds),
                      style: Theme.of(context).textTheme.displayLarge!.apply(
                          color: _appProvider.currentTheme.onBackgroundColor)),
                  SizedBox(
                    height: Theme.of(context).textTheme.displaySmall!.fontSize,
                  ),
                ],
              ),
            )
          : (logImage == null)
              ? Center(
                  // 完了：写真なし
                  child: TextButton(
                    onPressed: () {
                      FirebaseAnalyticsService.sendButtonEvent(
                          buttonName: "select photo",
                          screenName: pageName,
                          options: {"savedLogKey": _savedLogKey.toString()});

                      if (_savedLogKey != null) {
                        showSelectPhotoDialog(context, _savedLogKey!, () {
                          notify();
                        });
                      }
                    },
                    style: TextButton.styleFrom(
                      foregroundColor:
                          _appProvider.currentTheme.backgroundOverlayColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          l10n.timerLabelDone,
                          style:
                              Theme.of(context).textTheme.displaySmall?.apply(
                                    color: _getProgressTextColor(
                                        _appProvider.currentTheme),
                                  ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(l10n.timerSavePhotoLabel,
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .apply(
                                    color: _appProvider
                                        .currentTheme.onBackgroundColor)),
                        SizedBox(
                          height: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .fontSize,
                        ),
                      ],
                    ),
                  ),
                )
              : Padding(
                  // 写真あり
                  padding: const EdgeInsets.all(8),
                  child: Material(
                    shape: const CircleBorder(),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: GestureDetector(
                      onTap: () {
                        FirebaseAnalyticsService.sendButtonEvent(
                            buttonName: "select photo",
                            screenName: pageName,
                            options: {"savedLogKey": _savedLogKey.toString()});

                        if (_savedLogKey != null) {
                          showSelectPhotoDialog(context, _savedLogKey!, () {
                            notify();
                          });
                        }
                      },
                      child: logImage,
                    ),
                  ),
                ),
    );
  }

  Image? getLogImage() {
    var key = _savedLogKey;
    if (key == null) return null;

    var path =
        Provider.of<ExerciseLogProvider>(context, listen: false).getImage(key);
    if (path.isEmpty) return null;

    return Image.file(
      File(path),
      fit: BoxFit.cover,
    );
  }

  // 停止、続ける、次を選ぶ
  Widget _buildFirstButton(Themes currentTheme, L10n l10n) {
    return SizedBox(
      width: 240,
      height: 60,
      child: _isFinished
          ? ElevatedButton(
              onPressed: () {
                FirebaseAnalyticsService.sendButtonEvent(
                    buttonName: "next timer", screenName: pageName);

                showTimerList();
              },
              style: ButtonStyle(
                backgroundColor:
                    WidgetStateProperty.all<Color>(currentTheme.primaryColor),
                overlayColor: WidgetStateProperty.all<Color>(
                    currentTheme.primaryOverlayColor),
              ),
              child: Text(
                l10n.buttonSelectNextTimer,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .apply(color: currentTheme.onPrimaryColor),
              ),
            )
          : _isOnPause
              ? ElevatedButton(
                  onPressed: () {
                    FirebaseAnalyticsService.sendButtonEvent(
                        buttonName: "continue", screenName: pageName);

                    resumeTimer();
                    _audioPlayer.resume();
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(
                        currentTheme.primaryColor),
                    overlayColor: WidgetStateProperty.all<Color>(
                        currentTheme.primaryOverlayColor),
                  ),
                  child: Text(
                    l10n.buttonContinueTimer,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .apply(color: currentTheme.onPrimaryColor),
                  ),
                )
              : ElevatedButton(
                  onPressed: () {
                    FirebaseAnalyticsService.sendButtonEvent(
                        buttonName: "pause", screenName: pageName);

                    pauseTimer();
                    _audioPlayer.pause();
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(
                        currentTheme.unrecommendedColor),
                    overlayColor: WidgetStateProperty.all<Color>(
                        currentTheme.unrecommendedOverlayColor),
                  ),
                  child: Text(
                    l10n.buttonPauseTimer,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .apply(color: currentTheme.onUnrecommendedColor),
                  ),
                ),
    );
  }

  Future<void> startTimer(int milliseconds,
      {bool isOnReady = false, bool isOnAct = false}) async {
    setState(() {
      _timerMilliseconds = milliseconds;
      _isOnReady = isOnReady;
      _isOnAct = isOnAct;
      _isOnPause = false;
      _isFinished = false;

      if (_timer?.isActive == true) {
        _timer?.cancel();
      }
    });

    _timer = Timer.periodic(const Duration(milliseconds: 10), (_) {
      if (!_isOnReady) {
        _countedMilliseconds = _countedMilliseconds + 10;
      }

      if (_timerMilliseconds > 0) {
        setState(() {
          _timerMilliseconds = (_timerMilliseconds - 10).toInt();
        });
      } else if ((_timerMilliseconds == 0) &
          (_countedSet < _currentTimer.set)) {
        if (_isOnReady) {
          // Ready 終了
          startTimer(_getActMilliseconds(), isOnAct: true);
          playSoundAct();
        } else if (_isOnAct == true) {
          // Act 終了
          setState(() {
            _countedSet++;
          });

          if (_countedSet == _currentTimer.set) {
            stopTimer();
            playSoundFinish();
          } else {
            startTimer(_getRestMilliseconds(), isOnAct: false);

            if (_currentTimer.set > 3 &&
                (_currentTimer.set / 2).ceil() == _countedSet) {
              playSoundHalf();
            } else {
              playSoundRest();
            }
          }
        } else {
          // Rest 終了
          startTimer(_getActMilliseconds(), isOnAct: true);
          playSoundAct();
        }
      } else {
        stopTimer();
        playSoundFinish();
      }
    });

    _blinkEffect();
  }

  void pauseTimer() {
    if (_timer?.isActive == true) {
      setState(() {
        _timer?.cancel();
        _isOnPause = true;
      });
    }
  }

  void resumeTimer() {
    if (_timer?.isActive == false) {
      startTimer(_timerMilliseconds, isOnReady: _isOnReady, isOnAct: _isOnAct!);
    }
  }

  // 終了
  Future<void> stopTimer() async {
    // 保存を先に。
    var key = Provider.of<ExerciseLogProvider>(context, listen: false)
        .registerLog(_currentTimer, _countedMilliseconds, _countedSet);

    setState(() {
      _timer?.cancel();
      _countedSet = 0;
      _countedMilliseconds = 0;
      _isOnReady = false;
      _isOnAct = null;
      _isOnPause = false;
      _isFinished = true;
      _timerMilliseconds = _getActMilliseconds();
      _savedLogKey = key;
    });

    _controller.stop();
    _controller.reset();
  }

  void notify() {
    setState(() {
      _savedLogKey = _savedLogKey;
    });
  }

  void showTimerList() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return TimerSetListBottomSheet();
      },
    );
  }

  int _getActMilliseconds() => Duration(
          minutes: _currentTimer.actTimeMinute,
          seconds: _currentTimer.actTimeSecond)
      .inMilliseconds;
  int _getRestMilliseconds() => Duration(
          minutes: _currentTimer.restTimeMinute,
          seconds: _currentTimer.restTimeSecond)
      .inMilliseconds;

  Color _getProgressColor(Themes currentTheme) {
    return _isOnReady | _isFinished
        ? Colors.transparent
        : _isOnAct!
            ? currentTheme.activeColor
            : currentTheme.restActiveColor;
  }

  Color _getProgressTextColor(Themes currentTheme) {
    return _isOnReady | _isFinished
        ? currentTheme.onBackgroundColor
        : _isOnAct!
            ? currentTheme.primaryColor
            : currentTheme.restColor;
  }

  Future<void> _blinkEffect() async {
    if (!_isFinished) {
      await _controller.forward();
      await Future.delayed(delayTime);
      await _controller.reverse();
      await Future.delayed(delayTime);

      _blinkEffect();
    }
  }

  void playSoundReady() async {
    await _audioPlayer.play(AssetSource(_appProvider.currentSound.ready),
        ctx: audioContext);
  }

  Future<void> playSoundAct() async {
    await _audioPlayer.play(AssetSource(_appProvider.currentSound.act),
        ctx: audioContext);
  }

  Future<void> playSoundRest() async {
    await _audioPlayer.play(AssetSource(_appProvider.currentSound.rest),
        ctx: audioContext);
  }

  Future<void> playSoundHalf() async {
    if (_appProvider.currentSound == Sound.maleVoiceDeep) {
      await _audioPlayer.play(AssetSource(_appProvider.currentSound.half),
          ctx: audioContext);
    } else {
      await _audioPlayer.play(AssetSource(_appProvider.currentSound.rest),
          ctx: audioContext);
    }
  }

  Future<void> playSoundFinish() async {
    await _audioPlayer.play(AssetSource(_appProvider.currentSound.finish),
        ctx: audioContext);
  }

  @override
  void dispose() {
    _adProvider.timerScreenBannerAd.dispose();
    _timer?.cancel();
    _timer = null;
    _controller.dispose();
    _audioPlayer.dispose();
    _savedLogKey = null;
    super.dispose();
  }
}
