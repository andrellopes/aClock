import 'package:flutter/material.dart';

class AppThemePreset {
  final String labelKey;
  final Color background;
  final Color font;
  final Color primary;
  final Color secondary;
  final Color surface;

  const AppThemePreset(
    this.labelKey,
    this.background,
    this.font,
    this.primary,
    this.secondary,
    this.surface,
  );

  Color get accentColor => primary;
  Color get cardColor => surface;
  Color get primaryTextColor => font;
  Color get secondaryTextColor => font.withValues(alpha: 178.5);
  Color get mutedTextColor => font.withValues(alpha: 102.0);
  Color get fontColor => font;
  Color get flipCardColor => surface;

  ThemeData toThemeData() {
    return ThemeData(
      useMaterial3: true,
      brightness: _getBrightness(),
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        brightness: _getBrightness(),
        primary: primary,
        secondary: secondary,
        surface: surface,
        onSurface: font,
      ),
      scaffoldBackgroundColor: background,
    );
  }

  Brightness _getBrightness() {
    return ThemeData.estimateBrightnessForColor(background);
  }
}
