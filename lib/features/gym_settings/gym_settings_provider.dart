import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../core/models/generation.dart';
import '../../core/models/grade_config.dart';
import '../../core/models/gym.dart';
import '../../core/models/problem.dart';
import '../../core/storage/providers.dart';
import '../grid/grid_provider.dart';
import '../gym_list/gym_list_provider.dart';

final gymSettingsProvider =
    AsyncNotifierProviderFamily<GymSettingsNotifier, Gym, String>(
  GymSettingsNotifier.new,
);

class GymSettingsNotifier extends FamilyAsyncNotifier<Gym, String> {
  @override
  Future<Gym> build(String gymId) async {
    final gyms = await ref.watch(gymListProvider.future);
    return gyms.firstWhere((g) => g.id == gymId);
  }

  Future<void> updateName(String name) async {
    final gym = await future;
    await _save(gym.copyWith(name: name));
  }

  Future<void> addGrade({
    required String name,
    required String colorHex,
    required int problemCount,
  }) async {
    final gym = await future;
    final gradeId = const Uuid().v4();
    final grade = GradeConfig(
      id: gradeId,
      name: name,
      colorHex: colorHex,
      order: gym.grades.length,
      problemCount: problemCount,
    );
    await _save(gym.copyWith(grades: [...gym.grades, grade]));
    await _createProblemsForGrade(gym.id, gradeId, problemCount);
  }

  Future<void> updateGrade(GradeConfig updated) async {
    final gym = await future;
    final grades = gym.grades.map((g) => g.id == updated.id ? updated : g).toList();
    await _save(gym.copyWith(grades: grades));
    await _createProblemsForGrade(gym.id, updated.id, updated.problemCount);
  }

  /// 未登録スロット（null）に対してのみ新規課題を自動作成する
  Future<void> _createProblemsForGrade(
      String gymId, String gradeId, int problemCount) async {
    final repo = ref.read(gymRepositoryProvider);
    const uuid = Uuid();
    for (int i = 1; i <= problemCount; i++) {
      if (repo.getProblem(gymId, gradeId, i) == null) {
        final generation = Generation(
          id: uuid.v4(),
          order: 0,
          isActive: true,
          createdAt: DateTime.now(),
        );
        final problem = Problem(
          id: uuid.v4(),
          gymId: gymId,
          gradeId: gradeId,
          number: i,
          generations: [generation],
        );
        await repo.saveProblem(problem);
      }
    }
    ref.invalidate(gymProblemsProvider(gymId));
  }

  Future<void> deleteGrade(String gradeId) async {
    final gym = await future;
    final grades = gym.grades.where((g) => g.id != gradeId).toList();
    await _save(gym.copyWith(grades: grades));
  }

  Future<void> reorderGrades(int oldIndex, int newIndex) async {
    final gym = await future;
    final grades = List<GradeConfig>.from(gym.grades);
    if (oldIndex < newIndex) newIndex -= 1;
    final item = grades.removeAt(oldIndex);
    grades.insert(newIndex, item);
    final reordered = grades
        .asMap()
        .entries
        .map((e) => e.value.copyWith(order: e.key))
        .toList();
    await _save(gym.copyWith(grades: reordered));
  }

  Future<void> _save(Gym gym) async {
    await ref.read(gymRepositoryProvider).saveGym(gym);
    ref.invalidateSelf();
    ref.invalidate(gymListProvider);
  }
}
