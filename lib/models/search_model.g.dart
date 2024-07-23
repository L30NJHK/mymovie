// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SearchQueryAdapter extends TypeAdapter<SearchQuery> {
  @override
  final int typeId = 0;

  @override
  SearchQuery read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SearchQuery()..query = fields[0] as String;
  }

  @override
  void write(BinaryWriter writer, SearchQuery obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.query);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SearchQueryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
