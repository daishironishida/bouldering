import 'package:flutter/material.dart';

import '../../../core/models/problem.dart';
import '../../../core/theme/app_theme.dart';

const double kCellWidth = 64.0;
const double kCellHeight = 64.0;
const double kGradeColWidth = 72.0;
const double kNumberRowHeight = 28.0;

class GridCell extends StatelessWidget {
  const GridCell({
    super.key,
    required this.problem,
    required this.gradeColorHex,
    required this.onTap,
  });

  final Problem? problem;
  final String gradeColorHex;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final state = problem.cellState;
    final gradeColor = hexToColor(gradeColorHex);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: kCellWidth,
        height: kCellHeight,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300, width: 0.5),
        ),
        child: Column(
          children: [
            // 上 1/3 - 色帯
            SizedBox(
              height: kCellHeight / 3,
              width: double.infinity,
              child: ColoredBox(color: _topColor(state, gradeColor)),
            ),
            // 下 2/3 - 白背景
            Expanded(
              child: ColoredBox(
                color: Colors.white,
                child: _BottomContent(state: state, problem: problem),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _topColor(CellState state, Color gradeColor) {
    switch (state) {
      case CellState.unregistered:
        return const Color(0xFF757575); // 濃いグレー
      case CellState.deleted:
        return const Color(0xFFBDBDBD); // 薄いグレー
      case CellState.uncleared:
        return gradeColor.withAlpha(100);
      case CellState.cleared:
        return gradeColor;
    }
  }
}

class _BottomContent extends StatelessWidget {
  const _BottomContent({required this.state, required this.problem});

  final CellState state;
  final Problem? problem;

  @override
  Widget build(BuildContext context) {
    if (state == CellState.unregistered || state == CellState.deleted) {
      return const SizedBox.expand();
    }

    final label = problem?.activeGeneration?.label ?? '';
    final isCleared = state == CellState.cleared;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // ラベル（左）
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 3, top: 2, bottom: 2),
            child: Text(
              label,
              style: const TextStyle(fontSize: 9, height: 1.2),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        // チェックマーク（右）
        if (isCleared)
          const Padding(
            padding: EdgeInsets.only(right: 3),
            child: Icon(Icons.check_circle, size: 16, color: Color(0xFF2E7D32)),
          ),
      ],
    );
  }
}
