import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import 'app.dart';
import 'core/models/generation.dart';
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
    await _seedFromAsset(repository);
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

Future<void> _seedFromAsset(GymRepository repository) async {
  final raw = await rootBundle.loadString('assets/default_gym.json');
  final data = jsonDecode(raw) as Map<String, dynamic>;

  final gym = Gym.fromJson(data['gym'] as Map<String, dynamic>);
  await repository.saveGym(gym);

  const uuid = Uuid();
  final createdAt = DateTime(2024, 1, 1);

  for (final entry in (data['problems'] as List<dynamic>)) {
    final p = entry as Map<String, dynamic>;
    final gradeId = p['gradeId'] as String;
    final number = p['number'] as int;
    final area = p['area'] as String;
    await repository.saveProblem(Problem(
      id: uuid.v4(),
      gymId: gym.id,
      gradeId: gradeId,
      number: number,
      generations: [
        Generation(
          id: uuid.v4(),
          order: 0,
          isActive: true,
          area: area,
          createdAt: createdAt,
        ),
      ],
    ));
  }
}
