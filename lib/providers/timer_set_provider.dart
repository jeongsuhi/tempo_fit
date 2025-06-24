import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tempo_fit/typeAdapter/timer_set.dart';

class TimerSetProvider extends ChangeNotifier {

  // 内部データ
  late Box<TimerSet> _timerSetListBox;
  Box get timerSetListBox => _timerSetListBox;

  // 現在扱っているタイマー
  TimerSet _current = TimerSet();
  TimerSet get current => _current;

  // 登録しているタイマーリスト
  List<TimerSet> _items = [];
  List<TimerSet> get items => _items;

  // 削除モードかどうか
  bool _isDeleteMode = false;
  bool get isDeleteMode => _isDeleteMode;

  // すべてを選択したか
  bool _isSelectedAll = false;
  bool get isSelectedAll => _isSelectedAll;

  // 選択中のタイマーリスト
  List<TimerSet> _selectedItems = [];
  List<TimerSet> get selectedItems => _selectedItems;

  void change({String? title, int? set, int? actTimeMinute, int? actTimeSecond, int? restTimeMinute, int? restTimeSecond, bool? isFavorite}) {
    _current.title = title ?? _current.title;
    _current.set = set ?? _current.set;
    _current.actTimeMinute = actTimeMinute ?? _current.actTimeMinute;
    _current.actTimeSecond = actTimeSecond ?? _current.actTimeSecond;
    _current.restTimeMinute = restTimeMinute ?? _current.restTimeMinute;
    _current.restTimeSecond = restTimeSecond ?? _current.restTimeSecond;
    _current.isFavorite = isFavorite ?? _current.isFavorite;

    notifyListeners();
  }

  void selectItem(TimerSet item) {
    _current = item.copy();

    notifyListeners();
  }

  void resetCurrentItem() {
    _current = TimerSet();

    notifyListeners();
  }

  void registerItem() {
    // key値を指定
    int newKey = _items.isEmpty ? 0 : (_items.map((e) => e.id).reduce(max) + 1).toInt();

    var newItem = TimerSet(
        id: newKey,
        title: _current.title.isEmpty ? "Quick Start" : _current.title.toString(),
        set: _current.set.toInt(),
        actTimeMinute: _current.actTimeMinute.toInt(),
        actTimeSecond: _current.actTimeSecond.toInt(),
        restTimeMinute: _current.restTimeMinute.toInt(),
        restTimeSecond: _current.restTimeSecond.toInt(),
        isFavorite: _current.isFavorite ? true : false,
        line: 0);

    // 登録済みデータの並び順を更新
    var edits = _timerSetListBox.values
        .where((e) => e.isFavorite == false)
        .map((e) => TimerSet(
        id: e.id,
        title: e.title,
        set: e.set,
        actTimeMinute: e.actTimeMinute,
        actTimeSecond: e.actTimeSecond,
        restTimeMinute: e.restTimeMinute,
        restTimeSecond: e.restTimeSecond,
        isFavorite: e.isFavorite,
        line: (e.line! + 1)))
        .toList();

    edits.add(newItem);

    // 内部に上書き保存
    _timerSetListBox.putAll(
        Map.fromIterables(edits.map((e) => e.id), edits));

    // provider状態更新
    updateItems();
    _current = TimerSet();
    notifyListeners();
  }

  void editFavorite(int id, bool isFavorite) {
    // 対象を探す
    TimerSet originItem = _items.firstWhere((element) => element.id == id);

    var item = TimerSet(
        id: originItem.id,
        title: originItem.title,
        set: originItem.set,
        actTimeMinute: originItem.actTimeMinute,
        actTimeSecond: originItem.actTimeSecond,
        restTimeMinute: originItem.restTimeMinute,
        restTimeSecond: originItem.restTimeSecond,
        isFavorite: isFavorite,
        line: 0);

    // 登録済みデータの並び順を更新
    var edits = _timerSetListBox.values
        .where((e) => e.isFavorite == isFavorite)
        .map((e) => TimerSet(
            id: e.id,
            title: e.title,
            set: e.set,
            actTimeMinute: e.actTimeMinute,
            actTimeSecond: e.actTimeSecond,
            restTimeMinute: e.restTimeMinute,
            restTimeSecond: e.restTimeSecond,
            isFavorite: e.isFavorite,
            line: (e.line! + 1)))
        .toList();

    edits.add(item);

    // 内部に上書き保存
    _timerSetListBox.putAll(
        Map.fromIterables(edits.map((e) => e.id), edits));

    // provider状態更新
    updateItems();
    notifyListeners();
  }

  void updateCurrentItem() {
    // 対象を探す
    TimerSet originItem = _items.firstWhere((element) => element.id == _current.id);

    if (originItem.isFavorite == _current.isFavorite) {
      // 内部に保存
      _timerSetListBox.put(_current.id, _current);

    } else {
      _current.line = 0;

      // 登録済みデータの並び順を更新
      var edits = _timerSetListBox.values
          .where((e) => e.isFavorite == _current.isFavorite)
          .map((e) => TimerSet(
          id: e.id,
          title: e.title,
          set: e.set,
          actTimeMinute: e.actTimeMinute,
          actTimeSecond: e.actTimeSecond,
          restTimeMinute: e.restTimeMinute,
          restTimeSecond: e.restTimeSecond,
          isFavorite: e.isFavorite,
          line: (e.line! + 1)))
          .toList();

      edits.add(_current);

      // 内部に上書き保存
      _timerSetListBox.putAll(
          Map.fromIterables(edits.map((e) => e.id), edits));
    }

    // provider状態更新
    updateItems();
    _current = TimerSet();
    notifyListeners();
  }

  void deleteItems() {

    // 内部から削除
    _timerSetListBox.deleteAll(selectedItems.map((e) => e.id));

    // provider状態更新
    _isSelectedAll = false;
    _selectedItems = [];
    updateItems();
    notifyListeners();
  }

  void deleteItem() {

    // 内部から削除
    _timerSetListBox.delete(current.id);

    // provider状態更新
    updateItems();
    _current = TimerSet();
    notifyListeners();
  }

  void updateItems() {
    // DBから一覧を更新
    var itemBackup = _timerSetListBox.values.toList();

    if (itemBackup.length > 1) {
      itemBackup.sort((a, b) {
        int result = toInt(a.isFavorite).compareTo(toInt(b.isFavorite));
        if (result != 0) return result;
        return a.line?.compareTo(b.line!) ?? -1;
      });
    }

    _items = itemBackup;
  }

  void changeMode() {
    _isDeleteMode = !_isDeleteMode;
    _selectedItems = [];
    _isSelectedAll = false;
    notifyListeners();
  }

  void changeSelectAll(bool allSelected) {
    _isSelectedAll = allSelected;
    _selectedItems = allSelected ? _items : [];
    notifyListeners();
  }

  void selectedItem(TimerSet set, bool isSelected) {
    if (isSelected) {
      selectedItems.add(set);
    } else {
      selectedItems.remove(set);
    }
    _isSelectedAll = selectedItems.length == items.length;
    notifyListeners();
  }

  bool isSelected(TimerSet set) => selectedItems.contains(set);

  int toInt(bool value) {
    return value ? 0 : 1;
  }

  Future<void> _init() async {
    _timerSetListBox = await Hive.openBox('timerSetList');
    updateItems();
    notifyListeners();
  }

  TimerSetProvider() {
    _init();
  }
}
