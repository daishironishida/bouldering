import 'dart:convert';

import 'package:hive/hive.dart';

import '../models/gym.dart';
import '../models/problem.dart';

class GymRepository {
  GymRepository({required this.gymsBox, required this.problemsBox});

  final Box<String> gymsBox;
  final Box<String> problemsBox;

  // ─── Gym ───────────────────────────────────────────────────────────────

  List<Gym> getAllGyms() {
    return gymsBox.values
        .map((json) => Gym.fromJson(jsonDecode(json) as Map<String, dynamic>))
        .toList()
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
  }

  Future<void> saveGym(Gym gym) async {
    await gymsBox.put(gym.id, jsonEncode(gym.toJson()));
  }

  Future<void> deleteGym(String gymId) async {
    await gymsBox.delete(gymId);
    final keysToDelete = problemsBox.keys
        .cast<String>()
        .where((k) => k.startsWith('${gymId}_'))
        .toList();
    await problemsBox.deleteAll(keysToDelete);
  }

  // ─── Problem ───────────────────────────────────────────────────────────

  static String problemKey(String gymId, String gradeId, int number) =>
      '${gymId}_${gradeId}_$number';

  Problem? getProblem(String gymId, String gradeId, int number) {
    final raw = problemsBox.get(problemKey(gymId, gradeId, number));
    if (raw == null) return null;
    return Problem.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  List<Problem> getProblemsForGym(String gymId) {
    return problemsBox.keys
        .cast<String>()
        .where((k) => k.startsWith('${gymId}_'))
        .map((k) => Problem.fromJson(
            jsonDecode(problemsBox.get(k)!) as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveProblem(Problem problem) async {
    await problemsBox.put(
      problemKey(problem.gymId, problem.gradeId, problem.number),
      jsonEncode(problem.toJson()),
    );
  }
}
