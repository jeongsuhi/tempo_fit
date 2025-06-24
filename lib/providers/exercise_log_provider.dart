import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tempo_fit/typeAdapter/exercise_log.dart';
import 'package:tempo_fit/typeAdapter/timer_set.dart';
import 'package:tempo_fit/utils/format.dart';

class ExerciseLogProvider extends ChangeNotifier {

  // 内部データ
  late Box<ExerciseLog> _exerciseLogListBox;
  Box get exerciseLogListBox => _exerciseLogListBox;

  // 現在扱っている運動ログ
  ExerciseLog? _current;
  ExerciseLog? get current => _current;

  // 登録している運動ログリスト
  List<ExerciseLog> _items = [];
  List<ExerciseLog> get items => _items;

  // 登録している写真あり運動ログリスト
  List<ExerciseLog> get imageItems => _items
      .where((e) => e.imageUrl.isNotEmpty)
      .toList();

  Map<String, List<String>> _inVisibleList = {};
  Map<String, List<String>> get inVisibleList => _inVisibleList;

  String getDefaultImage(int id) {
    var remind =id.remainder(5);
    var result = (remind == 0) ? "assets/images/no_image_bike_white.png"
        : (remind == 1) ? "assets/images/no_image_pool_white.png"
        : (remind == 2) ? "assets/images/no_image_fitness_white.png"
        : (remind == 3) ? "assets/images/no_image_yoga_white.png"
        : "assets/images/no_image_run_white.png";

    return result;
  }

  void change(String? title, int? set, int? totalMilliSecond, String? imageUrl, String? memo) {
    _current!.title = title ?? _current!.title;
    _current!.set = set ?? _current!.set;
    _current!.totalMilliSecond = totalMilliSecond ?? _current!.totalMilliSecond;
    _current!.imageUrl = imageUrl ?? _current!.imageUrl;
    _current!.memo = memo ?? _current!.memo;

    notifyListeners();
  }

  void selectItem(ExerciseLog item) {
    _current = item.copy();

    notifyListeners();
  }

  void resetCurrentItem() {
    _current = null;

    notifyListeners();
  }

  void changeVisibleLog(String year, String month) {
    if (_inVisibleList.containsKey(year)) {
      var months = _inVisibleList[year]!;
      if (months.contains(month)) {
        // 削除
        months.remove(month);
      } else {
        // 既存キーに追加
        months.add(month);
        _inVisibleList[year] = months;
      }
    } else {
      // キーとvalueを追加
      _inVisibleList.addAll({year : [month]});
    }

    notifyListeners();
  }

  void resetVisibleLog() {
    _inVisibleList = {};

    notifyListeners();
  }

  int? registerLog(TimerSet timer, int countedMilliSeconds, int countedSet) {

    if (countedMilliSeconds == 0) return null;

    // key値を指定
    int newKey = _items.isEmpty ? 0 : (_items.map((e) => e.id).reduce(max) + 1);

    // 内部に保存
    _exerciseLogListBox.put(
        newKey,
        ExerciseLog(
          id: newKey,
          date: formatDateTime(DateTime.now()),
          title: timer.title.isEmpty ? "Quick Start" : timer.title,
          set: countedSet,
          totalMilliSecond: countedMilliSeconds,
          timerActTimeMilliSecond: Duration(minutes: timer.actTimeMinute, seconds: timer.actTimeSecond).inMilliseconds,
          timerRestTimeMilliSecond: Duration(minutes: timer.restTimeMinute, seconds: timer.restTimeSecond).inMilliseconds,
          timerSet: timer.set,
        )
    );

    updateItems();
    notifyListeners();
    return newKey;
  }

  void updateImage(int key, String path) {
    var value = _exerciseLogListBox.get(key);
    if (value == null) return;

    value.imageUrl = path;

    _exerciseLogListBox.put(key, value);

    updateItems();
    notifyListeners();
  }

  String getImage(int key) {
    var value = _exerciseLogListBox.get(key);
    if (value == null) return "";

    return value.imageUrl;
  }

  void editItem() {
    // 内部に保存
    _exerciseLogListBox.put(_current!.id, _current!);

    updateItems();
    notifyListeners();
  }

  void deleteItem() {
    // 内部から削除
    _exerciseLogListBox.delete(_current!.id);
    _current = null;

    updateItems();
    notifyListeners();
  }

  void deleteItems(List<ExerciseLog> items) {
    // 内部から削除
    _exerciseLogListBox.deleteAll(items.map((e) => e.id));

    updateItems();
    notifyListeners();
  }

  void updateItems() {
    // DBから一覧を更新
    var itemBackup = _exerciseLogListBox.values.toList();

    if (itemBackup.length > 1) {
      itemBackup.sort((a, b) {
        int result = parseDateTime(a.date).compareTo(parseDateTime(b.date));
        if (result != 0) return result;
        return a.id.compareTo(b.id);
      });
    }

    _items = itemBackup.reversed.toList();
  }

  Future<void> _init() async {
    _exerciseLogListBox = await Hive.openBox('exerciseLogList');
    updateItems();
    notifyListeners();
  }

  ExerciseLogProvider() {
    _init();
  }
}
