import 'package:freezed_annotation/freezed_annotation.dart';

part 'clear_log.freezed.dart';
part 'clear_log.g.dart';

@freezed
class ClearLog with _$ClearLog {
  const factory ClearLog({
    required String id,
    required DateTime clearedAt,
    String? note,
  }) = _ClearLog;

  factory ClearLog.fromJson(Map<String, dynamic> json) =>
      _$ClearLogFromJson(json);
}
