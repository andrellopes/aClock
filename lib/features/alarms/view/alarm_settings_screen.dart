import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:a_clock/l10n/app_localizations.dart';

import '../model/alarm_model.dart';
import '../providers/alarm_provider.dart';

class AlarmSettingsScreen extends StatefulWidget {
  final Alarm? alarm;

  const AlarmSettingsScreen({super.key, this.alarm});

  @override
  State<AlarmSettingsScreen> createState() => _AlarmSettingsScreenState();
}

class _AlarmSettingsScreenState extends State<AlarmSettingsScreen> {
  late TimeOfDay _selectedTime;
  late TextEditingController _labelController;
  late TextEditingController _textToSpeakController;
  late TextEditingController _maxRepetitionsController;
  late Set<int> _daysOfWeek;
  late AlarmSoundType _soundType;
  late AlarmStopCondition _stopCondition;
  late String _selectedSoundAsset;

  EdgeInsets get defaultPadding => const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0);

  @override
  void initState() {
    super.initState();
    final alarm = widget.alarm;
    if (alarm != null) {
      _selectedTime = alarm.time;
      _labelController = TextEditingController(text: alarm.label);
      _daysOfWeek = Set.from(alarm.daysOfWeek);
      _soundType = alarm.soundType;
      _textToSpeakController = TextEditingController(text: alarm.textToSpeak);
      _stopCondition = alarm.stopCondition;
      _maxRepetitionsController = TextEditingController(text: alarm.maxRepetitions?.toString() ?? '5');

      // 🆕 Uses normalized path from model
      _selectedSoundAsset = alarm.normalizedSoundAsset ?? 'assets/sounds/beep.mp3';
    } else {
      _selectedTime = TimeOfDay.now();
      _labelController = TextEditingController();
      _daysOfWeek = {1, 2, 3, 4, 5, 6, 7};
      _soundType = AlarmSoundType.beep;
      _textToSpeakController = TextEditingController();
      _stopCondition = AlarmStopCondition.onInteraction;
      _maxRepetitionsController = TextEditingController(text: '5');

      // Defines the default sound with the full asset path.
      _selectedSoundAsset = 'assets/sounds/beep.mp3';
    }
  }

  @override
  void dispose() {
    _labelController.dispose();
    _textToSpeakController.dispose();
    _maxRepetitionsController.dispose();
    super.dispose();
  }

  void _saveAlarm() {
    final label = _labelController.text;
    final textToSpeak = _textToSpeakController.text;
    final maxRepetitions = int.tryParse(_maxRepetitionsController.text);

    final newOrUpdatedAlarm = Alarm(
      id: widget.alarm?.id ?? const Uuid().v4(),
      time: _selectedTime,
      label: label.isNotEmpty ? label : null,
      daysOfWeek: _daysOfWeek,
      soundType: _soundType,
      textToSpeak: _soundType == AlarmSoundType.textToSpeech && textToSpeak.isNotEmpty ? textToSpeak : null,
      stopCondition: _stopCondition,
      maxRepetitions: _stopCondition == AlarmStopCondition.afterRepetitions && maxRepetitions != null ? maxRepetitions : 5,
      isActive: widget.alarm?.isActive ?? true,
      soundAsset: _soundType == AlarmSoundType.beep ? _selectedSoundAsset : null,
    );

    context.read<AlarmProvider>().saveAlarm(newOrUpdatedAlarm);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.alarm == null ? l10n.alarmNew : l10n.alarmEdit),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _saveAlarm,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        tooltip: l10n.save,
        child: const Icon(Icons.check),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 80),
        children: [
          Card(
            margin: defaultPadding,
            child: ListTile(
              leading: const Icon(Icons.access_time),
              title: Text(l10n.alarmTime),
              trailing: Text(
                _selectedTime.format(context),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              onTap: () async {
                final time = await showTimePicker(context: context, initialTime: _selectedTime);
                if (time != null) setState(() => _selectedTime = time);
              },
            ),
          ),
          Padding(
            padding: defaultPadding,
            child: TextField(
              controller: _labelController,
              decoration: InputDecoration(labelText: l10n.alarmLabelHint),
            ),
          ),
          _buildSectionHeader(l10n.alarmRepeat),
          _buildDaysOfWeekSelector(l10n),
          _buildSectionHeader(l10n.alarmSound),
          ..._buildSoundTypeSelector(l10n),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _soundType == AlarmSoundType.beep
                ? _buildSoundAssetSelector(l10n)
                : _soundType == AlarmSoundType.textToSpeech
                    ? Padding(
                        key: const ValueKey('tts'),
                        padding: defaultPadding,
                        child: TextField(
                          controller: _textToSpeakController,
                          decoration: InputDecoration(labelText: l10n.alarmTtsHint),
                        ),
                      )
                    : const SizedBox.shrink(key: ValueKey('none')),
          ),
          _buildSectionHeader(l10n.alarmStopCondition),
          ..._buildStopConditionSelector(l10n),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _stopCondition == AlarmStopCondition.afterRepetitions
                ? Padding(
                    key: const ValueKey('reps'),
                    padding: defaultPadding,
                    child: TextField(
                      controller: _maxRepetitionsController,
                      decoration: InputDecoration(labelText: l10n.alarmRepsHint),
                      keyboardType: TextInputType.number,
                    ),
                  )
                : const SizedBox.shrink(key: ValueKey('none')),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
      );

  Widget _buildDaysOfWeekSelector(AppLocalizations l10n) {
    final List<String> dayLabels = [
      l10n.dayMondayShort,
      l10n.dayTuesdayShort,
      l10n.dayWednesdayShort,
      l10n.dayThursdayShort,
      l10n.dayFridayShort,
      l10n.daySaturdayShort,
      l10n.daySundayShort,
    ];
    final bool allDaysSelected = _daysOfWeek.length == 7;

    return Column(
      children: [
        Padding(
          padding: defaultPadding,
          child: Wrap(
            spacing: 4.0,
            runSpacing: 4.0,
            alignment: WrapAlignment.center,
            children: List.generate(7, (index) {
              final dayOfWeek = index + 1;
              return FilterChip(
                label: Text(dayLabels[index]),
                selected: _daysOfWeek.contains(dayOfWeek),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                selectedColor: Theme.of(context).colorScheme.primary.withValues(alpha: 51),
                onSelected: (isSelected) {
                  setState(() {
                    if (isSelected) {
                      _daysOfWeek.add(dayOfWeek);
                    } else {
                      _daysOfWeek.remove(dayOfWeek);
                    }
                  });
                },
              );
            }),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 16.0, bottom: 8.0),
            child: TextButton(
              onPressed: () {
                setState(() {
                  _daysOfWeek = allDaysSelected ? {} : {1, 2, 3, 4, 5, 6, 7};
                });
              },
              child: Text(allDaysSelected ? l10n.deselectAll : l10n.selectAll),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSoundAssetSelector(AppLocalizations l10n) {
    final Map<String, String> availableSounds = {
      'assets/sounds/beep.mp3': l10n.soundBeep,
      'assets/sounds/rooster.mp3': l10n.soundRooster,
    };

    return Padding(
      padding: defaultPadding,
      child: DropdownButtonFormField<String>(
        value: _selectedSoundAsset,
        items: availableSounds.entries.map((entry) {
          return DropdownMenuItem<String>(
            value: entry.key,
            child: Text(entry.value),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            setState(() {
              _selectedSoundAsset = value;
            });
          }
        },
        decoration: InputDecoration(labelText: l10n.soundSelection),
      ),
    );
  }

  List<Widget> _buildSoundTypeSelector(AppLocalizations l10n) => [
        RadioListTile<AlarmSoundType>(
          title: Text(l10n.alarmSoundAsset),
          value: AlarmSoundType.beep,
          groupValue: _soundType,
          onChanged: (v) => setState(() => _soundType = v!),
        ),
        RadioListTile<AlarmSoundType>(
          title: Text(l10n.alarmSoundTts),
          value: AlarmSoundType.textToSpeech,
          groupValue: _soundType,
          onChanged: (v) => setState(() => _soundType = v!),
        ),
      ];

  List<Widget> _buildStopConditionSelector(AppLocalizations l10n) => [
        RadioListTile<AlarmStopCondition>(
          title: Text(l10n.alarmStopOnInteraction),
          value: AlarmStopCondition.onInteraction,
          groupValue: _stopCondition,
          onChanged: (v) => setState(() => _stopCondition = v!),
        ),
        RadioListTile<AlarmStopCondition>(
          title: Text(l10n.alarmStopAfterReps),
          value: AlarmStopCondition.afterRepetitions,
          groupValue: _stopCondition,
          onChanged: (v) => setState(() => _stopCondition = v!),
        ),
      ];
}
