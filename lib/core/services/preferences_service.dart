import 'package:a_clock/core/models/clock_theme.dart';
import 'package:a_clock/core/models/settings_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const _fontSizeKey = 'fontSize';
  static const _isClockSlidingKey = 'isClockSliding';
  static const _showSecondsInPortraitKey = 'showSecondsInPortrait';
  static const _use24HourFormatKey = 'use24HourFormat';
  static const _showDateKey = 'showDate';
  static const _showAnalogFrameKey = 'showAnalogFrame';
  static const _themeKey = 'theme';
  static const _themeModeKey = 'themeMode';
  static const _languageKey = 'languageCode';
  static const _speakTheTimeKey = 'speakTheTime';

  Future<void> saveSettings(SettingsModel settings) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_fontSizeKey, settings.fontSize);
    await prefs.setBool(_isClockSlidingKey, settings.isClockSliding);
    await prefs.setBool(_showSecondsInPortraitKey, settings.showSecondsInPortrait);
    await prefs.setBool(_use24HourFormatKey, settings.use24HourFormat);
    await prefs.setBool(_showDateKey, settings.showDate);
    await prefs.setBool(_showAnalogFrameKey, settings.showAnalogFrame);
    await prefs.setString(_themeKey, settings.theme.name);
    await prefs.setString(_themeModeKey, settings.themeMode.name);
    if (settings.locale != null) {
      await prefs.setString(_languageKey, settings.locale!.languageCode);
    }
    await prefs.setBool(_speakTheTimeKey, settings.speakTheTime);
  }

  Future<SettingsModel> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    
    return SettingsModel(
      fontSize: prefs.getDouble(_fontSizeKey) ?? 80.0,
      isClockSliding: prefs.getBool(_isClockSlidingKey) ?? false,
      showSecondsInPortrait: prefs.getBool(_showSecondsInPortraitKey) ?? true,
      use24HourFormat: prefs.getBool(_use24HourFormatKey) ?? true,
      showDate: prefs.getBool(_showDateKey) ?? true,
      showAnalogFrame: prefs.getBool(_showAnalogFrameKey) ?? true,
      theme: ClockTheme.values.firstWhere(
        (e) => e.name == (prefs.getString(_themeKey) ?? ClockTheme.flip.name),
        orElse: () => ClockTheme.flip,
      ),
      themeMode: ThemeMode.values.firstWhere(
        (e) => e.name == (prefs.getString(_themeModeKey) ?? ThemeMode.system.name),
        orElse: () => ThemeMode.system,
      ),
      locale: _loadLocale(prefs),
      speakTheTime: prefs.getBool(_speakTheTimeKey) ?? false,
    );
  }

  Locale? _loadLocale(SharedPreferences prefs) {
    final languageCode = prefs.getString(_languageKey);
    if (languageCode != null && languageCode.isNotEmpty) {
      return Locale(languageCode);
    }
    return null;
  }
}
