import 'package:flutter/material.dart';

// Enum for alarm sound type
enum AlarmSoundType {
  beep,
  textToSpeech,
}

// Enum for alarm stop condition
enum AlarmStopCondition {
  onInteraction,
  afterRepetitions,
}

class Alarm {
  final String id;
  final TimeOfDay time;
  final bool isActive;
  final String? label;

  // --- NEW PROPERTIES ---

  // 1. Sound type choice
  final AlarmSoundType soundType;
  final String? textToSpeak; // Used if soundType is textToSpeech

  // 2. Days of the week to repeat
  // We use a Set<int> where 1=Monday, 7=Sunday (DateTime.weekday standard)
  final Set<int> daysOfWeek;

  // 3. Stop condition
  final AlarmStopCondition stopCondition;
  final int? maxRepetitions; // Used if stopCondition is afterRepetitions

  // 4. Specific sound
  final String? soundAsset; // Path to the sound, e.g., 'assets/sounds/rooster.mp3'

  /// Normalizes the sound path to ensure it has the 'assets/' prefix
  static String? _normalizeSoundPath(String? soundAsset) {
    if (soundAsset == null || soundAsset.isEmpty) return soundAsset;
    
    // If it already has the correct prefix, return as is
    if (soundAsset.startsWith('assets/')) {
      return soundAsset;
    }
    
    // If it starts with 'sounds/', add 'assets/' at the beginning
    if (soundAsset.startsWith('sounds/')) {
      return 'assets/$soundAsset';
    }
    
    // If it's just the filename, add the full path
    if (!soundAsset.contains('/')) {
      return 'assets/sounds/$soundAsset';
    }
    
    // General case: add 'assets/' at the beginning
    return 'assets/$soundAsset';
  }

  /// Getter that always returns the normalized path
  String? get normalizedSoundAsset => _normalizeSoundPath(soundAsset);

  Alarm({
    required this.id,
    required this.time,
    this.isActive = true,
    this.label,
    // --- NEW PARAMETERS IN CONSTRUCTOR ---
    this.soundType = AlarmSoundType.beep,
    this.textToSpeak,
    this.daysOfWeek = const {}, // Empty means it doesn't repeat weekly
    this.stopCondition = AlarmStopCondition.onInteraction,
    this.maxRepetitions,
    this.soundAsset,
  })  : assert(soundType == AlarmSoundType.textToSpeech ? textToSpeak != null : true,
            'textToSpeak cannot be null if soundType is textToSpeech'),
        assert(
            stopCondition == AlarmStopCondition.afterRepetitions ? maxRepetitions != null && maxRepetitions > 0 : true,
            'maxRepetitions must be a positive number if stopCondition is afterRepetitions');

  // The `copyWith` method is very useful for updating state immutably.
  Alarm copyWith({
    String? id,
    TimeOfDay? time,
    bool? isActive,
    String? label,
    AlarmSoundType? soundType,
    String? textToSpeak,
    Set<int>? daysOfWeek,
    AlarmStopCondition? stopCondition,
    int? maxRepetitions,
    String? soundAsset,
  }) {
    return Alarm(
      id: id ?? this.id,
      time: time ?? this.time,
      isActive: isActive ?? this.isActive,
      label: label ?? this.label,
      soundType: soundType ?? this.soundType,
      textToSpeak: textToSpeak ?? this.textToSpeak,
      daysOfWeek: daysOfWeek ?? this.daysOfWeek,
      stopCondition: stopCondition ?? this.stopCondition,
      maxRepetitions: maxRepetitions ?? this.maxRepetitions,
      soundAsset: soundAsset ?? this.soundAsset,
    );
  }

  /// Creates an Alarm instance from a JSON map.
  factory Alarm.fromJson(Map<String, dynamic> json) {
    return Alarm(
      id: json['id'],
      time: TimeOfDay(hour: json['hour'], minute: json['minute']),
      isActive: json['isActive'] ?? true,
      label: json['label'],
      soundType: AlarmSoundType.values.byName(json['soundType'] ?? 'beep'),
      textToSpeak: json['textToSpeak'],
      daysOfWeek: Set<int>.from(json['daysOfWeek']?.cast<int>() ?? []),
      stopCondition: AlarmStopCondition.values
          .byName(json['stopCondition'] ?? 'onInteraction'),
      maxRepetitions: json['maxRepetitions'],
      // 🆕 Normalizes the sound path during loading
      soundAsset: _normalizeSoundPath(json['soundAsset']),
    );
  }

  /// Converts an Alarm instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'hour': time.hour,
      'minute': time.minute,
      'isActive': isActive,
      'label': label,
      'soundType': soundType.name,
      'textToSpeak': textToSpeak,
      'daysOfWeek': daysOfWeek.toList(),
      'stopCondition': stopCondition.name,
      'maxRepetitions': maxRepetitions,
      'soundAsset': soundAsset,
    };
  }
}
