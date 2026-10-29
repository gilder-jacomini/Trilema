import 'package:flutter/material.dart';

class TrilemaTheme {
  TrilemaTheme._();

  static const Color background = Color(0xFF08090B);
  static const Color surface = Color(0xFF15171B);
  static const Color yellow = Color(0xFFFFD600);
  static const Color blue = Color(0xFF00A8FF);
  static const Color orange = Color(0xFFFF6A00);
  static const Color text = Color(0xFFFFFFFF);
  static const Color mutedText = Color(0xFFB9BBC2);

  static ThemeData get darkTheme {
    final scheme = const ColorScheme.dark(
      primary: yellow,
      secondary: blue,
      tertiary: orange,
      surface: surface,
      onSurface: text,
      onPrimary: background,
      onSecondary: background,
      onTertiary: background,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: scheme,
      scaffoldBackgroundColor: background,
      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        foregroundColor: text,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFF303238)),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: yellow,
          foregroundColor: background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        ),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(color: text, fontWeight: FontWeight.w800),
        headlineMedium: TextStyle(color: text, fontWeight: FontWeight.w700),
        titleLarge: TextStyle(color: text, fontWeight: FontWeight.w700),
        bodyLarge: TextStyle(color: text),
        bodyMedium: TextStyle(color: mutedText),
      ),
    );
  }
}
