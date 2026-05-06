import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'gym_repository.dart';

/// main.dart で override して注入する
final gymRepositoryProvider = Provider<GymRepository>((ref) {
  throw UnimplementedError('GymRepository must be provided via ProviderScope');
});
