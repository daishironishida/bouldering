import 'package:freezed_annotation/freezed_annotation.dart';

import 'generation.dart';

part 'problem.freezed.dart';
part 'problem.g.dart';

@freezed
class Problem with _$Problem {
  const factory Problem({
    required String id,
    required String gymId,
    required String gradeId,
    required int number,
    @Default([]) List<Generation> generations,
  }) = _Problem;

  factory Problem.fromJson(Map<String, dynamic> json) =>
      _$ProblemFromJson(json);
}

/// グリッドセルの状態（Problem レコードが存在するスロットの状態）
enum CellState {
  /// 過去に課題があったが現在は削除済み
  deleted,

  /// 課題あり・未クリア
  uncleared,

  /// 課題あり・クリア済み
  cleared,
}

extension ProblemExtension on Problem {
  Generation? get activeGeneration =>
      generations.where((g) => g.isActive).firstOrNull;

  CellState get cellState {
    final active = activeGeneration;
    if (active == null) return CellState.deleted;
    if (active.clearLogs.isNotEmpty) return CellState.cleared;
    return CellState.uncleared;
  }
}
