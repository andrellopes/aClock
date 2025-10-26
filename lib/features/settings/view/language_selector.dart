import 'package:a_clock/features/settings/logic/settings_notifier.dart';
import 'package:flutter/material.dart';
import 'package:a_clock/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

/// A widget that displays a language selector based on supported locales.
class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  /// Returns the display name for a given language code.
  String _getLanguageDisplayName(BuildContext context, String languageCode) {
    switch (languageCode) {
      case 'pt':
        return 'Português';
      case 'en':
        return 'English';
      case 'es':
        return 'Español';
      default:
        return languageCode.toUpperCase();
    }
  }

  @override
  Widget build(BuildContext context) {
    final settingsNotifier = context.watch<SettingsNotifier>();
    // Uses the locale from notifier, which already has 'pt' as fallback.
    final currentLocale = settingsNotifier.locale;

    return DropdownButtonFormField<Locale>(
      value: currentLocale,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context)!.language,
        border: const OutlineInputBorder(),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      ),
      // Builds menu items from supported languages list.
      // Ensures only 'pt', 'en', and 'es' appear.
      items: AppLocalizations.supportedLocales.map((locale) {
        return DropdownMenuItem<Locale>(
          value: locale,
          child: Text(_getLanguageDisplayName(context, locale.languageCode)),
        );
      }).toList(),
      onChanged: (newLocale) {
        if (newLocale != null) {
          settingsNotifier.updateLocale(newLocale);
        }
      },
    );
  }
}
