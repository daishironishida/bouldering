import 'package:flutter/material.dart';

import '../../../core/models/problem.dart';
import '../../../core/theme/app_theme.dart';

const double kCellWidth = 56.0;
const double kCellHeight = 48.0;
const double kGradeColWidth = 68.0;
const double kNumberRowHeight = 28.0;
const double kCellGap = 4.0;
const double kCellRadius = 10.0;

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
          color: _bgColor(state, gradeColor),
          borderRadius: BorderRadius.circular(kCellRadius),
          border: state == CellState.unregistered
              ? null
              : null,
        ),
        child: _CellContent(state: state, problem: problem, gradeColor: gradeColor),
      ),
    );
  }

  Color _bgColor(CellState state, Color gradeColor) {
    switch (state) {
      case CellState.unregistered:
        return const Color(0xFF16161F);
      case CellState.deleted:
        return const Color(0xFF16161F);
      case CellState.uncleared:
        return gradeColor.withAlpha(60);
      case CellState.cleared:
        return gradeColor;
    }
  }
}

class _CellContent extends StatelessWidget {
  const _CellContent({
    required this.state,
    required this.problem,
    required this.gradeColor,
  });

  final CellState state;
  final Problem? problem;
  final Color gradeColor;

  @override
  Widget build(BuildContext context) {
    if (state == CellState.unregistered || state == CellState.deleted) {
      return const SizedBox.expand();
    }

    final area = problem?.activeGeneration?.area ?? '';
    final isCleared = state == CellState.cleared;

    return Stack(
      children: [
        if (area.isNotEmpty)
          Positioned(
            bottom: 4,
            left: 6,
            child: Text(
              area,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: isCleared
                    ? Colors.white.withAlpha(220)
                    : Colors.white.withAlpha(180),
              ),
            ),
          ),
        if (isCleared)
          const Positioned(
            bottom: 4,
            right: 5,
            child: Icon(Icons.check_rounded, size: 14, color: Colors.white),
          ),
      ],
    );
  }
}
