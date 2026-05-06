import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1565C0),
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          elevation: 0,
        ),
      );

  /// グレードのカラー候補（16進数文字列）
  static const List<String> gradeColorOptions = [
    'FFEB3B', // Yellow
    'FF9800', // Orange
    'F44336', // Red
    'E91E63', // Pink
    '9C27B0', // Purple
    '3F51B5', // Indigo
    '2196F3', // Blue
    '00BCD4', // Cyan
    '4CAF50', // Green
    '8BC34A', // Light Green
    '795548', // Brown
    '607D8B', // Blue Grey
  ];
}

Color hexToColor(String hex) {
  final buffer = StringBuffer();
  if (hex.length == 6) buffer.write('ff');
  buffer.write(hex);
  return Color(int.parse(buffer.toString(), radix: 16));
}
