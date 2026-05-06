// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grade_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GradeConfigImpl _$$GradeConfigImplFromJson(Map<String, dynamic> json) =>
    _$GradeConfigImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      colorHex: json['colorHex'] as String,
      order: (json['order'] as num).toInt(),
      problemCount: (json['problemCount'] as num).toInt(),
    );

Map<String, dynamic> _$$GradeConfigImplToJson(_$GradeConfigImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'colorHex': instance.colorHex,
      'order': instance.order,
      'problemCount': instance.problemCount,
    };
