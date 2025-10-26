import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:a_clock/l10n/app_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import 'package:a_clock/core/services/preferences_service.dart';
import 'package:a_clock/core/services/purchase_service.dart';
import 'package:a_clock/features/settings/logic/settings_notifier.dart';
import 'package:a_clock/features/alarms/providers/alarm_provider.dart';
import 'package:a_clock/features/alarms/view/alarm_ringing_screen.dart';
import 'package:a_clock/features/clock/view/clock_screen.dart';

import 'package:a_clock/core/themes/theme_manager.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'firebase_options.dart';

/// Modern immersive UI configuration compatible with Android 15
Future<void> _configureSystemUI() async {
  // Uses modern approach to hide system UI
  // Avoids deprecated APIs like setStatusBarColor/setNavigationBarColor

  if (Platform.isAndroid || Platform.isIOS) {
    // Immersive mode without deprecated APIs
    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersiveSticky,
      overlays: [], // Remove system overlays
    );

    // Additional configuration for transparency (Android 15 compatible)
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarDividerColor: Colors.transparent,
        // Additional settings for edge-to-edge SDK 35
        systemStatusBarContrastEnforced: false,
        systemNavigationBarContrastEnforced: false,
      ),
    );
  }
}

void main() {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Handle platform errors (native/Flutter)
    PlatformDispatcher.instance.onError = (error, stack) {
      debugPrint('PlatformDispatcher caught: $error');

      final isCrashlyticsSupported =
          !kIsWeb && (Platform.isAndroid || Platform.isIOS || Platform.isMacOS);

      if (isCrashlyticsSupported) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      }

      return true; // Prevent crash
    };

    // Initialize Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    final isCrashlyticsSupported =
        !kIsWeb && (Platform.isAndroid || Platform.isIOS || Platform.isMacOS);

    if (isCrashlyticsSupported) {
      if (kDebugMode) {
        await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
      }

      FlutterError.onError = (errorDetails) {
        FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      };
    }

    // Initialize localizations for dates
    for (final locale in AppLocalizations.supportedLocales) {
      await initializeDateFormatting(locale.toLanguageTag());
    }

    // Modern immersive UI configuration (Android 15 compatible)
    await _configureSystemUI();

    // Initialize ads only on mobile
    if (Platform.isAndroid || Platform.isIOS) {
      await MobileAds.instance.initialize();
    }

    // Initialize PurchaseService and load PRO status before ThemeManager
    final purchaseService = PurchaseService();
    await purchaseService.loadPurchaseStatusSync();

    final themeManager = ThemeManager();
    themeManager.setPremiumStatusSync(purchaseService.isProVersion);
    await themeManager.init();

    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => SettingsNotifier(PreferencesService()),
          ),
          ChangeNotifierProxyProvider<SettingsNotifier, AlarmProvider>(
            create: (_) => AlarmProvider(),
            update: (_, settings, alarmProvider) =>
                alarmProvider!..setSettingsNotifier(settings),
          ),
          // ThemeManager Provider already initialized
          ChangeNotifierProvider.value(
            value: themeManager,
          ),
          // PurchaseService Provider
          ChangeNotifierProvider.value(
            value: purchaseService,
          ),
        ],
        child: const MyApp(),
      ),
    );
  }, (error, stack) {
    debugPrint('Zoned error: $error');

    final isCrashlyticsSupported =
        !kIsWeb && (Platform.isAndroid || Platform.isIOS || Platform.isMacOS);
    if (isCrashlyticsSupported) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsNotifier>();
    final alarmProvider = context.watch<AlarmProvider>();
    final themeManager = context.watch<ThemeManager>();
    final purchaseService = context.watch<PurchaseService>();

    // Sync ThemeManager with PRO status from PurchaseService
    WidgetsBinding.instance.addPostFrameCallback((_) {
      themeManager.syncWithPurchaseService(purchaseService.isProVersion);
    });

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: settings.locale,
      theme: themeManager.currentTheme.toThemeData(),
      darkTheme: themeManager.currentTheme.toThemeData(),
      themeMode: settings.themeMode,
      home: Stack(
        children: [
          const ClockScreen(),
          if (alarmProvider.ringingAlarm != null)
            AlarmRingingScreen(
              alarm: alarmProvider.ringingAlarm!,
            ),
        ],
      ),
    );
  }
}
