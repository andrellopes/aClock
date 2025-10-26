import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:a_clock/l10n/app_localizations.dart';
import 'package:a_clock/features/alarms/providers/alarm_provider.dart';
import 'package:a_clock/features/alarms/view/alarm_settings_screen.dart';

class AlarmsScreen extends StatelessWidget {
  const AlarmsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.alarms),
      ),
      body: Consumer<AlarmProvider>(
        builder: (context, alarmProvider, child) {
          if (alarmProvider.alarms.isEmpty) {
            return Center(
              child: Text(
                l10n.noAlarms,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            );
          }
          final sortedAlarms = List.from(alarmProvider.alarms)
            ..sort((a, b) {
              final aTime = a.time.hour * 60 + a.time.minute;
              final bTime = b.time.hour * 60 + b.time.minute;
              return aTime.compareTo(bTime);
            });

          return ListView.builder(
            itemCount: sortedAlarms.length,
            itemBuilder: (context, index) {
              final alarm = sortedAlarms[index];
              return Dismissible(
                key: ValueKey(alarm.id),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  context.read<AlarmProvider>().deleteAlarm(alarm.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(l10n.alarmDeleted(alarm.label ?? alarm.time.format(context))),
                    ),
                  );
                },

                background: Container(
                  color: Colors.red.shade700,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        l10n.delete,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.delete_forever, color: Colors.white),
                    ],
                  ),
                ),

                child: ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => AlarmSettingsScreen(alarm: alarm),
                    ));
                  },
                  title: Text(
                    alarm.time.format(context),
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      decoration: alarm.isActive ? null : TextDecoration.lineThrough,
                    ),
                  ),
                  subtitle: Text(
                    alarm.label ?? '',
                    style: TextStyle(
                      decoration: alarm.isActive ? null : TextDecoration.lineThrough,
                    ),
                  ),
                  trailing: Switch(
                    value: alarm.isActive,
                    onChanged: (bool value) {
                      alarmProvider.toggleAlarm(alarm.id);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const AlarmSettingsScreen()),
          );
        },
        tooltip: l10n.addAlarm,
        child: const Icon(Icons.add),
      ),
    );
  }
}
