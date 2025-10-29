import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/foundation.dart';
import 'package:a_clock/secrets.dart';

/// Loads optional local AdMob config from assets/config/admob.json.
/// Falls back to safe defaults in AdMobConfig if file is missing or invalid.
class AdConfigService {
  AdConfigService._();
  static final AdConfigService instance = AdConfigService._();

  Map<String, dynamic>? _config;
  bool _loaded = false;

  Future<void> _loadIfNeeded() async {
    if (_loaded) return;
    _loaded = true;
    try {
      final jsonStr = await rootBundle.loadString('assets/config/admob.json');
      _config = json.decode(jsonStr) as Map<String, dynamic>;
      debugPrint('AdConfigService: Successfully loaded JSON config');
    } catch (e) {
      debugPrint('AdConfigService: Failed to load JSON: $e');
      _config = null;
    }
  }

  Future<String> getBannerAndroid() async {
    await _loadIfNeeded();
    final v = _config?['bannerAndroid'];
    if (v is String && v.trim().isNotEmpty) {
      debugPrint('AdConfigService: Using JSON bannerAndroid: ${v.trim()}');
      return v.trim();
    }
    debugPrint('AdConfigService: Using default TEST bannerAndroid: ${AdMobConfig.bannerAndroid}');
    return AdMobConfig.bannerAndroid;
  }

  Future<String> getBannerSettingsAndroid() async {
    await _loadIfNeeded();
    final v = _config?['bannerSettingsAndroid'];
    if (v is String && v.trim().isNotEmpty) return v.trim();
    return AdMobConfig.bannerSettingsAndroid;
  }
}
