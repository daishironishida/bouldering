import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/clear_log.dart';
import '../../core/models/generation.dart';
import '../../core/models/problem.dart';
import 'problem_detail_provider.dart';

class ProblemDetailSheet extends ConsumerWidget {
  const ProblemDetailSheet({
    super.key,
    required this.gymId,
    required this.gradeId,
    required this.gradeName,
    required this.number,
  });

  final String gymId;
  final String gradeId;
  final String gradeName;
  final int number;

  ProblemKey get _key => ProblemKey(gymId, gradeId, number);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final problem = ref.watch(problemDetailProvider(_key));
    final state = problem.cellState;
    final active = problem?.activeGeneration;

    final titleRow = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Text(
            '$gradeName  $number番',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          _StatusChip(state: state),
        ],
      ),
    );

    Widget buildContent(ScrollController scrollController) => Column(
          children: [
            if (!kIsWeb)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            if (kIsWeb)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            titleRow,
            const Divider(height: 24),
            Expanded(
              child: ListView(
                controller: scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  if (active != null) ...[
                    _LabelEditor(problemKey: _key, currentLabel: active.label),
                    const SizedBox(height: 16),
                  ],
                  _ActionButtons(
                    problemKey: _key,
                    state: state,
                    onClose: () => Navigator.pop(context),
                  ),
                  const SizedBox(height: 24),
                  if (problem != null && problem.generations.isNotEmpty) ...[
                    const Text('クリア履歴',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    _GenerationHistory(
                      problem: problem,
                      problemKey: _key,
                    ),
                  ],
                ],
              ),
            ),
          ],
        );

    if (kIsWeb) {
      final scrollController = ScrollController();
      return buildContent(scrollController);
    }

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) => buildContent(scrollController),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.state});
  final CellState state;

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (state) {
      CellState.cleared => ('クリア済み', Colors.green),
      CellState.uncleared => ('未クリア', Colors.orange),
      CellState.deleted => ('削除済み', Colors.grey),
      CellState.unregistered => ('未登録', Colors.grey),
    };
    return Chip(
      label: Text(label, style: const TextStyle(fontSize: 12)),
      backgroundColor: color.withAlpha(30),
      side: BorderSide(color: color.withAlpha(80)),
      padding: const EdgeInsets.symmetric(horizontal: 4),
      visualDensity: VisualDensity.compact,
    );
  }
}

class _LabelEditor extends ConsumerStatefulWidget {
  const _LabelEditor({required this.problemKey, required this.currentLabel});
  final ProblemKey problemKey;
  final String? currentLabel;

  @override
  ConsumerState<_LabelEditor> createState() => _LabelEditorState();
}

class _LabelEditorState extends ConsumerState<_LabelEditor> {
  late final TextEditingController _controller;
  bool _editing = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.currentLabel ?? '');
  }

  @override
  void didUpdateWidget(_LabelEditor old) {
    super.didUpdateWidget(old);
    if (old.currentLabel != widget.currentLabel && !_editing) {
      _controller.text = widget.currentLabel ?? '';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.label_outline, size: 20, color: Colors.grey),
        const SizedBox(width: 8),
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              hintText: 'ラベル（壁番号など）',
              isDense: true,
              border: OutlineInputBorder(),
            ),
            onTap: () => setState(() => _editing = true),
            onSubmitted: (_) => _save(),
            onTapOutside: (_) {
              if (_editing) _save();
            },
          ),
        ),
        if (_editing) ...[
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.check, color: Colors.green),
            onPressed: _save,
          ),
        ],
      ],
    );
  }

  void _save() {
    ref
        .read(problemDetailProvider(widget.problemKey).notifier)
        .updateLabel(_controller.text);
    setState(() => _editing = false);
    FocusScope.of(context).unfocus();
  }
}

class _ActionButtons extends ConsumerWidget {
  const _ActionButtons({
    required this.problemKey,
    required this.state,
    required this.onClose,
  });

  final ProblemKey problemKey;
  final CellState state;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier =
        ref.read(problemDetailProvider(problemKey).notifier);

