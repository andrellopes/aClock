import 'package:flutter/material.dart';
import 'package:a_clock/l10n/app_localizations.dart';

/// Displays an informative dialog with the list of app commands.
void showCommandsDialog(BuildContext context) {
  final l10n = AppLocalizations.of(context)!;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(l10n.commandsDialogTitle),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              _buildCommandItem(
                context,
                icon: Icons.touch_app_outlined,
                command: l10n.doubleTapCommand,
                description: l10n.doubleTapDescription,
              ),
              const SizedBox(height: 16),
              _buildCommandItem(
                context,
                icon: Icons.settings_outlined,
                command: l10n.singleTapCommand,
                description: l10n.singleTapDescription,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(l10n.iUnderstand),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Widget _buildCommandItem(BuildContext context,
    {required IconData icon, required String command, required String description}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(icon, color: Theme.of(context).primaryColor, size: 32),
      const SizedBox(width: 16),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(command, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(description, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    ],
  );
}
