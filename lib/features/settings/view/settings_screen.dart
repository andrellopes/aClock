import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:a_clock/core/models/clock_theme.dart';
import 'package:a_clock/core/models/settings_model.dart';
import 'package:a_clock/core/widgets/commands_dialog.dart';
import 'package:a_clock/core/widgets/about_dialog.dart';
import 'package:a_clock/core/widgets/pro_upgrade_dialog.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:a_clock/features/alarms/view/alarms_screen.dart';
import 'package:a_clock/l10n/app_localizations.dart';
import 'package:a_clock/core/themes/theme_manager.dart';
import 'package:a_clock/core/services/purchase_service.dart';
import 'package:a_clock/features/settings/logic/settings_notifier.dart';

class SettingsScreen extends StatefulWidget {
  final SettingsModel initialSettings;

  const SettingsScreen({super.key, required this.initialSettings});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late SettingsModel _currentSettings;
  String _appVersion = '';

  @override
  void initState() {
    super.initState();
    _currentSettings = widget.initialSettings;
    _loadAppVersion();
  }

  void _loadAppVersion() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      if (mounted) {
        setState(() => _appVersion = 'v${packageInfo.version}+${packageInfo.buildNumber}');
      }
    } catch (e) {
      debugPrint("Failed to get app version: $e");
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settingsTitle),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: _saveAndExit,
        ),
        actions: [
          Consumer<PurchaseService>(
            builder: (context, purchaseService, child) {
              if (purchaseService.isProVersion) {
                return const Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: ProBadge(),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // PRO section at top ONLY for non-PRO users
                  Consumer<PurchaseService>(
                    builder: (context, purchaseService, child) {
                      if (!purchaseService.isProVersion) {
                        return _buildProSection(context, l10n);
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  
                  // Alarms as first option
                  _expansionSection(l10n.alarms, [
                    const SizedBox(height: 8),
                    ListTile(
                      leading: const Icon(Icons.alarm),
                      title: Text(l10n.settingsAlarms),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const AlarmsScreen())),
                    ),
                    const SizedBox(height: 8),
                  ]),
                  // Appearance: language + theme selection
                  _expansionSection(l10n.appearance, [
                    _buildLanguageSelector(context, l10n),
                    _divider(),
                    _buildThemeSelector(context, l10n),
                  ]),
                  // Clock layout
                  _expansionSection('Layout', [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: DropdownButtonFormField<ClockTheme>(
                        value: _currentSettings.theme,
                        decoration: const InputDecoration(border: InputBorder.none),
                        items: () {
                          var themeItems = ClockTheme.values.map((theme) {
                            return MapEntry(theme, _getClockThemeName(context, theme));
                          }).toList();
                          themeItems.sort((a, b) => a.value.compareTo(b.value));
                          return themeItems.map((item) => DropdownMenuItem(value: item.key, child: Text(item.value))).toList();
                        }(),
                        onChanged: (theme) {
                          if (theme != null) {
                            _applySettingChange(_currentSettings.copyWith(theme: theme));
                          }
                        },
                      ),
                    ),
                  ]),
                  // Adjustments
                  _expansionSection(l10n.adjustments, [
                    const SizedBox(height: 8),
                    ListTile(
                      title: Text(l10n.fontSize),
                      trailing: Text('${_currentSettings.fontSize.toInt()}'),
                      onTap: () => _showFontSizeDialog(l10n),
                    ),
                    if (_currentSettings.theme == ClockTheme.digital) ...[
                      const SizedBox(height: 4),
                      SwitchListTile(
                        title: Text(l10n.enableSlidingMovement),
                        value: _currentSettings.isClockSliding,
                        onChanged: (value) => _applySettingChange(_currentSettings.copyWith(isClockSliding: value)),
                      ),
                    ],
                    if (_currentSettings.theme != ClockTheme.analog &&
                        _currentSettings.theme != ClockTheme.analogRoman) ...[
                      const SizedBox(height: 4),
                      SwitchListTile(
                        title: Text(l10n.showSecondsInPortrait),
                        value: _currentSettings.showSecondsInPortrait,
                        onChanged: (value) => _applySettingChange(
                            _currentSettings.copyWith(showSecondsInPortrait: value)),
                      ),
                    ],
                    if (_currentSettings.theme == ClockTheme.digital || _currentSettings.theme == ClockTheme.flip) ...[
                      const SizedBox(height: 4),
                      SwitchListTile(
                        title: Text(l10n.use24HourFormat),
                        value: _currentSettings.use24HourFormat,
                        onChanged: (value) => _applySettingChange(
                            _currentSettings.copyWith(use24HourFormat: value)),
                      ),
                    ],
                    const SizedBox(height: 4),
                    SwitchListTile(
                      title: Text(l10n.showDate),
                      value: _currentSettings.showDate,
                      onChanged: (value) => _applySettingChange(_currentSettings.copyWith(showDate: value)),
                    ),
                    if (_currentSettings.theme == ClockTheme.analogRoman || _currentSettings.theme == ClockTheme.analog) ...[
                      const SizedBox(height: 4),
                      SwitchListTile(
                        title: Text(l10n.showClockFrame),
                        value: _currentSettings.showAnalogFrame,
                        onChanged: (value) => _applySettingChange(
                            _currentSettings.copyWith(showAnalogFrame: value)),
                      ),
                    ],
                    const SizedBox(height: 4),
                    SwitchListTile(
                      title: Text(l10n.speakTimeOnChange),
                      value: _currentSettings.speakTheTime,
                      onChanged: (value) => _applySettingChange(_currentSettings.copyWith(speakTheTime: value)),
                    ),
                    const SizedBox(height: 8),
                  ]),
                  _expansionSection(l10n.help, [
                    const SizedBox(height: 8),
                    ListTile(
                      leading: const Icon(Icons.help_outline),
                      title: Text(l10n.commandsAndGestures),
                      onTap: () => showCommandsDialog(context),
                    ),
                    const SizedBox(height: 8),
                  ]),
                  
                  // "Developed by" moved above version
                  InkWell(
                    onTap: () => showAppAboutDialog(context),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 24, bottom: 8),
                      child: Text(
                        l10n.developedBy,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 178.5),
                        ),
                      ),
                    ),
                  ),
                  
                  if (_appVersion.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(_appVersion,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 153.0))),
                    ),
                ],
              ),
            ),
            
            // Ad banner removed as requested
          ],
        ),
      ),
    );
  }

  Widget _divider() => const Divider(height: 1);

  Widget _expansionSection(String title, List<Widget> children) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 12),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent, // Removes default divider line
        ),
        child: ExpansionTile(
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          iconColor: Theme.of(context).colorScheme.onSurface.withValues(alpha: 178.5),
          collapsedIconColor: Theme.of(context).colorScheme.onSurface.withValues(alpha: 178.5),
          children: children,
        ),
      ),
    );
  }

  // Applies changes instantly
  void _applySettingChange(SettingsModel updated) async {
    setState(() => _currentSettings = updated);
    final settingsNotifier = context.read<SettingsNotifier>();
    await settingsNotifier.updateSettingsModel(updated);
  }

  Widget _buildLanguageSelector(BuildContext context, AppLocalizations l10n) {
    final currentLocale = _currentSettings.locale ?? const Locale('pt');

    return Column(
      children: [
        const SizedBox(height: 8),
        ListTile(
          title: Text(l10n.language),
          trailing: DropdownButton<Locale>(
            value: currentLocale,
            underline: const SizedBox.shrink(),
            items: AppLocalizations.supportedLocales.map((locale) => DropdownMenuItem(
                  value: locale,
                  child: Text(_getLanguageName(context, locale)),
                )).toList(),
            onChanged: (newLocale) {
              if (newLocale != null) {
                _applySettingChange(_currentSettings.copyWith(locale: newLocale));
              }
            },
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildThemeSelector(BuildContext context, AppLocalizations l10n) {
    final themeManager = context.watch<ThemeManager>();

    final themes = themeManager.allThemes;
    return Column(
      children: [
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              l10n.theme,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1,
            ),
            itemCount: themes.length,
            itemBuilder: (context, index) {
              final theme = themes[index];
              final isSelected = themeManager.currentThemeIndex == index;
              final isPremium = index >= 4;

              return GestureDetector(
                onTap: () {
                  if (!isPremium || themeManager.isPremium) {
                    themeManager.setTheme(index);
                  } else {
                    // Shows PRO upgrade dialog
                    showDialog(
                      context: context,
                      builder: (context) => const ProUpgradeDialog(),
                    );
                  }
                },
                child: Opacity(
                  opacity: (isPremium && !themeManager.isPremium) ? 0.5 : 1.0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? Colors.blue : Colors.grey.withValues(alpha: 76.5),
                        width: isSelected ? 3 : 1,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(11),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                theme.background,
                                theme.primary.withValues(alpha: 76.5),
                              ],
                            ),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.palette,
                                  color: theme.font,
                                  size: 20,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  theme.labelKey.replaceFirst('theme_', '').toUpperCase(),
                                  style: TextStyle(
                                    color: theme.font,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (isPremium)
                          const Positioned(
                            top: 4,
                            right: 4,
                            child: Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 16,
                            ),
                          ),
                        if (isSelected)
                          const Positioned(
                            bottom: 4,
                            right: 4,
                            child: Icon(
                              Icons.check_circle,
                              color: Colors.blue,
                              size: 16,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  void _showFontSizeDialog(AppLocalizations l10n) {
    double tempFontSize = _currentSettings.fontSize;
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, dialogSetState) {
          return AlertDialog(
            title: Text(l10n.selectFontSize),
            content: Slider(
              value: tempFontSize,
              min: 40,
              max: 150,
              divisions: 22,
              label: tempFontSize.toInt().toString(),
              onChanged: (val) => dialogSetState(() => tempFontSize = val),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  _applySettingChange(_currentSettings.copyWith(fontSize: tempFontSize));
                  Navigator.pop(context);
                },
                child: Text(l10n.ok),
              ),
            ],
          );
        });
      },
    );
  }

  void _saveAndExit() {
    Navigator.pop(context, _currentSettings);
  }

  String _getLanguageName(BuildContext context, Locale? locale) {
    final l10n = AppLocalizations.of(context)!;
    if (locale == null) return l10n.systemDefault;
    final languageMap = {
      'en': '🇺🇸 ${l10n.english}',
      'pt': '🇧🇷 ${l10n.portuguese}',
      'es': '🇪🇸 ${l10n.spanish}',
      'de': '🇩🇪 ${l10n.german}',
      'fr': '🇫🇷 ${l10n.french}',
      'it': '🇮🇹 ${l10n.italian}',
    };
    return languageMap[locale.languageCode] ?? locale.languageCode;
  }

  String _getClockThemeName(BuildContext context, ClockTheme theme) {
    final l10n = AppLocalizations.of(context)!;
    switch (theme) {
      case ClockTheme.digital:
        return l10n.clockThemeDigital;
      case ClockTheme.flip:
        return l10n.clockThemeFlip;
      case ClockTheme.analog:
        return l10n.clockThemeAnalog;
      case ClockTheme.analogRoman:
        return l10n.clockThemeAnalogRoman;
    }
  }

  Widget _buildProSection(BuildContext context, AppLocalizations l10n) {
    // Shows call-to-action for PRO upgrade
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => const ProUpgradeDialog(),
          );
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.amber.withValues(alpha: 25.5), 
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.upgradeToProTitle,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      '${l10n.noAds} • ${l10n.exclusiveThemes}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).textTheme.bodySmall?.color,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 178.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
