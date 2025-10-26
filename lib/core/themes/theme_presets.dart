import 'package:flutter/material.dart';
import 'theme_preset.dart';

const List<AppThemePreset> clockFreeThemes = [
  AppThemePreset(
    'classicBlack',
    Color(0xFF101010),
    Color(0xFFFFFFFF),
    Color(0xFF232323),
    Color(0xFFB0B0B0),
    Color(0xFF2C2C2C),
  ),
  AppThemePreset(
    'modernBlue',
    Color(0xFF0A2342),
    Color(0xFFE3F2FD),
    Color(0xFF1976D2),
    Color(0xFF64B5F6),
    Color(0xFF1565C0),
  ),
  AppThemePreset(
    'minimalWhite',
    Color(0xFFFFFFFF),
    Color(0xFF222222),
    Color(0xFFF5F5F5),
    Color(0xFFBDBDBD),
    Color(0xFFE0E0E0),
  ),
  AppThemePreset(
    'retroGreen',
    Color(0xFF1B2B1B),
    Color(0xFFC8E6C9),
    Color(0xFF388E3C),
    Color(0xFF81C784),
    Color(0xFF2E7D32),
  ),
];

const List<AppThemePreset> clockPremiumThemes = [
  AppThemePreset(
    'goldLuxury',
    Color(0xFF181818),
    Color(0xFFFFD700),
    Color(0xFFB6862C),
    Color(0xFF8D5524),
    Color(0xFF232323),
  ),
  AppThemePreset(
    'spaceGray',
    Color(0xFF23272A),
    Color(0xFFECECEC),
    Color(0xFF4F545C),
    Color(0xFF7289DA),
    Color(0xFF2C2F33),
  ),
  AppThemePreset(
    'roseGold',
    Color(0xFFFDEDEC),
    Color(0xFF6D4C41),
    Color(0xFFE57373),
    Color(0xFFFFBFAE),
    Color(0xFFF8BBD0),
  ),
  AppThemePreset(
    'nightBlue',
    Color(0xFF0D1B2A),
    Color(0xFFB3CDE0),
    Color(0xFF274690),
    Color(0xFF1B263B),
    Color(0xFF415A77),
  ),
  AppThemePreset(
    'ivoryElegance',
    Color(0xFFFFF8E1),
    Color(0xFF3E2723),
    Color(0xFFFFE082),
    Color(0xFFD7CCC8),
    Color(0xFFFFECB3),
  ),
  AppThemePreset(
    'digitalNeon',
    Color(0xFF000000),
    Color(0xFF39FF14),
    Color(0xFF00FFFF),
    Color(0xFFFF00FF),
    Color(0xFF232323),
  ),
  AppThemePreset(
    'copperVintage',
    Color(0xFF4E342E),
    Color(0xFFFFF8E1),
    Color(0xFFB87333),
    Color(0xFFFF7043),
    Color(0xFF6D4C41),
  ),
];

List<AppThemePreset> getAvailableThemes(bool isPremium) {
  return isPremium
      ? [...clockFreeThemes, ...clockPremiumThemes]
      : clockFreeThemes;
}

bool isThemePremium(int index) {
  return index >= clockFreeThemes.length;
}

AppThemePreset? getThemeByIndex(int index, bool isPremium) {
  final availableThemes = getAvailableThemes(isPremium);
  if (index >= 0 && index < availableThemes.length) {
    return availableThemes[index];
  }
  return null;
}

AppThemePreset get defaultTheme => clockFreeThemes[0];
