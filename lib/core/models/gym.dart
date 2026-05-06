import 'package:freezed_annotation/freezed_annotation.dart';

import 'grade_config.dart';

part 'gym.freezed.dart';
part 'gym.g.dart';

@freezed
class Gym with _$Gym {
  const factory Gym({
    required String id,
    required String name,
    required DateTime createdAt,
    @Default([]) List<GradeConfig> grades,
  }) = _Gym;

  factory Gym.fromJson(Map<String, dynamic> json) => _$GymFromJson(json);
}
