import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../core/models/gym.dart';
import '../../core/storage/providers.dart';

final gymListProvider = AsyncNotifierProvider<GymListNotifier, List<Gym>>(
  GymListNotifier.new,
);

class GymListNotifier extends AsyncNotifier<List<Gym>> {
  @override
  Future<List<Gym>> build() async {
    return ref.read(gymRepositoryProvider).getAllGyms();
  }

  Future<void> addGym(String name) async {
    final gym = Gym(
      id: const Uuid().v4(),
      name: name,
      createdAt: DateTime.now(),
    );
    await ref.read(gymRepositoryProvider).saveGym(gym);
    ref.invalidateSelf();
  }

  Future<void> deleteGym(String gymId) async {
    await ref.read(gymRepositoryProvider).deleteGym(gymId);
    ref.invalidateSelf();
  }

  Future<void> updateGym(Gym gym) async {
    await ref.read(gymRepositoryProvider).saveGym(gym);
    ref.invalidateSelf();
  }
}
