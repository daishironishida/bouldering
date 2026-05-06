import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/grade_config.dart';
import '../../core/theme/app_theme.dart';
import 'gym_settings_provider.dart';

class GymSettingsScreen extends ConsumerWidget {
  const GymSettingsScreen({super.key, required this.gymId});

  final String gymId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gymAsync = ref.watch(gymSettingsProvider(gymId));

    return Scaffold(
      appBar: AppBar(
        title: gymAsync.maybeWhen(
          data: (gym) => Text(gym.name),
          orElse: () => const Text('設定'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'ジム名を編集',
            onPressed: gymAsync.hasValue
                ? () => _editGymName(context, ref, gymAsync.value!.name)
                : null,
          ),
        ],
      ),
      body: gymAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('エラー: $e')),
        data: (gym) {
          final grades = gym.grades;
          return Column(
            children: [
              Expanded(
                child: grades.isEmpty
                    ? const Center(
                        child: Text('グレードを追加してください',
                            style: TextStyle(color: Colors.grey)))
                    : ReorderableListView.builder(
                        itemCount: grades.length,
                        onReorder: (oldIndex, newIndex) => ref
                            .read(gymSettingsProvider(gymId).notifier)
                            .reorderGrades(oldIndex, newIndex),
                        itemBuilder: (context, index) {
                          final grade = grades[index];
                          return _GradeTile(
                            key: ValueKey(grade.id),
                            grade: grade,
                            gymId: gymId,
                          );
                        },
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () => _showAddGradeDialog(context, ref),
                    icon: const Icon(Icons.add),
                    label: const Text('グレードを追加'),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _editGymName(
      BuildContext context, WidgetRef ref, String current) async {
    final controller = TextEditingController(text: current);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ジム名を編集'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'ジム名'),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('キャンセル')),
          TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('保存')),
        ],
      ),
    );
    if (confirmed == true && controller.text.trim().isNotEmpty) {
      await ref
          .read(gymSettingsProvider(gymId).notifier)
          .updateName(controller.text.trim());
    }
  }

  Future<void> _showAddGradeDialog(BuildContext context, WidgetRef ref) async {
    await showDialog<void>(
      context: context,
      builder: (context) => _GradeEditDialog(
        gymId: gymId,
        onSave: (name, colorHex, count) async {
          await ref.read(gymSettingsProvider(gymId).notifier).addGrade(
                name: name,
                colorHex: colorHex,
                problemCount: count,
              );
        },
      ),
    );
  }
}

class _GradeTile extends ConsumerWidget {
  const _GradeTile({super.key, required this.grade, required this.gymId});

  final GradeConfig grade;
  final String gymId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = hexToColor(grade.colorHex);
    return ListTile(
      leading: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
      title: Text(grade.name),
      subtitle: Text('${grade.problemCount} 問'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit, size: 20),
            onPressed: () => _edit(context, ref),
          ),
          IconButton(
            icon: const Icon(Icons.delete, size: 20, color: Colors.red),
            onPressed: () => _delete(context, ref),
          ),
          const Icon(Icons.drag_handle),
        ],
      ),
    );
  }

  Future<void> _edit(BuildContext context, WidgetRef ref) async {
    await showDialog<void>(
      context: context,
      builder: (context) => _GradeEditDialog(
        gymId: gymId,
        initialName: grade.name,
        initialColorHex: grade.colorHex,
        initialCount: grade.problemCount,
        onSave: (name, colorHex, count) async {
          await ref.read(gymSettingsProvider(gymId).notifier).updateGrade(
                grade.copyWith(
                    name: name, colorHex: colorHex, problemCount: count),
              );
        },
      ),
    );
  }

  Future<void> _delete(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('グレードを削除'),
        content: Text('「${grade.name}」を削除しますか？'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('キャンセル')),
          TextButton(
              onPressed: () => Navigator.pop(context, true),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('削除')),
        ],
      ),
    );
    if (confirmed == true) {
      await ref.read(gymSettingsProvider(gymId).notifier).deleteGrade(grade.id);
    }
  }
}

class _GradeEditDialog extends StatefulWidget {
  const _GradeEditDialog({
    required this.gymId,
    required this.onSave,
    this.initialName,
    this.initialColorHex,
    this.initialCount,
  });

  final String gymId;
  final Future<void> Function(String name, String colorHex, int count) onSave;
  final String? initialName;
  final String? initialColorHex;
  final int? initialCount;

  @override
  State<_GradeEditDialog> createState() => _GradeEditDialogState();
}

class _GradeEditDialogState extends State<_GradeEditDialog> {
  late final TextEditingController _nameController;
  late final TextEditingController _countController;
  late String _selectedColorHex;

  @override
  void initState() {
    super.initState();
    _nameController =
        TextEditingController(text: widget.initialName ?? '');
    _countController = TextEditingController(
        text: (widget.initialCount ?? 10).toString());
    _selectedColorHex =
        widget.initialColorHex ?? AppTheme.gradeColorOptions.first;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _countController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.initialName == null ? 'グレードを追加' : 'グレードを編集'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              autofocus: true,
              decoration: const InputDecoration(labelText: 'グレード名（例: 8級）'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _countController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: '課題数'),
            ),
            const SizedBox(height: 16),
            const Text('カラー', style: TextStyle(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: AppTheme.gradeColorOptions.map((hex) {
                final selected = hex == _selectedColorHex;
                return GestureDetector(
                  onTap: () => setState(() => _selectedColorHex = hex),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: hexToColor(hex),
                      shape: BoxShape.circle,
                      border: selected
                          ? Border.all(color: Colors.black, width: 3)
                          : null,
                    ),
                    child: selected
                        ? const Icon(Icons.check, size: 18, color: Colors.white)
                        : null,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('キャンセル')),
        TextButton(
          onPressed: () async {
            final name = _nameController.text.trim();
            final count = int.tryParse(_countController.text.trim()) ?? 10;
            if (name.isEmpty) return;
            await widget.onSave(name, _selectedColorHex, count);
            if (context.mounted) Navigator.pop(context);
          },
          child: const Text('保存'),
        ),
      ],
    );
  }
}
