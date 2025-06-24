// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_log.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExerciseLogAdapter extends TypeAdapter<ExerciseLog> {
  @override
  final int typeId = 2;

  @override
  ExerciseLog read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExerciseLog(
      id: fields[0] as int,
      date: fields[1] as String,
      title: fields[2] as String,
      set: fields[3] as int,
      totalMilliSecond: fields[4] as int,
      imageUrl: fields[5] as String,
      memo: fields[6] as String,
      timerActTimeMilliSecond: fields[7] as int,
      timerRestTimeMilliSecond: fields[8] as int,
      timerSet: fields[9] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ExerciseLog obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.set)
      ..writeByte(4)
      ..write(obj.totalMilliSecond)
      ..writeByte(5)
      ..write(obj.imageUrl)
      ..writeByte(6)
      ..write(obj.memo)
      ..writeByte(7)
      ..write(obj.timerActTimeMilliSecond)
      ..writeByte(8)
      ..write(obj.timerRestTimeMilliSecond)
      ..writeByte(9)
      ..write(obj.timerSet);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseLogAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
