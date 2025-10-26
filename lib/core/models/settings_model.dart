import 'package:a_clock/core/models/clock_theme.dart';
import 'package:flutter/material.dart';

class SettingsModel {
  final ThemeMode themeMode;
  final Locale? locale;
  final ClockTheme theme;
  final double fontSize;
  final bool isClockSliding;
  final bool showSecondsInPortrait;
  final bool use24HourFormat;
  final bool showDate;
  final bool showAnalogFrame;
  final bool speakTheTime;

  SettingsModel({
    this.themeMode = ThemeMode.system,
    this.locale,
    this.theme = ClockTheme.digital,
    this.fontSize = 80.0,
    this.isClockSliding = false,
    this.showSecondsInPortrait = true,
    this.use24HourFormat = true,
    this.showDate = true,
    this.showAnalogFrame = true,
    this.speakTheTime = false,
  });

  SettingsModel copyWith({
    ThemeMode? themeMode,
    Locale? locale,
    ClockTheme? theme,
    double? fontSize,
    bool? isClockSliding,
    bool? showSecondsInPortrait,
    bool? use24HourFormat,
    bool? showDate,
    bool? showAnalogFrame,
    bool? speakTheTime,
  }) {
    return SettingsModel(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
      theme: theme ?? this.theme,
      fontSize: fontSize ?? this.fontSize,
      isClockSliding: isClockSliding ?? this.isClockSliding,
      showSecondsInPortrait:
          showSecondsInPortrait ?? this.showSecondsInPortrait,
      use24HourFormat: use24HourFormat ?? this.use24HourFormat,
      showDate: showDate ?? this.showDate,
      showAnalogFrame: showAnalogFrame ?? this.showAnalogFrame,
      speakTheTime: speakTheTime ?? this.speakTheTime,
    );
  }

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      themeMode: ThemeMode.values.firstWhere(
          (e) => e.toString() == json['themeMode'],
          orElse: () => ThemeMode.system),
      locale: json['locale'] != null ? Locale(json['locale']) : null,
      theme: ClockTheme.values.firstWhere(
          (e) => e.toString() == json['theme'],
          orElse: () => ClockTheme.digital),
      fontSize: (json['fontSize'] as num?)?.toDouble() ?? 80.0,
      isClockSliding: json['isClockSliding'] as bool? ?? false,
      showSecondsInPortrait: json['showSecondsInPortrait'] as bool? ?? true,
      use24HourFormat: json['use24HourFormat'] as bool? ?? true,
      showDate: json['showDate'] as bool? ?? true,
      showAnalogFrame: json['showAnalogFrame'] as bool? ?? true,
      speakTheTime: json['speakTheTime'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'themeMode': themeMode.toString(),
        'locale': locale?.languageCode,
        'theme': theme.toString(),
        'fontSize': fontSize,
        'isClockSliding': isClockSliding,
        'showSecondsInPortrait': showSecondsInPortrait,
        'use24HourFormat': use24HourFormat,
        'showDate': showDate,
        'showAnalogFrame': showAnalogFrame,
        'speakTheTime': speakTheTime,
      };
}
