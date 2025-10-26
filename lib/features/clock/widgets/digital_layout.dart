import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:a_clock/core/themes/theme_manager.dart';

class DigitalClockLayout extends StatelessWidget {
  final Stream<DateTime> timeStream;
  final double fontSize;
  final bool showSecondsInPortrait;
  final bool showDate;
  final bool use24HourFormat;

  const DigitalClockLayout({
    super.key,
    required this.timeStream,
    required this.fontSize,
    required this.showSecondsInPortrait,
    required this.showDate,
    required this.use24HourFormat,
  });

  @override
  Widget build(BuildContext context) {
    // Gets the active theme
    final themeManager = Provider.of<ThemeManager>(context, listen: true);
    final theme = themeManager.currentTheme;

    return StreamBuilder<DateTime>(
      stream: timeStream,
      initialData: DateTime.now(),
      builder: (context, snapshot) {
        final now = snapshot.data ?? DateTime.now();
        final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
        final showSeconds = isPortrait ? showSecondsInPortrait : true;
        final locale = Localizations.localeOf(context).toLanguageTag();

        String timePattern = use24HourFormat ? 'HH:mm' : 'hh:mm';
        if (showSeconds) {
          timePattern += ':ss';
        }

        final timeString = DateFormat(timePattern, locale).format(now);
        String? amPmString;
        if (!use24HourFormat) {
          amPmString = DateFormat('a', locale).format(now);
        }

        final dateStr = showDate ? DateFormat.yMMMMEEEEd(locale).format(now) : null;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  timeString,
                  style: TextStyle(
                    fontSize: fontSize,
                    color: theme.fontColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (amPmString != null) ...[
                  const SizedBox(width: 8),
                  Text(
                    amPmString,
                    style: TextStyle(
                      fontSize: fontSize / 2,
                      color: theme.fontColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ],
            ),
            if (dateStr != null) ...[
              const SizedBox(height: 20),
              Text(
                dateStr,
                textAlign: TextAlign.center,
                style: TextStyle(color: theme.fontColor, fontSize: fontSize / 4),
              ),
            ],
          ],
        );
      },
    );
  }
}
