// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProjectModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProjectModelAdapter extends TypeAdapter<ProjectModel> {
  @override
  final int typeId = 1;

  @override
  ProjectModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProjectModel(
      projectid: fields[0] as String,
      publisherid: fields[1] as String?,
      accessid: fields[2] as String?,
      admin: fields[3] as String?,
      projecttitle: fields[4] as String?,
      date: fields[5] as String?,
      image: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ProjectModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.projectid)
      ..writeByte(1)
      ..write(obj.publisherid)
      ..writeByte(2)
      ..write(obj.accessid)
      ..writeByte(3)
      ..write(obj.admin)
      ..writeByte(4)
      ..write(obj.projecttitle)
      ..writeByte(5)
      ..write(obj.date)
      ..writeByte(6)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProjectModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
