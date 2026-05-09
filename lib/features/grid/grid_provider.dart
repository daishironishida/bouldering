import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../core/models/generation.dart';
import '../../core/models/gym.dart';
import '../../core/models/problem.dart';
import '../../core/storage/providers.dart';
import '../gym_list/gym_list_provider.dart';

/// 特定ジムのGym情報
final gymProvider = Provider.family<AsyncValue<Gym>, String>((ref, gymId) {
  return ref.watch(gymListProvider).whenData(
        (gyms) => gyms.firstWhere((g) => g.id == gymId),
      );
});

/// 特定ジムの全Problem（Map: gradeId_number → Problem）
final gymProblemsProvider =
    NotifierProviderFamily<GymProblemsNotifier, Map<String, Problem>, String>(
  GymProblemsNotifier.new,
);

class GymProblemsNotifier extends FamilyNotifier<Map<String, Problem>, String> {
  String get gymId => arg;

  @override
  Map<String, Problem> build(String gymId) {
    final problems = ref.read(gymRepositoryProvider).getProblemsForGym(gymId);
    return {
      for (final p in problems) '${p.gradeId}_${p.number}': p,
    };
  }

  Problem? getProblem(String gradeId, int number) =>
      state['${gradeId}_$number'];

  Future<void> saveProblem(Problem problem) async {
    await ref.read(gymRepositoryProvider).saveProblem(problem);
    state = {
      ...state,
      '${problem.gradeId}_${problem.number}': problem,
    };
  }

  /// 全グレードに対して、現在の最大列番号 +1 の位置に新規 Problem を作成する。
  /// テーブルを 1 列広げる「+」ボタン用。
  Future<void> appendColumnToAllGrades() async {
    final gym = await ref.read(gymListProvider.future).then(
          (gyms) => gyms.firstWhere((g) => g.id == gymId),
        );
    if (gym.grades.isEmpty) return;

    final currentMax = state.values
        .map((p) => p.number)
        .fold<int>(0, (m, n) => n > m ? n : m);
    final nextNumber = currentMax + 1;

    final repo = ref.read(gymRepositoryProvider);
    const uuid = Uuid();
    final newProblems = <Problem>[];

    for (final grade in gym.grades) {
      if (repo.getProblem(gymId, grade.id, nextNumber) != null) continue;
      final problem = Problem(
        id: uuid.v4(),
        gymId: gymId,
        gradeId: grade.id,
        number: nextNumber,
        generations: [
          Generation(
            id: uuid.v4(),
            order: 0,
            isActive: true,
            createdAt: DateTime.now(),
          ),
        ],
      );
      await repo.saveProblem(problem);
      newProblems.add(problem);
    }

    state = {
      ...state,
      for (final p in newProblems) '${p.gradeId}_${p.number}': p,
    };
  }

  void refresh() {
    ref.invalidateSelf();
  }
}
