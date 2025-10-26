/// Local secrets used at build time. This file is intentionally kept in the
/// repository with Google's TEST AdMob unit IDs so the project compiles safely
/// without exposing real credentials. Override via --dart-define or
/// assets/config/admob.json (see README).

class AdMobConfig {
  // Android banner Ad Unit
  // Override at build time: --dart-define=ADMOB_BANNER_ANDROID=...
  static const String bannerAndroid = String.fromEnvironment(
    'ADMOB_BANNER_ANDROID',
    defaultValue: 'ca-app-pub-3940256099942544/6300978111',
  );

  // Optional: second placement (e.g., Settings screen)
  // Override at build time: --dart-define=ADMOB_BANNER_SETTINGS_ANDROID=...
  static const String bannerSettingsAndroid = String.fromEnvironment(
    'ADMOB_BANNER_SETTINGS_ANDROID',
    defaultValue: 'ca-app-pub-3940256099942544/6300978111',
  );

  // Future iOS support: use test ID as default
  // static const String bannerIOS = 'ca-app-pub-3940256099942544/2934735716';
}