    return Column(
      children: [
        // クリアボタン（課題がある & 未クリア or 追加クリア）
        if (state == CellState.uncleared || state == CellState.cleared)
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () async {
                await notifier.addClearLog();
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('クリアを記録しました')),
                  );
                }
              },
              icon: const Icon(Icons.check),
              label: const Text('クリア記録'),
            ),
          ),
        const SizedBox(height: 8),
        // ホールド替え / 課題追加ボタン
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () async {
              final isNew = state == CellState.unregistered ||
                  state == CellState.deleted;
              if (!isNew) {
                final confirmed = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('ホールド替え'),
                    content: const Text(
                        '現在の課題をリセットして新しい課題を登録しますか？\nクリア記録は残ります。'),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('キャンセル')),
                      TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text('実行')),
                    ],
                  ),
                );
                if (confirmed != true) return;
              }
              await notifier.addNewGeneration();
              if (context.mounted && isNew) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('課題を追加しました')),
                );
              }
            },
            icon: Icon(state == CellState.unregistered || state == CellState.deleted
                ? Icons.add
                : Icons.refresh),
            label: Text(
                state == CellState.unregistered || state == CellState.deleted
                    ? '課題を追加'
                    : 'ホールド替え'),
          ),
        ),
        // 課題削除ボタン（課題ありの場合のみ）
        if (state == CellState.uncleared || state == CellState.cleared) ...[
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () async {
                final confirmed = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('課題を削除'),
                    content: const Text('この課題を削除しますか？\nクリア記録は残ります。'),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('キャンセル')),
                      TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.red),
                          child: const Text('削除')),
                    ],
                  ),
                );
                if (confirmed == true) {
                  await notifier.deleteCurrentGeneration();
                }
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
                side: const BorderSide(color: Colors.red),
              ),
              icon: const Icon(Icons.delete_outline),
              label: const Text('課題を削除'),
            ),
          ),
        ],
      ],
    );
  }
}

class _GenerationHistory extends ConsumerWidget {
  const _GenerationHistory(
      {required this.problem, required this.problemKey});

  final Problem problem;
  final ProblemKey problemKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 新しい世代が先に来るよう逆順で表示
    final generations = problem.generations.reversed.toList();

    return Column(
      children: generations.asMap().entries.map((entry) {
        final gen = entry.value;
        final genNumber = problem.generations.length - entry.key;
        return _GenerationSection(
          generation: gen,
          generationNumber: genNumber,
          isActive: gen.isActive,
          problemKey: problemKey,
        );
      }).toList(),
    );
  }
}

class _GenerationSection extends ConsumerWidget {
  const _GenerationSection({
    required this.generation,
    required this.generationNumber,
    required this.isActive,
    required this.problemKey,
  });

  final Generation generation;
  final int generationNumber;
  final bool isActive;
  final ProblemKey problemKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 世代ヘッダー
        Row(
          children: [
            Text(
              '第 $generationNumber 世代',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 8),
            if (isActive)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '現在',
                  style: TextStyle(
                      fontSize: 10,
                      color: Colors.blue.shade700,
                      fontWeight: FontWeight.w600),
                ),
              ),
          ],
        ),
        if (generation.clearLogs.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            child: Text(
              'クリア記録なし',
              style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
            ),
          )
        else
          ...generation.clearLogs.reversed.map((log) => _ClearLogTile(
                log: log,
                problemKey: problemKey,
              )),
        const Divider(height: 20),
      ],
    );
  }
}

class _ClearLogTile extends ConsumerWidget {
  const _ClearLogTile({required this.log, required this.problemKey});

  final ClearLog log;
  final ProblemKey problemKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(problemDetailProvider(problemKey).notifier);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.check_circle_outline, size: 16, color: Colors.green),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              _formatDate(log.clearedAt),
              style: const TextStyle(fontSize: 13),
            ),
          ),
          // 日時編集
          IconButton(
            icon: const Icon(Icons.edit, size: 18),
            visualDensity: VisualDensity.compact,
            onPressed: () async {
              final picked = await _pickDateTime(context, log.clearedAt);
              if (picked != null) {
                await notifier.updateClearLogDate(log.id, picked);
              }
            },
          ),
          // 削除
          IconButton(
            icon: const Icon(Icons.delete, size: 18, color: Colors.red),
            visualDensity: VisualDensity.compact,
            onPressed: () async {
              await notifier.deleteClearLog(log.id);
            },
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime dt) {
    return '${dt.year}/${dt.month.toString().padLeft(2, '0')}/'
        '${dt.day.toString().padLeft(2, '0')}  '
        '${dt.hour.toString().padLeft(2, '0')}:'
        '${dt.minute.toString().padLeft(2, '0')}';
  }

  Future<DateTime?> _pickDateTime(
      BuildContext context, DateTime initial) async {
    final date = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );
    if (date == null || !context.mounted) return null;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initial),
    );
    if (time == null) return null;

    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }
}
