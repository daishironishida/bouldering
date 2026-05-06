import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_theme.dart';
import 'gym_list_provider.dart';

class GymListScreen extends ConsumerWidget {
  const GymListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gymsAsync = ref.watch(gymListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('ボルダリング')),
      body: gymsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('エラー: $e')),
        data: (gyms) {
          if (gyms.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.fitness_center,
                      size: 48, color: Colors.white.withAlpha(30)),
                  const SizedBox(height: 16),
                  Text(
                    'ジムを追加してください',
                    style: TextStyle(color: Colors.white.withAlpha(80)),
                  ),
                ],
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: gyms.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final gym = gyms[index];
              return Card(
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => context.push('/gym/${gym.id}'),
                  onLongPress: () =>
                      _showGymOptions(context, ref, gym.id, gym.name),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                gym.name,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Icon(Icons.chevron_right,
                                size: 18,
                                color: Colors.white.withAlpha(60)),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${gym.grades.length} グレード',
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withAlpha(80)),
                        ),
                        if (gym.grades.isNotEmpty) ...[
                          const SizedBox(height: 10),
                          Row(
                            children: gym.grades.map((g) {
                              return Container(
                                width: 12,
                                height: 12,
                                margin: const EdgeInsets.only(right: 5),
                                decoration: BoxDecoration(
                                  color: hexToColor(g.colorHex),
                                  shape: BoxShape.circle,
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddGymDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _showAddGymDialog(BuildContext context, WidgetRef ref) async {
    final controller = TextEditingController();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ジムを追加'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'ジム名'),
          textCapitalization: TextCapitalization.words,
          onSubmitted: (_) => Navigator.pop(context, true),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('追加'),
          ),
        ],
      ),
    );

    if (confirmed == true && controller.text.trim().isNotEmpty) {
      await ref.read(gymListProvider.notifier).addGym(controller.text.trim());
    }
  }

  Future<void> _showGymOptions(
    BuildContext context,
    WidgetRef ref,
    String gymId,
    String gymName,
  ) async {
    await showModalBottomSheet<void>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(40),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('設定'),
              onTap: () {
                Navigator.pop(context);
                context.push('/gym/$gymId/settings');
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('削除', style: TextStyle(color: Colors.red)),
              onTap: () async {
                Navigator.pop(context);
                final confirmed = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('ジムを削除'),
                    content: Text('「$gymName」を削除しますか？\nすべてのデータが失われます。'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('キャンセル'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.red),
                        child: const Text('削除'),
                      ),
                    ],
                  ),
                );
                if (confirmed == true) {
                  await ref
                      .read(gymListProvider.notifier)
                      .deleteGym(gymId);
                }
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
