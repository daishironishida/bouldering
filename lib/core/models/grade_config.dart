import 'package:freezed_annotation/freezed_annotation.dart';

part 'grade_config.freezed.dart';
part 'grade_config.g.dart';

@freezed
class GradeConfig with _$GradeConfig {
  const factory GradeConfig({
    required String id,
    required String name,
    required String colorHex,
    required int order,
    required int problemCount,
  }) = _GradeConfig;

  factory GradeConfig.fromJson(Map<String, dynamic> json) =>
      _$GradeConfigFromJson(json);
}
