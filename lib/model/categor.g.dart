// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categor.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategorAdapter extends TypeAdapter<Categor> {
  @override
  final int typeId = 2;

  @override
  Categor read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Categor(
      id: fields[0] as int,
      name: fields[1] as String,
      image: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Categor obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
