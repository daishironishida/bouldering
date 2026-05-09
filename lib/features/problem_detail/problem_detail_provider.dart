import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../core/models/clear_log.dart';
import '../../core/models/generation.dart';
import '../../core/models/problem.dart';
import '../../core/storage/providers.dart';
import '../grid/grid_provider.dart';

/// (gymId, gradeId, number) を一つのキーとして扱うためのクラス
class ProblemKey {
  const ProblemKey(this.gymId, this.gradeId, this.number);
  final String gymId;
  final String gradeId;
  final int number;

  @override
  bool operator ==(Object other) =>
      other is ProblemKey &&
      gymId == other.gymId &&
      gradeId == other.gradeId &&
      number == other.number;

  @override
  int get hashCode => Object.hash(gymId, gradeId, number);
}

final problemDetailProvider = NotifierProviderFamily<ProblemDetailNotifier,
    Problem?, ProblemKey>(ProblemDetailNotifier.new);

class ProblemDetailNotifier extends FamilyNotifier<Problem?, ProblemKey> {
  String get gymId => arg.gymId;
  String get gradeId => arg.gradeId;
  int get number => arg.number;

  @override
  Problem? build(ProblemKey key) {
    return ref.read(gymRepositoryProvider).getProblem(gymId, gradeId, number);
  }

  /// アクティブ世代のエリアを更新
  Future<void> updateArea(String? area) async {
    final problem = _requireProblem();
    final active = problem.activeGeneration;
    if (active == null) return;
    await _save(problem.copyWith(
      generations: problem.generations
          .map((g) => g.id == active.id ? g.copyWith(area: area) : g)
          .toList(),
    ));
  }

  /// アクティブ世代のラベルを更新
  Future<void> updateLabel(String label) async {
    final problem = _requireProblem();
    final active = problem.activeGeneration;
    if (active == null) return;
    await _save(problem.copyWith(
      generations: problem.generations
          .map((g) =>
              g.id == active.id ? g.copyWith(label: label.isEmpty ? null : label) : g)
          .toList(),
    ));
  }

  /// 現在日時でクリア記録を追加
  Future<void> addClearLog() async {
    final problem = _requireProblem();
    final active = problem.activeGeneration;
    if (active == null) return;
    final log = ClearLog(
      id: const Uuid().v4(),
      clearedAt: DateTime.now(),
    );
    await _save(problem.copyWith(
      generations: problem.generations
          .map((g) =>
              g.id == active.id
                  ? g.copyWith(clearLogs: [...g.clearLogs, log])
                  : g)
          .toList(),
    ));
  }

  /// クリアログの日時を編集
  Future<void> updateClearLogDate(String logId, DateTime newDate) async {
    final problem = _requireProblem();
    await _save(problem.copyWith(
      generations: problem.generations
          .map((g) => g.copyWith(
                clearLogs: g.clearLogs
                    .map((log) =>
                        log.id == logId ? log.copyWith(clearedAt: newDate) : log)
                    .toList(),
              ))
          .toList(),
    ));
  }

  /// クリアログを削除
  Future<void> deleteClearLog(String logId) async {
    final problem = _requireProblem();
    await _save(problem.copyWith(
      generations: problem.generations
          .map((g) => g.copyWith(
                clearLogs:
                    g.clearLogs.where((log) => log.id != logId).toList(),
              ))
          .toList(),
    ));
  }

  /// ホールド替え（新世代追加）または未登録スロットへの課題追加
  Future<void> addNewGeneration() async {
    final existing = state;
    if (existing == null || existing.generations.isEmpty) {
      // 未登録 → 新規Problem作成
      final generation = Generation(
        id: const Uuid().v4(),
        order: 0,
        isActive: true,
        createdAt: DateTime.now(),
      );
      final problem = Problem(
        id: const Uuid().v4(),
        gymId: gymId,
        gradeId: gradeId,
        number: number,
        generations: [generation],
      );
      await _save(problem);
    } else {
      // 既存の課題にホールド替え
      final nextOrder = existing.generations.length;
      final newGen = Generation(
        id: const Uuid().v4(),
        order: nextOrder,
        isActive: true,
        createdAt: DateTime.now(),
      );
      await _save(existing.copyWith(
        generations: existing.generations
            .map((g) => g.isActive ? g.copyWith(isActive: false) : g)
            .toList()
          ..add(newGen),
      ));
    }
  }

  /// 課題削除（現在世代を inactive に）
  Future<void> deleteCurrentGeneration() async {
    final problem = _requireProblem();
    await _save(problem.copyWith(
      generations: problem.generations
          .map((g) => g.isActive ? g.copyWith(isActive: false) : g)
          .toList(),
    ));
  }

  Problem _requireProblem() {
    final p = state;
    if (p == null) throw StateError('Problem not initialized');
    return p;
  }

  Future<void> _save(Problem problem) async {
    await ref.read(gymRepositoryProvider).saveProblem(problem);
    state = problem;
    // グリッドの表示を更新
    ref.read(gymProblemsProvider(gymId).notifier).saveProblem(problem);
  }
}
