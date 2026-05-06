// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'problem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProblemImpl _$$ProblemImplFromJson(Map<String, dynamic> json) =>
    _$ProblemImpl(
      id: json['id'] as String,
      gymId: json['gymId'] as String,
      gradeId: json['gradeId'] as String,
      number: (json['number'] as num).toInt(),
      generations:
          (json['generations'] as List<dynamic>?)
              ?.map((e) => Generation.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ProblemImplToJson(_$ProblemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'gymId': instance.gymId,
      'gradeId': instance.gradeId,
      'number': instance.number,
      'generations': instance.generations,
    };
