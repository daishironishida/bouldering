import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  void refresh() {
    ref.invalidateSelf();
  }
}
