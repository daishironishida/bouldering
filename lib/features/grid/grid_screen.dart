import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/models/grade_config.dart';
import '../../core/models/problem.dart';
import '../../core/theme/app_theme.dart';
import '../problem_detail/problem_detail_sheet.dart';
import 'grid_provider.dart';
import 'widgets/grid_cell.dart';

class GridScreen extends ConsumerStatefulWidget {
  const GridScreen({super.key, required this.gymId});

  final String gymId;

  @override
  ConsumerState<GridScreen> createState() => _GridScreenState();
}

class _GridScreenState extends ConsumerState<GridScreen> {
  final _headerScrollController = ScrollController();
  final _bodyScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _bodyScrollController.addListener(() {
      if (_headerScrollController.hasClients) {
        _headerScrollController.jumpTo(_bodyScrollController.offset);
      }
    });
  }

  @override
  void dispose() {
    _headerScrollController.dispose();
    _bodyScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gymAsync = ref.watch(gymProvider(widget.gymId));

    return Scaffold(
      appBar: AppBar(
        title: gymAsync.maybeWhen(
          data: (gym) => Text(gym.name),
          orElse: () => const Text('グリッド'),
        ),
        actions: [
          gymAsync.maybeWhen(
            data: (gym) => IconButton(
              icon: const Icon(Icons.settings_outlined),
              onPressed: () =>
                  context.push('/gym/${widget.gymId}/settings'),
            ),
            orElse: () => const SizedBox.shrink(),
          ),
        ],
      ),
      body: gymAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('エラー: $e')),
        data: (gym) {
          if (gym.grades.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.grid_view_rounded,
                      size: 48, color: Colors.white.withAlpha(30)),
                  const SizedBox(height: 16),
                  Text(
                    'グレードが設定されていません',
                    style: TextStyle(color: Colors.white.withAlpha(80)),
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () =>
                        context.push('/gym/${widget.gymId}/settings'),
                    child: const Text('設定する'),
                  ),
                ],
              ),
            );
          }
          final problems = ref.watch(gymProblemsProvider(widget.gymId));
          return _buildGrid(gym.grades, problems);
        },
      ),
    );
  }

  int _effectiveColumnCount(GradeConfig grade, Map<String, Problem> problems) {
    int maxNum = grade.problemCount;
    for (final entry in problems.entries) {
      if (entry.key.startsWith('${grade.id}_')) {
        maxNum = math.max(maxNum, entry.value.number);
      }
    }
    return maxNum;
  }

  Widget _buildGrid(List<GradeConfig> grades, Map<String, Problem> problems) {
    final maxProblems = grades.fold(
        0, (max, g) => math.max(max, _effectiveColumnCount(g, problems)));

    return Column(
      children: [
        // ─── 番号ヘッダー行（固定） ──────────────────────────────
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 4),
          child: Row(
            children: [
              SizedBox(width: kGradeColWidth + 12),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  controller: _headerScrollController,
                  physics: const NeverScrollableScrollPhysics(),
                  child: Row(
                    children: List.generate(maxProblems, (i) {
                      return SizedBox(
                        width: kCellWidth + kCellGap,
                        child: Center(
                          child: Text(
                            '${i + 1}',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: Colors.white.withAlpha(80),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
        // ─── グリッド本体 ──────────────────────────────────────
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // グレードピル（固定左列）
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: grades.map((grade) {
                      final color = hexToColor(grade.colorHex);
                      return Container(
                        width: kGradeColWidth - 4,
                        height: kCellHeight,
                        margin: const EdgeInsets.only(bottom: kCellGap),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(kCellRadius),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          grade.name,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: 0.02,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
                  ),
                ),
                // セル本体（横スクロール）
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    controller: _bodyScrollController,
                    child: Column(
                      children: grades.map((grade) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: kCellGap),
                          child: _GradeRow(
                            gymId: widget.gymId,
                            grade: grade,
                            columnCount:
                                _effectiveColumnCount(grade, problems),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _GradeRow extends ConsumerWidget {
  const _GradeRow({
    required this.gymId,
    required this.grade,
    required this.columnCount,
  });

  final String gymId;
  final GradeConfig grade;
  final int columnCount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final problems = ref.watch(gymProblemsProvider(gymId));

    return Row(
      children: List.generate(columnCount, (i) {
        final number = i + 1;
        final problem = problems['${grade.id}_$number'];
        return Padding(
          padding: const EdgeInsets.only(right: kCellGap),
          child: GridCell(
            problem: problem,
            gradeColorHex: grade.colorHex,
            onTap: () => _openDetail(context, ref, number),
          ),
        );
      }),
    );
  }

  void _openDetail(BuildContext context, WidgetRef ref, int number) {
    if (kIsWeb) {
      showDialog<void>(
        context: context,
        builder: (context) => Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560, maxHeight: 700),
            child: ProblemDetailSheet(
              gymId: gymId,
              gradeId: grade.id,
              gradeName: grade.name,
              number: number,
            ),
          ),
        ),
      );
    } else {
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        builder: (context) => ProblemDetailSheet(
          gymId: gymId,
          gradeId: grade.id,
          gradeName: grade.name,
          number: number,
        ),
      );
    }
  }
}
