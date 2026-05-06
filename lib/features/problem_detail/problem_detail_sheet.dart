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

    Widget buildContent(ScrollController scrollController) => Column(
          children: [
            // ─── ドラッグハンドル (mobile) / 閉じるボタン (web) ──
            if (!kIsWeb)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(40),
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
                    icon: Icon(Icons.close,
                        color: Colors.white.withAlpha(160)),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            // ─── タイトル ─────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    '$gradeName  $number番',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  _StatusChip(state: state),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Divider(height: 1, color: Colors.white.withAlpha(15)),
            // ─── スクロール可能なコンテンツ ───────────────────────
            Expanded(
              child: ListView(
                controller: scrollController,
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
                children: [
                  if (active != null) ...[
                    _LabelEditor(
                        problemKey: _key, currentLabel: active.label),
                    const SizedBox(height: 20),
                  ],
                  _ActionButtons(
                    problemKey: _key,
                    state: state,
                    onClose: () => Navigator.pop(context),
                  ),
                  if (problem != null && problem.generations.isNotEmpty) ...[
                    const SizedBox(height: 28),
                    Text(
                      'クリア履歴',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.1,
                        color: Colors.white.withAlpha(100),
                      ),
                    ),
                    const SizedBox(height: 12),
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
    final (label, bg, fg) = switch (state) {
      CellState.cleared => (
          'クリア済み',
          const Color(0xFF4ADE80).withAlpha(30),
          const Color(0xFF4ADE80),
        ),
      CellState.uncleared => (
          '未クリア',
          const Color(0xFFFB923C).withAlpha(30),
          const Color(0xFFFB923C),
        ),
      CellState.deleted => (
          '削除済み',
          Colors.white.withAlpha(15),
          Colors.white38,
        ),
      CellState.unregistered => (
          '未登録',
          Colors.white.withAlpha(15),
          Colors.white38,
        ),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: fg.withAlpha(80)),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: fg),
      ),
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
        Icon(Icons.label_outline, size: 18, color: Colors.white.withAlpha(80)),
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              hintText: 'ラベル（壁番号など）',
              isDense: true,
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
            icon: const Icon(Icons.check_rounded,
                color: Color(0xFF4ADE80), size: 20),
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
    final notifier = ref.read(problemDetailProvider(problemKey).notifier);

    return Column(
      children: [
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
              icon: const Icon(Icons.check_rounded, size: 18),
              label: const Text('クリア記録'),
            ),
          ),
        const SizedBox(height: 8),
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
            icon: Icon(
              state == CellState.unregistered || state == CellState.deleted
                  ? Icons.add
                  : Icons.refresh_rounded,
              size: 18,
            ),
            label: Text(
              state == CellState.unregistered || state == CellState.deleted
                  ? '課題を追加'
                  : 'ホールド替え',
            ),
          ),
        ),
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
                side: BorderSide(color: Colors.red.withAlpha(80)),
              ),
              icon: const Icon(Icons.delete_outline, size: 18),
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
        Row(
          children: [
            Text(
              '第 $generationNumber 世代',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white.withAlpha(100),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 8),
            if (isActive)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFF7C6AF5).withAlpha(40),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  '現在',
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFF7C6AF5),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 6),
        if (generation.clearLogs.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            child: Text(
              'クリア記録なし',
              style: TextStyle(
                  fontSize: 13, color: Colors.white.withAlpha(60)),
            ),
          )
        else
          ...generation.clearLogs.reversed.map((log) => _ClearLogTile(
                log: log,
                problemKey: problemKey,
              )),
        Divider(height: 20, color: Colors.white.withAlpha(15)),
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
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Color(0xFF4ADE80),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              _formatDate(log.clearedAt),
              style:
                  TextStyle(fontSize: 13, color: Colors.white.withAlpha(200)),
            ),
          ),
          IconButton(
            icon: Icon(Icons.edit_outlined,
                size: 16, color: Colors.white.withAlpha(80)),
            visualDensity: VisualDensity.compact,
            onPressed: () async {
              final picked = await _pickDateTime(context, log.clearedAt);
              if (picked != null) {
                await notifier.updateClearLogDate(log.id, picked);
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.close_rounded,
                size: 16, color: Colors.red.withAlpha(160)),
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

    return DateTime(
        date.year, date.month, date.day, time.hour, time.minute);
  }
}
