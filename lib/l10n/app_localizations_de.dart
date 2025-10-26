// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'ExacTime';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get appearance => 'Erscheinungsbild';

  @override
  String get language => 'Sprache';

  @override
  String get systemDefault => 'Systemstandard';

  @override
  String get english => 'Englisch';

  @override
  String get portuguese => 'Portugiesisch';

  @override
  String get spanish => 'Spanisch';

  @override
  String get german => 'Deutsch';

  @override
  String get french => 'Französisch';

  @override
  String get italian => 'Italienisch';

  @override
  String get theme => 'Thema';

  @override
  String get light => 'Hell';

  @override
  String get dark => 'Dunkel';

  @override
  String get help => 'Hilfe';

  @override
  String get commandsAndGestures => 'Befehle und Gesten';

  @override
  String get clockTheme => 'Uhren-Thema';

  @override
  String get clockThemeDigital => 'Digital';

  @override
  String get clockThemeFlip => 'Flip';

  @override
  String get adjustments => 'Anpassungen';

  @override
  String get fontSize => 'Schriftgröße';

  @override
  String get selectFontSize => 'Schriftgröße auswählen';

  @override
  String get enableSlidingMovement => 'Gleitbewegung aktivieren';

  @override
  String get showSecondsInPortrait => 'Sekunden im Hochformat anzeigen';

  @override
  String get showDate => 'Datum anzeigen';

  @override
  String get saveAndClose => 'Speichern und schließen';

  @override
  String get settingsSaved => 'Einstellungen erfolgreich gespeichert';

  @override
  String get ok => 'OK';

  @override
  String get developedBy => 'Entwickelt von allc 🤖';

  @override
  String get aboutTitle => 'Über';

  @override
  String get aboutContactLinks => 'Kontakt und Links:';

  @override
  String get aboutSupportMessage =>
      'Wenn diese App Ihnen nützlich war,\nbetrachten Sie die Unterstützung der Entwicklung mit einem Kaffee ☕!';

  @override
  String get close => 'Schließen';

  @override
  String get aboutPixCopied => 'PIX-Schlüssel kopiert!';

  @override
  String get aboutSupportWithPix => 'Mit PIX unterstützen';

  @override
  String get commandsDialogTitle => 'Befehle und Gesten';

  @override
  String get doubleTapCommand => 'Doppel-Tap auf dem Bildschirm';

  @override
  String get doubleTapDescription =>
      'Der Roboter spricht die aktuelle Zeit laut aus.';

  @override
  String get singleTapCommand => 'Einzel-Tap auf dem Bildschirm';

  @override
  String get singleTapDescription =>
      'Zeigt oder versteckt die Einstellungs-Schaltfläche und den Entwickler-Link.';

  @override
  String get iUnderstand => 'Verstanden';

  @override
  String get settingsTooltip => 'Einstellungen';

  @override
  String timeInHours(String count) {
    String _temp0 = intl.Intl.selectLogic(count, {
      '0': 'zwölf',
      '1': 'eins',
      '2': 'zwei',
      '3': 'drei',
      '4': 'vier',
      '5': 'fünf',
      '6': 'sechs',
      '7': 'sieben',
      '8': 'acht',
      '9': 'neun',
      '10': 'zehn',
      '11': 'elf',
      '12': 'zwölf',
      '13': 'eins',
      '14': 'zwei',
      '15': 'drei',
      '16': 'vier',
      '17': 'fünf',
      '18': 'sechs',
      '19': 'sieben',
      '20': 'acht',
      '21': 'neun',
      '22': 'zehn',
      '23': 'elf',
      'other': '',
    });
    return '$_temp0';
  }

  @override
  String timeInMinutes(String count) {
    String _temp0 = intl.Intl.selectLogic(count, {
      '0': '',
      '1': 'eins',
      '2': 'zwei',
      '3': 'drei',
      '4': 'vier',
      '5': 'fünf',
      '6': 'sechs',
      '7': 'sieben',
      '8': 'acht',
      '9': 'neun',
      '10': 'zehn',
      '11': 'elf',
      '12': 'zwölf',
      '13': 'dreizehn',
      '14': 'vierzehn',
      '15': 'fünfzehn',
      '16': 'sechzehn',
      '17': 'siebzehn',
      '18': 'achtzehn',
      '19': 'neunzehn',
      '20': 'zwanzig',
      '21': 'einundzwanzig',
      '22': 'zweiundzwanzig',
      '23': 'dreiundzwanzig',
      '24': 'vierundzwanzig',
      '25': 'fünfundzwanzig',
      '26': 'sechsundzwanzig',
      '27': 'siebenundzwanzig',
      '28': 'achtundzwanzig',
      '29': 'neunundzwanzig',
      '30': 'dreißig',
      '31': 'einunddreißig',
      '32': 'zweiunddreißig',
      '33': 'dreiunddreißig',
      '34': 'vierunddreißig',
      '35': 'fünfunddreißig',
      '36': 'sechsunddreißig',
      '37': 'siebenunddreißig',
      '38': 'achtunddreißig',
      '39': 'neununddreißig',
      '40': 'vierzig',
      '41': 'einundvierzig',
      '42': 'zweiundvierzig',
      '43': 'dreiundvierzig',
      '44': 'vierundvierzig',
      '45': 'fünfundvierzig',
      '46': 'sechsundvierzig',
      '47': 'siebenundvierzig',
      '48': 'achtundvierzig',
      '49': 'neunundvierzig',
      '50': 'fünfzig',
      '51': 'einundfünfzig',
      '52': 'zweiundfünfzig',
      '53': 'dreiundfünfzig',
      '54': 'vierundfünfzig',
      '55': 'fünfundfünfzig',
      '56': 'sechsundfünfzig',
      '57': 'siebenundfünfzig',
      '58': 'achtundfünfzig',
      '59': 'neunundfünfzig',
      'other': '',
    });
    return '$_temp0';
  }

  @override
  String timeIsExactly(String time) {
    return 'Es ist $time Uhr.';
  }

  @override
  String timeIs(String hours, String minutes) {
    return 'Es ist $hours $minutes.';
  }

  @override
  String get speakTimeOnChange => 'Zeit automatisch ansagen';

  @override
  String get clockThemeText => 'Text';

  @override
  String timeInSeconds(String count) {
    String _temp0 = intl.Intl.selectLogic(count, {
      '0': '',
      '1': 'eins',
      '2': 'zwei',
      '3': 'drei',
      '4': 'vier',
      '5': 'fünf',
      '6': 'sechs',
      '7': 'sieben',
      '8': 'acht',
      '9': 'neun',
      '10': 'zehn',
      '11': 'elf',
      '12': 'zwölf',
      '13': 'dreizehn',
      '14': 'vierzehn',
      '15': 'fünfzehn',
      '16': 'sechzehn',
      '17': 'siebzehn',
      '18': 'achtzehn',
      '19': 'neunzehn',
      '20': 'zwanzig',
      '21': 'einundzwanzig',
      '22': 'zweiundzwanzig',
      '23': 'dreiundzwanzig',
      '24': 'vierundzwanzig',
      '25': 'fünfundzwanzig',
      '26': 'sechsundzwanzig',
      '27': 'siebenundzwanzig',
      '28': 'achtundzwanzig',
      '29': 'neunundzwanzig',
      '30': 'dreißig',
      '31': 'einunddreißig',
      '32': 'zweiunddreißig',
      '33': 'dreiunddreißig',
      '34': 'vierunddreißig',
      '35': 'fünfunddreißig',
      '36': 'sechsunddreißig',
      '37': 'siebenunddreißig',
      '38': 'achtunddreißig',
      '39': 'neununddreißig',
      '40': 'vierzig',
      '41': 'einundvierzig',
      '42': 'zweiundvierzig',
      '43': 'dreiundvierzig',
      '44': 'vierundvierzig',
      '45': 'fünfundvierzig',
      '46': 'sechsundvierzig',
      '47': 'siebenundvierzig',
      '48': 'achtundvierzig',
      '49': 'neunundvierzig',
      '50': 'fünfzig',
      '51': 'einundfünfzig',
      '52': 'zweiundfünfzig',
      '53': 'dreiundfünfzig',
      '54': 'vierundfünfzig',
      '55': 'fünfundfünfzig',
      '56': 'sechsundfünfzig',
      '57': 'siebenundfünfzig',
      '58': 'achtundfünfzig',
      '59': 'neunundfünfzig',
      'other': '',
    });
    return '$_temp0';
  }

  @override
  String timeIsAll(String hours, String minutes, String seconds) {
    return 'Es ist $hours Stunde(n), $minutes Minute(n) und $seconds Sekunde(n).';
  }

  @override
  String timeIsHourAndSeconds(String hours, String seconds) {
    return 'Es ist $hours Stunde(n) und $seconds Sekunde(n).';
  }

  @override
  String get clockThemeAnalog => 'Analog';

  @override
  String get clockThemeAnalogRoman => 'Analog (Römisch)';

  @override
  String get showClockFrame => 'Uhrenrahmen anzeigen';

  @override
  String get use24HourFormat => '24-Stunden-Format verwenden';

  @override
  String get alarms => 'Wecker';

  @override
  String get addAlarm => 'Wecker hinzufügen';

  @override
  String get alarmMessageHint =>
      'Geben Sie eine Nachricht ein, die gesprochen werden soll';

  @override
  String get save => 'Speichern';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get delete => 'Löschen';

  @override
  String get noAlarms => 'Keine Wecker eingestellt.';

  @override
  String get settingsAlarms => 'Wecker verwalten';

  @override
  String get tapToDismiss => 'Tippen zum Entlassen';

  @override
  String get alarm => 'Wecker';

  @override
  String alarmDeleted(String alarmName) {
    return 'Wecker \"$alarmName\" gelöscht.';
  }

  @override
  String get daySundayShort => 'S';

  @override
  String get dayMondayShort => 'M';

  @override
  String get dayTuesdayShort => 'D';

  @override
  String get dayWednesdayShort => 'M';

  @override
  String get dayThursdayShort => 'D';

  @override
  String get dayFridayShort => 'F';

  @override
  String get daySaturdayShort => 'S';

  @override
  String get alarmNew => 'Neuer Wecker';

  @override
  String get alarmEdit => 'Wecker bearbeiten';

  @override
  String get alarmTime => 'Zeit';

  @override
  String get alarmLabelHint => 'Label (optional)';

  @override
  String get alarmRepeat => 'Wiederholen';

  @override
  String get alarmSound => 'Wecker-Ton';

  @override
  String get alarmSoundAsset => 'Tondatei';

  @override
  String get alarmSoundTts => 'Gesprochener Text';

  @override
  String get alarmTtsHint => 'Text zum Sprechen';

  @override
  String get alarmStopCondition => 'Stopp-Bedingung';

  @override
  String get alarmStopOnInteraction => 'Beim Tippen auf den Bildschirm';

  @override
  String get alarmStopAfterReps => 'Nach N Wiederholungen';

  @override
  String get alarmRepsHint => 'Anzahl der Wiederholungen';

  @override
  String get soundSelection => 'Ton';

  @override
  String get soundBeep => 'Piep';

  @override
  String get soundRooster => 'Hahn';

  @override
  String get selectAll => 'Alle auswählen';

  @override
  String get deselectAll => 'Alle abwählen';

  @override
  String get accentColorLabel => 'Zeiger- und Hervorhebungsfarbe';

  @override
  String get themeClassicBlack => 'Klassisches Schwarz';

  @override
  String get themeModernBlue => 'Modernes Blau';

  @override
  String get themeMinimalWhite => 'Minimalistisches Weiß';

  @override
  String get themeRetroGreen => 'Retro-Grün';

  @override
  String get themeGoldLuxury => 'Gold-Luxus';

  @override
  String get themeSpaceGray => 'Weltraum-Grau';

  @override
  String get themeRoseGold => 'Roségold';

  @override
  String get themeNightBlue => 'Nachtblau';

  @override
  String get themeIvoryElegance => 'Elfenbein-Eleganz';

  @override
  String get themeDigitalNeon => 'Digital-Neon';

  @override
  String get themeCopperVintage => 'Kupfer-Vintage';

  @override
  String get proThemeMessage => 'Thema exklusiv für den PRO-Plan!';

  @override
  String get upgradeToProTitle => 'Auf PRO upgraden';

  @override
  String get upgradeToProDesc =>
      'Schalten Sie exklusive Funktionen frei und entfernen Sie Anzeigen!';

  @override
  String get noAds => 'Keine Anzeigen';

  @override
  String get exclusiveThemes => 'Exklusive Themen';

  @override
  String get supportDeveloper => 'Entwickler unterstützen';

  @override
  String get buyFor => 'Kaufen für';

  @override
  String get buyProVersion => 'PRO-Version kaufen';

  @override
  String get processing => 'Verarbeitung...';

  @override
  String get unavailable => 'Nicht verfügbar';

  @override
  String get restorePurchases => 'Käufe wiederherstellen';

  @override
  String get loading => 'Laden...';
}
