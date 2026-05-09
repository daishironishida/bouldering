// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GenerationImpl _$$GenerationImplFromJson(Map<String, dynamic> json) =>
    _$GenerationImpl(
      id: json['id'] as String,
      order: (json['order'] as num).toInt(),
      isActive: json['isActive'] as bool,
      area: json['area'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      clearLogs:
          (json['clearLogs'] as List<dynamic>?)
              ?.map((e) => ClearLog.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$GenerationImplToJson(_$GenerationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order': instance.order,
      'isActive': instance.isActive,
      'area': instance.area,
      'createdAt': instance.createdAt.toIso8601String(),
      'clearLogs': instance.clearLogs,
    };
