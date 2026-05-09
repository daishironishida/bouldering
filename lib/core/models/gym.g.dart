// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gym.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GymImpl _$$GymImplFromJson(Map<String, dynamic> json) => _$GymImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  grades:
      (json['grades'] as List<dynamic>?)
          ?.map((e) => GradeConfig.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  areas:
      (json['areas'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
);

Map<String, dynamic> _$$GymImplToJson(_$GymImpl instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'createdAt': instance.createdAt.toIso8601String(),
  'grades': instance.grades,
  'areas': instance.areas,
};
