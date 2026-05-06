import 'package:freezed_annotation/freezed_annotation.dart';

import 'clear_log.dart';

part 'generation.freezed.dart';
part 'generation.g.dart';

@freezed
class Generation with _$Generation {
  const factory Generation({
    required String id,
    required int order,
    required bool isActive,
    String? label,
    required DateTime createdAt,
    @Default([]) List<ClearLog> clearLogs,
  }) = _Generation;

  factory Generation.fromJson(Map<String, dynamic> json) =>
      _$GenerationFromJson(json);
}
