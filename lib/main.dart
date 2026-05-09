import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';
import 'core/models/generation.dart';
import 'core/models/grade_config.dart';
import 'core/models/gym.dart';
import 'core/models/problem.dart';
import 'core/storage/gym_repository.dart';
import 'core/storage/providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  final gymsBox = await Hive.openBox<String>('gyms');
  final problemsBox = await Hive.openBox<String>('problems');
  final repository = GymRepository(gymsBox: gymsBox, problemsBox: problemsBox);

  if (gymsBox.isEmpty) {
    await repository.saveGym(_spodoriGym);
    await _seedSpodoriProblems(repository);
  }

  runApp(
    ProviderScope(
      overrides: [
        gymRepositoryProvider.overrideWithValue(repository),
      ],
      child: const App(),
    ),
  );
}

final _spodoriGym = Gym(
  id: 'spodori',
  name: 'スポドリ',
  createdAt: DateTime(2024, 1, 1),
  areas: const ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'],
  grades: const [
    GradeConfig(id: 'spodori-kids', name: 'キッズ', colorHex: '00BCD4', order: 0, problemCount: 9),
    GradeConfig(id: 'spodori-7kyu', name: '7級', colorHex: 'E91E63', order: 1, problemCount: 9),
    GradeConfig(id: 'spodori-6kyu', name: '6級', colorHex: '4CAF50', order: 2, problemCount: 14),
    GradeConfig(id: 'spodori-5kyu', name: '5級', colorHex: 'FFEB3B', order: 3, problemCount: 19),
    GradeConfig(id: 'spodori-4kyu', name: '4級', colorHex: '3F51B5', order: 4, problemCount: 20),
    GradeConfig(id: 'spodori-3kyu', name: '3級', colorHex: 'F44336', order: 5, problemCount: 21),
    GradeConfig(id: 'spodori-2kyu', name: '2級', colorHex: '212121', order: 6, problemCount: 17),
    GradeConfig(id: 'spodori-1kyu', name: '1級', colorHex: 'FFFFFF', order: 7, problemCount: 11),
    GradeConfig(id: 'spodori-shodan', name: '初段以上', colorHex: '795548', order: 8, problemCount: 5),
  ],
);

const _gradeAreas = <String, List<String>>{
  'spodori-kids': ['F', 'A', 'B', 'D', 'C', 'B', 'E', 'B', 'E'],
  'spodori-7kyu': ['C', 'A', 'B', 'D', 'A', 'E', 'F', 'G', 'C'],
  'spodori-6kyu': ['G', 'A', 'A', 'G', 'C', 'B', 'E', 'B', 'D', 'F', 'H', 'C', 'D', 'G'],
  'spodori-5kyu': ['E', 'B', 'C', 'A', 'A', 'G', 'E', 'G', 'H', 'C', 'F', 'H', 'A', 'C', 'D', 'D', 'F', 'B', 'F'],
  'spodori-4kyu': ['A', 'F', 'G', 'C', 'B', 'E', 'A', 'G', 'B', 'G', 'F', 'H', 'B', 'C', 'D', 'G', 'H', 'F', 'D', 'E'],
  'spodori-3kyu': ['D', 'H', 'D', 'B', 'F', 'A', 'G', 'E', 'G', 'E', 'B', 'A', 'G', 'F', 'C', 'C', 'H', 'C', 'H', 'E', 'B'],
  'spodori-2kyu': ['H', 'C', 'B', 'E', 'F', 'A', 'G', 'D', 'B', 'A', 'F', 'G', 'E', 'C', 'H', 'H', 'D'],
  'spodori-1kyu': ['H', 'G', 'B', 'F', 'F', 'A', 'A', 'D', 'E', 'D', 'C'],
};

// 初段以上: slot 1 is empty, problems start at 2
const _shodanAreas = <int, String>{2: 'G', 3: 'H', 4: 'D', 5: 'F'};

Future<void> _seedSpodoriProblems(GymRepository repository) async {
  final createdAt = DateTime(2024, 1, 1);

  for (final entry in _gradeAreas.entries) {
    final gradeId = entry.key;
    final areas = entry.value;
    for (var i = 0; i < areas.length; i++) {
      final number = i + 1;
      await repository.saveProblem(Problem(
        id: '$gradeId-$number',
        gymId: 'spodori',
        gradeId: gradeId,
        number: number,
        generations: [
          Generation(
            id: '$gradeId-$number-g1',
            order: 0,
            isActive: true,
            area: areas[i],
            createdAt: createdAt,
          ),
        ],
      ));
    }
  }

  for (final entry in _shodanAreas.entries) {
    final number = entry.key;
    await repository.saveProblem(Problem(
      id: 'spodori-shodan-$number',
      gymId: 'spodori',
      gradeId: 'spodori-shodan',
      number: number,
      generations: [
        Generation(
          id: 'spodori-shodan-$number-g1',
          order: 0,
          isActive: true,
          area: entry.value,
          createdAt: createdAt,
        ),
      ],
    ));
  }
}
