// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clear_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClearLogImpl _$$ClearLogImplFromJson(Map<String, dynamic> json) =>
    _$ClearLogImpl(
      id: json['id'] as String,
      clearedAt: DateTime.parse(json['clearedAt'] as String),
      note: json['note'] as String?,
    );

Map<String, dynamic> _$$ClearLogImplToJson(_$ClearLogImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'clearedAt': instance.clearedAt.toIso8601String(),
      'note': instance.note,
    };
