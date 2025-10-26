import 'package:a_clock/features/alarms/model/alarm_model.dart';
import 'package:a_clock/features/alarms/providers/alarm_provider.dart';
import 'package:a_clock/core/themes/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:a_clock/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class AlarmRingingScreen extends StatefulWidget {
  final Alarm alarm;

  const AlarmRingingScreen({super.key, required this.alarm});

  @override
  State<AlarmRingingScreen> createState() => _AlarmRingingScreenState();
}

class _AlarmRingingScreenState extends State<AlarmRingingScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final themeManager = context.watch<ThemeManager>();

    return Scaffold(
      backgroundColor: themeManager.backgroundColor,
      body: GestureDetector(
        onTap: () {
          context.read<AlarmProvider>().stopRinging();
        },
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.alarm.time.format(context),
                style: theme.textTheme.displayLarge?.copyWith(
                  fontSize: 80,
                  color: themeManager.fontColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                widget.alarm.label ?? l10n.alarm,
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: themeManager.fontColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 80),
              FadeTransition(
                opacity: _animation,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.touch_app,
                      size: 60,
                      color: themeManager.accentColor,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      l10n.tapToDismiss,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: themeManager.fontColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
