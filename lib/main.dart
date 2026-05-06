import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';
import 'core/storage/gym_repository.dart';
import 'core/storage/providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  final gymsBox = await Hive.openBox<String>('gyms');
  final problemsBox = await Hive.openBox<String>('problems');
  final repository = GymRepository(gymsBox: gymsBox, problemsBox: problemsBox);

  runApp(
    ProviderScope(
      overrides: [
        gymRepositoryProvider.overrideWithValue(repository),
      ],
      child: const App(),
    ),
  );
}
