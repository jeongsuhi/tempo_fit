// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer_set.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TimerSetAdapter extends TypeAdapter<TimerSet> {
  @override
  final int typeId = 1;

  @override
  TimerSet read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TimerSet(
      id: fields[0] as int,
      title: fields[1] as String,
      set: fields[2] as int,
      actTimeMinute: fields[3] as int,
      actTimeSecond: fields[4] as int,
      restTimeMinute: fields[5] as int,
      restTimeSecond: fields[6] as int,
      isFavorite: fields[7] as bool,
      line: fields[8] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, TimerSet obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.set)
      ..writeByte(3)
      ..write(obj.actTimeMinute)
      ..writeByte(4)
      ..write(obj.actTimeSecond)
      ..writeByte(5)
      ..write(obj.restTimeMinute)
      ..writeByte(6)
      ..write(obj.restTimeSecond)
      ..writeByte(7)
      ..write(obj.isFavorite)
      ..writeByte(8)
      ..write(obj.line);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimerSetAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
