import 'package:a_clock/core/models/settings_model.dart';
import 'package:a_clock/core/services/preferences_service.dart';
import 'package:a_clock/l10n/app_localizations.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';

class SettingsNotifier extends ChangeNotifier {
  late SettingsModel _settings;
  final PreferencesService _preferencesService;

  SettingsModel get settings => _settings;
  ThemeMode get themeMode => _settings.themeMode;
  Locale get locale => _settings.locale ?? const Locale('pt');

  SettingsNotifier(this._preferencesService) {
    _settings = SettingsModel();
    loadSettings();
  }

  Future<void> loadSettings() async {
    _settings = await _preferencesService.loadSettings();
    if (_settings.locale == null) {
      // Detects the device language and chooses one of the supported ones
      final deviceLocale = WidgetsBinding.instance.platformDispatcher.locale;
      final supportedLocales = AppLocalizations.supportedLocales;
      final matchingLocale = supportedLocales.firstWhere(
        (locale) => locale.languageCode == deviceLocale.languageCode,
        orElse: () => const Locale('en'), // Default to English if not found
      );
      _settings = _settings.copyWith(locale: matchingLocale);
    }
    notifyListeners();
  }

  Future<void> updateThemeMode(ThemeMode newThemeMode) async {
    if (newThemeMode == _settings.themeMode) return;
    _settings = _settings.copyWith(themeMode: newThemeMode);
    await _preferencesService.saveSettings(_settings);
    notifyListeners();
  }

  Future<void> updateLocale(Locale newLocale) async {
    if (newLocale == _settings.locale) return;
    _settings = _settings.copyWith(locale: newLocale);
    await _preferencesService.saveSettings(_settings);
    notifyListeners();
  }

  Future<void> updateSettingsModel(SettingsModel newSettings) async {
    // This is now the ONLY way to update settings.
    _settings = newSettings;
    await _preferencesService.saveSettings(_settings);
    notifyListeners();
  }

  Future<void> configureTts(FlutterTts ttsInstance) async {
    final targetLocale = _settings.locale?.toLanguageTag() ?? 'en-US';
    await ttsInstance.setLanguage(targetLocale);
    await ttsInstance.setSpeechRate(0.5);
  }

}
