import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:a_clock/core/themes/theme_manager.dart';
import 'package:a_clock/l10n/app_localizations.dart';

class ThemeSelectorWidget extends StatelessWidget {
  const ThemeSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeManager>(
      builder: (context, themeManager, child) {
        final l10n = AppLocalizations.of(context)!;
        final themes = themeManager.allThemes;
        final selectedIndex = themeManager.currentThemeIndex;

        return SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: themes.length,
            itemBuilder: (context, index) {
              final theme = themes[index];
              final isSelected = selectedIndex == index;
              final isPremium = index >= 4;

              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: GestureDetector(
                  onTap: () async {
                    if (isPremium && !themeManager.isPremium) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${l10n.theme}: ${_getThemeName(l10n, theme.labelKey)} é exclusivo do plano PRO!'),
                          backgroundColor: Colors.amber,
                        ),
                      );
                      return;
                    }
                    await themeManager.setTheme(index);
                  },
                  child: Opacity(
                    opacity: (isPremium && !themeManager.isPremium) ? 0.5 : 1.0,
                    child: Container(
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? theme.primary : Colors.transparent,
                          width: 3,
                        ),
                        boxShadow: isPremium ? [
                          BoxShadow(
                            color: Colors.amber.withValues(alpha: 51.0), // 0.2 * 255
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ] : [],
                      ),
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: theme.background,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(9),
                                      topRight: Radius.circular(9),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  width: double.infinity,
                                  color: theme.primary,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: theme.secondary,
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(9),
                                      bottomRight: Radius.circular(9),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            bottom: 8,
                            left: 4,
                            right: 4,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    _getThemeName(l10n, theme.labelKey),
                                    style: TextStyle(
                                      color: theme.font,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (isPremium)
                                  Row(
                                    children: List.generate(3, (i) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 12,
                                    )),
                                  ),
                              ],
                            ),
                          ),
                          if (isSelected)
                            Positioned(
                              top: 4,
                              left: 4,
                              child: Icon(
                                Icons.check,
                                color: theme.primary,
                                size: 14,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  String _getThemeName(AppLocalizations l10n, String key) {
    switch (key) {
      case 'classicBlack':
        return l10n.themeClassicBlack;
      case 'modernBlue':
        return l10n.themeModernBlue;
      case 'minimalWhite':
        return l10n.themeMinimalWhite;
      case 'retroGreen':
        return l10n.themeRetroGreen;
      case 'goldLuxury':
        return l10n.themeGoldLuxury;
      case 'spaceGray':
        return l10n.themeSpaceGray;
      case 'roseGold':
        return l10n.themeRoseGold;
      case 'nightBlue':
        return l10n.themeNightBlue;
      case 'ivoryElegance':
        return l10n.themeIvoryElegance;
      case 'digitalNeon':
        return l10n.themeDigitalNeon;
      case 'copperVintage':
        return l10n.themeCopperVintage;
      default:
        return key;
    }
  }
}
