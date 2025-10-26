import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme_preset.dart';
import 'theme_presets.dart';

class ThemeManager extends ChangeNotifier {
  /// Initializes PRO status synchronously. Required before any ThemeManager use!
  void setPremiumStatusSync(bool isPremium) {
    _isPremium = isPremium;
  }
  /// Returns all themes, including premium, without filtering by status.
  List<AppThemePreset> get allThemes => [...clockFreeThemes, ...clockPremiumThemes];
  static const String _themeIndexKey = 'theme_preset_index';

  int _currentThemeIndex = 0;
  bool? _isPremium;
  late AppThemePreset _currentTheme;

  /// PRO status must be set explicitly via setPremiumStatusSync before any use!
  ThemeManager() {
    _currentTheme = defaultTheme;
  }

  int get currentThemeIndex => _currentThemeIndex;
  /// Always use setPremiumStatusSync before any access!
  bool get isPremium {
    assert(_isPremium != null, 'Premium status must be initialized before use!');
    if (_isPremium == null) {
      throw Exception('ThemeManager: premium status not initialized');
    }
    return _isPremium!;
  }
  AppThemePreset get currentTheme => _currentTheme;

  List<AppThemePreset> get availableThemes => getAvailableThemes(isPremium);

  Color get backgroundColor => _currentTheme.background;
  Color get fontColor => _currentTheme.font;
  Color get primaryColor => _currentTheme.primary;
  Color get secondaryColor => _currentTheme.secondary;
  Color get surfaceColor => _currentTheme.surface;
  Color get accentColor => _currentTheme.accentColor;
  Color get cardColor => _currentTheme.cardColor;
  Color get primaryTextColor => _currentTheme.primaryTextColor;
  Color get secondaryTextColor => _currentTheme.secondaryTextColor;
  Color get mutedTextColor => _currentTheme.mutedTextColor;

  /// Call setPremiumStatusSync before calling init!
  Future<void> init() async {
    if (_isPremium == null) {
      throw Exception('ThemeManager.init: premium status not initialized');
    }
    final prefs = await SharedPreferences.getInstance();
    await _loadSettings(prefs);
  }

  Future<void> _loadSettings(SharedPreferences prefs) async {
    _currentThemeIndex = prefs.getInt(_themeIndexKey) ?? 0;
    await _updateCurrentTheme();
    notifyListeners();
  }

  Future<void> setPremiumStatus(bool isPremium) async {
    if (_isPremium != isPremium) {
      _isPremium = isPremium;
      await _validateCurrentTheme();
      notifyListeners();
    }
  }

  Future<void> _validateCurrentTheme() async {
    if (_currentThemeIndex >= availableThemes.length) {
      await setTheme(0);
    }
  }

  Future<void> setTheme(int index) async {
    if (isThemePremium(index) && !isPremium) {
      throw Exception('Premium theme requires upgrade');
    }
    final theme = getThemeByIndex(index, isPremium);
    if (theme != null) {
      _currentThemeIndex = index;
      _currentTheme = theme;
      await _saveThemeIndex(index);
      notifyListeners();
    }
  }

  Future<void> _updateCurrentTheme() async {
    final theme = getThemeByIndex(_currentThemeIndex, isPremium);
    if (theme != null) {
      _currentTheme = theme;
    } else {
      _currentThemeIndex = 0;
      _currentTheme = defaultTheme;
      await _saveThemeIndex(0);
    }
  }

  Future<void> _saveThemeIndex(int index) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeIndexKey, index);
  }

  String getThemeName(String Function(String) localizer) {
    return localizer(_currentTheme.labelKey);
  }

  Future<void> resetToDefault() async {
    await setTheme(0);
  }

  /// Checks if a theme is premium
  bool isThemePremium(int index) {
    return index >= clockFreeThemes.length;
  }

  /// Syncs premium status with PurchaseService
  void syncWithPurchaseService(bool isProVersion) {
    if (_isPremium != isProVersion) {
      _isPremium = isProVersion;
      if (!isProVersion && isThemePremium(_currentThemeIndex)) {
        // If lost PRO and using premium theme, revert to default
        setTheme(0);
      } else if (isProVersion) {
        // If became PRO, restore saved theme (may be premium)
        SharedPreferences.getInstance().then((prefs) async {
          _currentThemeIndex = prefs.getInt(_themeIndexKey) ?? 0;
          await _updateCurrentTheme();
          notifyListeners();
        });
      } else {
        notifyListeners();
      }
    }
  }
}
