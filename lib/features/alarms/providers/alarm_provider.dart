import 'dart:async';
import 'dart:convert';
import 'package:a_clock/features/settings/logic/settings_notifier.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:a_clock/features/alarms/model/alarm_model.dart';
import 'package:just_audio/just_audio.dart' as ja;

class AlarmProvider extends ChangeNotifier {
  static const _alarmsKey = 'user_alarms';
  SettingsNotifier? _settingsNotifier;

  List<Alarm> _alarms = [];
  List<Alarm> get alarms => _alarms;

  Timer? _timer;
  Alarm? _ringingAlarm;
  ja.AudioPlayer? _audioPlayer;
  final FlutterTts _flutterTts = FlutterTts();
  int _repeatCounter = 0;
  Timer? _repetitionTimer;
  Timer? _deactivationTimer; // 🆕 Timer for automatic deactivation
  bool _isDisposed = false;
  bool _audioSupported = true;
  
  // 🆕 Control to avoid multiple triggers
  int _lastTriggeredMinute = -1;

  Alarm? get ringingAlarm => _ringingAlarm;

  AlarmProvider() {
    _initializeAudio();
    _loadAlarms();
    _initializeTimer();
  }

  Future<void> _initializeAudio() async {
    if (kIsWeb || defaultTargetPlatform == TargetPlatform.windows) {
      _audioSupported = false;
      return;
    }

    try {
      _audioPlayer = ja.AudioPlayer();
      _audioPlayer?.playbackEventStream.listen((event) {}, 
        onError: (Object e, StackTrace st) {
          debugPrint('Audio player error: $e');
          _audioSupported = false;
        });
    } catch (e) {
      debugPrint('Failed to initialize audio player: $e');
      _audioSupported = false;
    }
  }

  void setSettingsNotifier(SettingsNotifier notifier) {
    _settingsNotifier = notifier;
  }

  @override
  void dispose() {
    _isDisposed = true;
    _timer?.cancel();
    _repetitionTimer?.cancel();
    _deactivationTimer?.cancel(); // 🆕 Cancels deactivation timer
    _audioPlayer?.dispose();
    _flutterTts.stop();
    super.dispose();
  }

