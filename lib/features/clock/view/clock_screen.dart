import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import 'package:keep_screen_on/keep_screen_on.dart';
import 'package:a_clock/core/models/clock_theme.dart';
import 'package:a_clock/features/settings/view/settings_screen.dart';
import 'package:a_clock/features/settings/logic/settings_notifier.dart';
import 'package:a_clock/features/clock/widgets/digital_layout.dart';
import 'package:a_clock/features/clock/widgets/flip_layout.dart';
import 'package:a_clock/features/clock/widgets/analog_layout.dart';
import 'package:a_clock/features/clock/widgets/robot_speaking_widget.dart';
import 'package:a_clock/l10n/app_localizations.dart';
import 'package:a_clock/core/models/settings_model.dart';
import 'package:a_clock/core/services/purchase_service.dart';
import 'package:a_clock/core/themes/theme_manager.dart';
import 'package:a_clock/core/services/ad_config_service.dart';

class ClockScreen extends StatefulWidget {
  const ClockScreen({super.key});

  @override
  _ClockScreenState createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> with TickerProviderStateMixin {
  BannerAd? _bannerAd;
  bool _isBannerAdLoaded = false;
  Timer? _bannerAdTimer;
  bool _showBannerAd = false;
  bool _showSettingsButton = false;
  final FlutterTts flutterTts = FlutterTts();
  OverlayEntry? _robotOverlayEntry;
  Timer? _robotOverlayTimeoutTimer;
  
  // Centralized time management
  final _timeController = StreamController<DateTime>.broadcast();
  Timer? _timer;
  
  late AnimationController _controller;
  late Animation<Offset> _animation;
  Timer? _settingsButtonTimer;

  @override
  void initState() {
    // Temporarily disabled AdMob for clock screen
    if (1 != 2) {
      // Initializes AdMob
      MobileAds.instance.initialize();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _loadBannerAd();
      });
    }
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<Offset>(
      begin: const Offset(-0.10, 0),
      end: const Offset(0.10, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        _timeController.sink.add(DateTime.now());
      }
    });

    _timeController.stream.listen(_onTimeChange);

    if (Platform.isAndroid) {
      KeepScreenOn.turnOn();
    }
  }

  void _loadBannerAd() async {
    // Temporarily disabled AdMob for clock screen
    if (1 == 2) return;

    // 🆕 Does not load ads for PRO users
    final purchaseService = context.read<PurchaseService>();
    if (purchaseService.isProVersion) {
      debugPrint('PRO user - skipping ad loading');
      return;
    }

    // Calculate maximum available width (same logic as UI)
    final mediaQuery = MediaQuery.of(context);
    final isPortrait = mediaQuery.orientation == Orientation.portrait;
    final maxWidth = isPortrait
        ? mediaQuery.size.width - 32
        : (mediaQuery.size.width > 400 ? 400 : mediaQuery.size.width - 32);

    debugPrint('Trying adaptive banner with max width: $maxWidth');

    final adSize = await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
      maxWidth.truncate()
    );

    if (adSize == null || adSize.width > maxWidth) {
      final adUnitId = await AdConfigService.instance.getBannerAndroid();
      debugPrint('Adaptive size not available or too big, using standard banner');
      _bannerAd = BannerAd(
        adUnitId: adUnitId, // read from assets/config if exists, otherwise TEST ID
        request: const AdRequest(),
        size: AdSize.banner,
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            debugPrint('Standard BannerAd loaded');
            setState(() {
              _isBannerAdLoaded = true;
            });
          },
          onAdFailedToLoad: (ad, error) {
            debugPrint('Failed to load standard BannerAd: $error');
            ad.dispose();
          },
        ),
      )..load();
      return;
    }

    debugPrint('Using adaptive size: ${adSize.width}x${adSize.height}');
    final adUnitId = await AdConfigService.instance.getBannerAndroid();
    _bannerAd = BannerAd(
      adUnitId: adUnitId, // read from assets/config if exists, otherwise TEST ID
      request: const AdRequest(),
      size: adSize,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          debugPrint('Adaptive BannerAd loaded: ${_bannerAd!.size.width}x${_bannerAd!.size.height}');
          setState(() {
            _isBannerAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('Failed to load adaptive BannerAd: $error');
          ad.dispose();
        },
      ),
    )..load();
  }

  @override
  void dispose() {
  _bannerAdTimer?.cancel();
  _bannerAd?.dispose();
    _controller.dispose();
    _settingsButtonTimer?.cancel();
    _robotOverlayTimeoutTimer?.cancel();
    _timer?.cancel();
    _timeController.close();
    flutterTts.stop();

    try {
      _robotOverlayEntry?.remove();
      _robotOverlayEntry = null;
    } catch (e) {
      debugPrint('Error removing robot overlay on dispose: $e');
    }

    if (Platform.isAndroid) {
      KeepScreenOn.turnOff();
    }

    super.dispose();
  }

  void _onTimeChange(DateTime now) {
    // Temporarily disabled AdMob for clock screen
    if (1 == 2) {
      // BannerAd: shows only at minutes 15, 30, 45
      if ([15, 30, 45].contains(now.minute) && now.second == 0) {
        if (!_showBannerAd && _isBannerAdLoaded) {
          setState(() => _showBannerAd = true);
          _bannerAdTimer?.cancel();
          _bannerAdTimer = Timer(const Duration(minutes: 1), () {
            if (mounted) setState(() => _showBannerAd = false);
          });
        }
      }
      // Hides BannerAd if past the minute
      if (_showBannerAd && ![15, 30, 45].contains(now.minute)) {
        setState(() => _showBannerAd = false);
        _bannerAdTimer?.cancel();
      }
    }
    if (!mounted) return;
    final settings = context.read<SettingsNotifier>().settings;
    if (settings.speakTheTime && now.minute == 0 && now.second == 0) {
      _speakTimeWithoutUI(now);
    }
  }

 Future<void> _configureAndSpeak(String textToSpeak) async {
    try {
      final settingsNotifier = context.read<SettingsNotifier>();
      await settingsNotifier.configureTts(flutterTts);
      
      // 🆕 Sets error handler for TTS
      flutterTts.setErrorHandler((msg) {
        debugPrint("TTS Error in clock: $msg");
        // Removes overlay if TTS fails
        if (_robotOverlayEntry != null) {
          _removeRobotOverlay();
        }
      });
      
      await flutterTts.speak(textToSpeak);
    } catch (e) {
      debugPrint('Error with TTS in clock: $e');
      // Removes overlay if TTS fails
      if (_robotOverlayEntry != null) {
        _removeRobotOverlay();
      }
    }
  }

  String _getSpokenTimeString(DateTime time) {
    final l10n = AppLocalizations.of(context)!;
    final settings = context.read<SettingsNotifier>().settings;
    final locale = settings.locale?.languageCode ?? l10n.localeName;

    final int hour = time.hour;
    final int minute = time.minute;

    // --- Portuguese Custom Logic ---
    if (locale == 'pt') {
      final String spokenHour = l10n.timeInHours(hour.toString());
      final String spokenMinutes = l10n.timeInMinutes(minute.toString());

      if (minute == 0) {
        if (hour == 1 || hour == 13) return 'É uma hora';
        return 'São $spokenHour horas';
      } else {
        if (hour == 1 || hour == 13) return 'É uma e $spokenMinutes';
        return l10n.timeIs(spokenHour, spokenMinutes);
      }
    }

    // --- Spanish Custom Logic (to fix grammar) ---
    if (locale == 'es') {
      final String spokenHour = l10n.timeInHours(hour.toString());
      final String spokenMinutes = l10n.timeInMinutes(minute.toString());

      if (hour == 1 || hour == 13) {
        if (minute == 0) return 'Es la una en punto';
        return 'Es la una y $spokenMinutes';
      }
      
      if (minute == 0) return l10n.timeIsExactly(spokenHour);
      return l10n.timeIs(spokenHour, spokenMinutes);
    }

    // --- Default Logic for English and other languages ---
    final hourString = l10n.timeInHours(hour.toString());
    final minuteString = l10n.timeInMinutes(minute.toString());

    if (minute == 0) {
      return l10n.timeIsExactly(hourString);
    } else {
      return l10n.timeIs(hourString, minuteString);
    }
  }

  Future<void> _speakTimeWithoutUI(DateTime time) async {
    await _configureAndSpeak(_getSpokenTimeString(time));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final settingsNotifier = context.watch<SettingsNotifier>();
    final themeManager = context.watch<ThemeManager>();
    final theme = themeManager.currentTheme;

    final mediaQuery = MediaQuery.of(context);
    final isPortrait = mediaQuery.orientation == Orientation.portrait;
    double adWidth = isPortrait
        ? mediaQuery.size.width - 32
        : (mediaQuery.size.width > 400 ? 400 : mediaQuery.size.width - 32);

    return Scaffold(
      body: GestureDetector(
        onDoubleTap: _speakCurrentTime,
        onTap: _toggleSettingsButton,
        child: Stack(
          children: [
            Container(
              color: theme.background,
              child: SafeArea(
                left: false,
                right: false,
                top: false,
                bottom: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Center(
                        child: _buildClockWidget(settingsNotifier),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AnimatedOpacity(
              opacity: _showSettingsButton ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: Align(
                alignment: Alignment.topRight,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      icon: Icon(Icons.settings, color: theme.fontColor.withValues(alpha: 179)),
                      iconSize: 32,
                      onPressed: _showSettingsButton
                          ? () => _navigateToSettings(context)
                          : null,
                      tooltip: l10n.settingsTooltip,
                    ),
                  ),
                ),
              ),
            ),
            // Adaptive BannerAd overlaid at the bottom
            Consumer<PurchaseService>(
              builder: (context, purchaseService, child) {
                if (!purchaseService.isProVersion && _showBannerAd && _isBannerAdLoaded && _bannerAd != null) {
                  return Positioned(
                    left: (mediaQuery.size.width - adWidth) / 2,
                    right: (mediaQuery.size.width - adWidth) / 2,
                    bottom: mediaQuery.padding.bottom + 8,
                    child: Container(
                      width: adWidth,
                      height: _bannerAd!.size.height.toDouble(), // Dynamic height based on the ad
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(0), // Straight corners
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 25.5),
                            blurRadius: 12,
                            offset: Offset(0, -2),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(0), // Straight corners
                        child: AdWidget(ad: _bannerAd!),
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClockWidget(SettingsNotifier settingsNotifier) {
    final settings = settingsNotifier.settings;
    Widget clockLayout;

    switch (settings.theme) {
      case ClockTheme.digital:
        clockLayout = DigitalClockLayout(
          timeStream: _timeController.stream,
          fontSize: settings.fontSize,
          showSecondsInPortrait: settings.showSecondsInPortrait,
          showDate: settings.showDate,
          use24HourFormat: settings.use24HourFormat,
        );
        break;
      case ClockTheme.flip:
        clockLayout = FlipClockLayout(
          timeStream: _timeController.stream,
          fontSize: settings.fontSize,
          showSecondsInPortrait: settings.showSecondsInPortrait,
          showDate: settings.showDate,
          use24HourFormat: settings.use24HourFormat,
        );
        break;
      case ClockTheme.analog:
        clockLayout = AnalogClockLayout(
          timeStream: _timeController.stream,
          fontSize: settings.fontSize,
          showDate: settings.showDate,
          numeralType: AnalogNumeralType.arabic,
          showFrame: settings.showAnalogFrame,
        );
        break;
      case ClockTheme.analogRoman:
        clockLayout = AnalogClockLayout(
          timeStream: _timeController.stream,
          fontSize: settings.fontSize,
          showDate: settings.showDate,
          numeralType: AnalogNumeralType.roman,
          showFrame: settings.showAnalogFrame,
        );
        break;
    }

    if (settings.isClockSliding && settings.theme == ClockTheme.digital) {
      return SlideTransition(position: _animation, child: clockLayout);
    } else {
      return clockLayout;
    }
  }

  Future<void> _navigateToSettings(BuildContext context) async {
    final settingsNotifier = context.read<SettingsNotifier>();

    // 🆕 Cancels timer and hides button before navigating
    _settingsButtonTimer?.cancel();
    setState(() => _showSettingsButton = false);

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              SettingsScreen(initialSettings: settingsNotifier.settings)),
    );

    if (result is SettingsModel) {
      await settingsNotifier.updateSettingsModel(result);
      // Success message removed, as settings are saved instantly
    }
  }

  void _toggleSettingsButton() {
    if (!mounted) return; // 🆕 Additional safety check
    
    setState(() {
      _showSettingsButton = !_showSettingsButton;
    });

    // 🆕 Always cancels previous timer to avoid conflicts
    _settingsButtonTimer?.cancel();
    _settingsButtonTimer = null;
    
    if (_showSettingsButton) {
      debugPrint('Settings button shown, starting 4s timer');
      _settingsButtonTimer = Timer(const Duration(seconds: 4), () {
        debugPrint('Settings button timer expired, hiding button');
        if (mounted) {
          setState(() => _showSettingsButton = false);
          _settingsButtonTimer = null;
        }
      });
    } else {
      debugPrint('Settings button hidden manually');
    }
  }

  void _removeRobotOverlay() {
    debugPrint('Removing robot overlay...');
    
    // 🆕 Cancels timeout timer if exists
    _robotOverlayTimeoutTimer?.cancel();
    _robotOverlayTimeoutTimer = null;
    
    Future.microtask(() {
      if (mounted && _robotOverlayEntry != null) {
        try {
          _robotOverlayEntry!.remove();
          _robotOverlayEntry = null;
          debugPrint('Robot overlay removed successfully');
        } catch (e) {
          debugPrint('Error removing robot overlay: $e');
          _robotOverlayEntry = null; // Clear reference even on error
        }
      }
    });
  }

  Future<void> _speakCurrentTime() async {
    if (_robotOverlayEntry != null) {
      debugPrint('Robot overlay already active, ignoring request');
      return;
    }

    debugPrint('Creating robot overlay...');
    _robotOverlayEntry = OverlayEntry(
      builder: (context) => Stack(
        alignment: Alignment.center,
        children: [
          GestureDetector(
            onTap: _removeRobotOverlay,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                color: Colors.black.withValues(alpha: 153),
              ),
            ),
          ),
          RobotSpeakingWidget(
            flutterTts: flutterTts,
            onSpeechComplete: _removeRobotOverlay,
          ),
        ],
      ),
    );

    try {
      Overlay.of(context).insert(_robotOverlayEntry!);
      debugPrint('Robot overlay inserted');
      
      // 🆕 Safety timer to remove overlay after 30 seconds
      _robotOverlayTimeoutTimer = Timer(const Duration(seconds: 30), () {
        debugPrint('Robot overlay timeout - removing overlay');
        _removeRobotOverlay();
      });

      final textToSpeak = _getSpokenTimeString(DateTime.now());
      await _configureAndSpeak(textToSpeak);
    } catch (e) {
      debugPrint('Error creating robot overlay: $e');
      _removeRobotOverlay();
    }
  }
}
