import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static const _bgColor = Color(0xFF111318);
  static const _surfaceColor = Color(0xFF16161F);
  static const _primaryColor = Color(0xFF7C6AF5);

  static ThemeData get dark {
    final base = ThemeData.dark(useMaterial3: true);
    final scheme = ColorScheme.fromSeed(
      seedColor: _primaryColor,
      brightness: Brightness.dark,
      surface: _bgColor,
      surfaceContainerLow: _surfaceColor,
      surfaceContainer: _surfaceColor,
      surfaceContainerHigh: const Color(0xFF1E1E2C),
    );

    return base.copyWith(
      colorScheme: scheme,
      scaffoldBackgroundColor: _bgColor,
      cardColor: _surfaceColor,
      dividerColor: const Color(0xFF1E1E2C),
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        backgroundColor: _bgColor,
        foregroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          letterSpacing: -0.01,
        ),
      ),
      cardTheme: CardThemeData(
        color: _surfaceColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFF222230)),
        ),
        margin: EdgeInsets.zero,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: _surfaceColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: _surfaceColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: _primaryColor,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white70,
          side: const BorderSide(color: Color(0xFF2A2A38)),
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
      listTileTheme: const ListTileThemeData(
        iconColor: Color(0xFF888899),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF1E1E2C),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF2A2A38)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF2A2A38)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _primaryColor),
        ),
        hintStyle: const TextStyle(color: Color(0xFF555566)),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: const Color(0xFF2A2A3A),
        contentTextStyle: const TextStyle(color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        behavior: SnackBarBehavior.floating,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: _primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
    );
  }

  // kept for legacy references
  static ThemeData get light => dark;

  static const List<String> gradeColorOptions = [
    'FFEB3B',
    'FF9800',
    'F44336',
    'E91E63',
    '9C27B0',
    '3F51B5',
    '2196F3',
    '00BCD4',
    '4CAF50',
    '8BC34A',
    '795548',
    '607D8B',
  ];
}

Color hexToColor(String hex) {
  final buffer = StringBuffer();
  if (hex.length == 6) buffer.write('ff');
  buffer.write(hex);
  return Color(int.parse(buffer.toString(), radix: 16));
}
