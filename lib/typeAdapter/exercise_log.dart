import 'package:hive/hive.dart';

part 'exercise_log.g.dart';

@HiveType(typeId: 2)
class ExerciseLog {
  @HiveField(0) final int id;
  @HiveField(1) String date;
  @HiveField(2) String title;
  @HiveField(3) int set;
  @HiveField(4) int totalMilliSecond;
  @HiveField(5) String imageUrl;
  @HiveField(6) String memo;
  @HiveField(7) int timerActTimeMilliSecond;
  @HiveField(8) int timerRestTimeMilliSecond;
  @HiveField(9) int timerSet;

  ExerciseLog({
    this.id = 0,
    required this.date,
    required this.title,
    required this.set,
    required this.totalMilliSecond,
    this.imageUrl = "",
    this.memo = "",
    required this.timerActTimeMilliSecond,
    required this.timerRestTimeMilliSecond,
    required this.timerSet,
  });

  ExerciseLog copy() {
    return ExerciseLog(
      id: id,
      date: date,
      title: title,
      set: set,
      totalMilliSecond: totalMilliSecond,
      imageUrl: imageUrl,
      memo: memo,
      timerActTimeMilliSecond: timerActTimeMilliSecond,
      timerRestTimeMilliSecond: timerRestTimeMilliSecond,
      timerSet: timerSet
    );
  }
}