  void _initializeTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isDisposed) {
        final now = DateTime.now();
        final currentMinute = now.hour * 100 + now.minute;
        
        // 🆕 Reset control when minute changes
        if (currentMinute != _lastTriggeredMinute) {
          // Reset is done automatically in the check
        }
        
        _checkAlarms();
      }
    });
  }

  void _checkAlarms() {
    if (ringingAlarm != null) return;

    final now = DateTime.now();
    final currentTime = TimeOfDay.fromDateTime(now);
    final currentMinute = now.hour * 100 + now.minute; // Formato HHMM para comparação

    // 🆕 Avoids multiple triggers in the same minute
    if (currentMinute == _lastTriggeredMinute) return;

    for (final alarm in _alarms) {
      if (alarm.isActive &&
          alarm.time.hour == currentTime.hour &&
          alarm.time.minute == currentTime.minute) {
        
        final isOneTimeAlarm = alarm.daysOfWeek.isEmpty;
        final isScheduledForToday = alarm.daysOfWeek.contains(now.weekday);

        if (isOneTimeAlarm || isScheduledForToday) {
          // 🆕 Records that this alarm was triggered this minute
          _lastTriggeredMinute = currentMinute;
          
          _triggerAlarm(alarm);
          
          // 🆕 If it's a one-time alarm, deactivate immediately after trigger
          if (isOneTimeAlarm) {
            _scheduleAlarmDeactivation(alarm);
          }
          
          break;
        }
      }
    }
  }

  void _triggerAlarm(Alarm alarm) {
    _ringingAlarm = alarm;
    _repeatCounter = 0;
    notifyListeners();

    _repetitionTimer?.cancel();

    if (alarm.stopCondition == AlarmStopCondition.afterRepetitions) {
      _playAlarmWithRepetitions();
    } else if (alarm.stopCondition == AlarmStopCondition.onInteraction) {
      _playAlarmSound();
      // For continuous alarms, keeps old behavior
      _repetitionTimer =
          Timer.periodic(const Duration(seconds: 10), (_) => _playAlarmSound());
    }
  }

  void _playAlarmWithRepetitions() async {
    if (_ringingAlarm == null) return;
    final alarm = _ringingAlarm!;

    void playNext() async {
      if (_ringingAlarm == null) return;
      _repeatCounter++;
      if (_repeatCounter > (alarm.maxRepetitions ?? 1)) {
        stopRinging();
        return;
      }

      if (alarm.soundType == AlarmSoundType.beep && _audioSupported && _audioPlayer != null) {
        try {
          var assetPath = alarm.normalizedSoundAsset ?? 'assets/sounds/beep.mp3';
          await _audioPlayer!.setAsset(assetPath);
          await _audioPlayer!.setLoopMode(ja.LoopMode.off);
          await _audioPlayer!.play();
          _audioPlayer!.playerStateStream.firstWhere((state) => state.processingState == ja.ProcessingState.completed).then((_) {
            // Only calls next repetition if it's still the same alarm playing
            if (_ringingAlarm == alarm) {
              playNext();
            }
          });
        } catch (e) {
          debugPrint('Error playing audio: $e');
        }
      } else if (alarm.soundType == AlarmSoundType.textToSpeech) {
        try {
          if (_settingsNotifier != null) {
            await _flutterTts.setLanguage(_settingsNotifier!.locale.toLanguageTag());
          }
          _flutterTts.setErrorHandler((msg) {
            debugPrint("TTS Error in alarm: $msg");
          });
          _flutterTts.setCompletionHandler(() {
            // Only calls next repetition if it's still the same alarm playing
            if (_ringingAlarm == alarm) {
              playNext();
            }
          });
          await _flutterTts.speak(alarm.textToSpeak ?? 'bip bip bip!');
        } catch (e) {
          debugPrint('Error speaking TTS: $e');
        }
      }
    }

    // Starts the first repetition
    playNext();
  }

  // 🆕 Schedules automatic deactivation of one-time alarms
  void _scheduleAlarmDeactivation(Alarm alarm) {
    // 🆕 Cancels previous timer if exists
    _deactivationTimer?.cancel();
    
    // Deactivates the alarm after 1 minute to ensure it doesn't ring again
    _deactivationTimer = Timer(const Duration(minutes: 1), () async {
      if (!_isDisposed) {
        final updatedAlarm = alarm.copyWith(isActive: false);
        await saveAlarm(updatedAlarm);
        debugPrint('One-time alarm deactivated automatically: ${alarm.id}');
      }
    });
  }

  Future<void> _playAlarmSound() async {
    if (ringingAlarm == null) return;

    switch (ringingAlarm!.soundType) {
      case AlarmSoundType.textToSpeech:
        try {
          if (_settingsNotifier != null) {
            await _flutterTts.setLanguage(_settingsNotifier!.locale.toLanguageTag());
          }
          
          // 🆕 Sets error handler for TTS
          _flutterTts.setErrorHandler((msg) {
            debugPrint("TTS Error in alarm: $msg");
          });
          
          await _flutterTts.speak(ringingAlarm!.textToSpeak ?? 'bip bip bip!');
        } catch (e) {
          debugPrint('Error with TTS in alarm: $e');
          // Fallback: tries to play beep if TTS fails
          if (_audioSupported && _audioPlayer != null) {
            try {
              await _audioPlayer!.setAsset('assets/sounds/beep.mp3');
              await _audioPlayer!.play();
            } catch (audioError) {
              debugPrint('Fallback audio also failed: $audioError');
            }
          }
        }
        break;
      case AlarmSoundType.beep:
        try {
          if (_audioSupported && _audioPlayer != null) {
            // 🆕 Uses normalized path from model
            var assetPath = ringingAlarm!.normalizedSoundAsset ?? 'assets/sounds/beep.mp3';

            // 🆕 Avoids interrupting sound already playing
            if (_audioPlayer!.playing) {
              return; // Sound already playing, don't restart
            }

            await _audioPlayer!.setAsset(assetPath);
            
            // 🆕 Sets automatic loop for continuous alarms
            if (ringingAlarm!.stopCondition == AlarmStopCondition.onInteraction) {
              await _audioPlayer!.setLoopMode(ja.LoopMode.one);
            } else {
              await _audioPlayer!.setLoopMode(ja.LoopMode.off);
            }
            
            await _audioPlayer!.play();
          } else {
            try {
              await _flutterTts.speak('bip!');
            } catch (e) {
              debugPrint('Error with TTS fallback: $e');
            }
          }
        } catch (e) {
          if (ringingAlarm != null) {
            debugPrint('Error playing audio: $e');
            try {
              await _flutterTts.speak('bip bip!');
            } catch (ttsError) {
              debugPrint('TTS fallback also failed: $ttsError');
            }
          }
        }
        break;
    }
  }

  Future<void> stopRinging() async {
    if (_ringingAlarm == null) return;

    final alarmToDeactivate = _ringingAlarm!;
    _ringingAlarm = null;
    notifyListeners();

    _repetitionTimer?.cancel();
    _deactivationTimer?.cancel(); // 🆕 Cancels deactivation timer when stopping manually

    await _audioPlayer?.stop();
    await _flutterTts.stop();

    // 🆕 Only deactivates one-time alarms (without defined days of week)
    // Recurring alarms (with days of week) should remain active to ring again
    final shouldDeactivate = alarmToDeactivate.daysOfWeek.isEmpty;
    
    if (shouldDeactivate) {
      final updatedAlarm = alarmToDeactivate.copyWith(isActive: false);
      await saveAlarm(updatedAlarm);
      debugPrint('One-time alarm deactivated after stopping: ${alarmToDeactivate.id}');
    } else {
      debugPrint('Recurring alarm remains active for next days: ${alarmToDeactivate.id}');
    }
  }

  Future<void> _loadAlarms() async {
    final prefs = await SharedPreferences.getInstance();
    final alarmsString = prefs.getString(_alarmsKey);
    if (alarmsString != null) {
      final List<dynamic> alarmsJson = jsonDecode(alarmsString);
      _alarms = alarmsJson.map((json) => Alarm.fromJson(json)).toList();
      
      // 🆕 Automatic migration: migrates removed sounds and fixes paths
      bool needsMigration = false;
      final removedSounds = [
        'assets/sounds/fire.mp3',
        'assets/sounds/ocean.mp3', 
        'assets/sounds/rain.mp3',
        'assets/sounds/thunder.mp3',
        'assets/sounds/wind.mp3',
        'sounds/fire.mp3',
        'sounds/ocean.mp3',
        'sounds/rain.mp3', 
        'sounds/thunder.mp3',
        'sounds/wind.mp3',
        'fire.mp3',
        'ocean.mp3',
        'rain.mp3',
        'thunder.mp3', 
        'wind.mp3'
      ];
      
      for (int i = 0; i < _alarms.length; i++) {
        final alarm = _alarms[i];
        String? newSoundAsset = alarm.soundAsset;
        
        // Migrates removed sounds to beep.mp3
        if (alarm.soundAsset != null && removedSounds.contains(alarm.soundAsset)) {
          newSoundAsset = 'assets/sounds/beep.mp3';
          needsMigration = true;
          debugPrint('Migrating removed sound ${alarm.soundAsset} to beep.mp3');
        }
        // Fixes inconsistent paths
        else if (alarm.soundAsset != null && alarm.soundAsset != alarm.normalizedSoundAsset) {
          newSoundAsset = alarm.normalizedSoundAsset;
          needsMigration = true;
        }
        
        if (newSoundAsset != alarm.soundAsset) {
          _alarms[i] = alarm.copyWith(soundAsset: newSoundAsset);
        }
      }
      
      // If migration occurred, saves corrected alarms
      if (needsMigration) {
        await _saveAlarms();
        debugPrint('Sound migration completed for ${_alarms.length} alarms');
      }
      
      notifyListeners();
    }
  }

  Future<void> _saveAlarms() async {
    final prefs = await SharedPreferences.getInstance();
    final alarmsString =
        jsonEncode(_alarms.map((alarm) => alarm.toJson()).toList());
    await prefs.setString(_alarmsKey, alarmsString);
  }

  Future<void> saveAlarm(Alarm alarm) async {
    final index = _alarms.indexWhere((a) => a.id == alarm.id);
    if (index != -1) {
      _alarms[index] = alarm;
    } else {
      _alarms.add(alarm);
    }
    await _saveAlarms();
    notifyListeners();
  }

  Future<void> toggleAlarm(String id) async {
    final index = _alarms.indexWhere((alarm) => alarm.id == id);
    if (index != -1) {
      final oldAlarm = _alarms[index];
      _alarms[index] = oldAlarm.copyWith(isActive: !oldAlarm.isActive);
      await _saveAlarms();
      notifyListeners();
    }
  }

  Future<void> deleteAlarm(String id) async {
    _alarms.removeWhere((alarm) => alarm.id == id);
    await _saveAlarms();
    notifyListeners();
  }
}
