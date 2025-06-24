import 'package:hive/hive.dart';

part 'timer_set.g.dart';

@HiveType(typeId: 1)
class TimerSet {
  @HiveField(0) final int id;
  @HiveField(1) String title;
  @HiveField(2) int set;
  @HiveField(3) int actTimeMinute;
  @HiveField(4) int actTimeSecond;
  @HiveField(5) int restTimeMinute;
  @HiveField(6) int restTimeSecond;
  @HiveField(7) bool isFavorite;
  @HiveField(8) int? line;

  TimerSet({
    this.id = 0,
    this.title = "",
    this.set = 1,
    this.actTimeMinute = 0,
    this.actTimeSecond = 0,
    this.restTimeMinute = 0,
    this.restTimeSecond = 0,
    this.isFavorite = false,
    this.line
  });

  TimerSet copy() {
    return TimerSet(
      id: id,
      title: title,
      set: set,
      actTimeMinute: actTimeMinute,
      actTimeSecond: actTimeSecond,
      restTimeMinute: restTimeMinute,
      restTimeSecond: restTimeSecond,
      isFavorite: isFavorite,
      line: line
    );
  }

}
