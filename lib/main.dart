import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';
import 'core/models/grade_config.dart';
import 'core/models/gym.dart';
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
  grades: const [
    GradeConfig(id: 'spodori-kids', name: 'キッズ', colorHex: '00BCD4', order: 0, problemCount: 10),
    GradeConfig(id: 'spodori-7kyu', name: '7級', colorHex: 'E91E63', order: 1, problemCount: 10),
    GradeConfig(id: 'spodori-6kyu', name: '6級', colorHex: '4CAF50', order: 2, problemCount: 12),
    GradeConfig(id: 'spodori-5kyu', name: '5級', colorHex: 'FFEB3B', order: 3, problemCount: 14),
    GradeConfig(id: 'spodori-4kyu', name: '4級', colorHex: '3F51B5', order: 4, problemCount: 16),
    GradeConfig(id: 'spodori-3kyu', name: '3級', colorHex: 'F44336', order: 5, problemCount: 18),
    GradeConfig(id: 'spodori-2kyu', name: '2級', colorHex: '212121', order: 6, problemCount: 20),
    GradeConfig(id: 'spodori-1kyu', name: '1級', colorHex: 'FFFFFF', order: 7, problemCount: 21),
    GradeConfig(id: 'spodori-shodan', name: '初段以上', colorHex: '795548', order: 8, problemCount: 5),
  ],
);
