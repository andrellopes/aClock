// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'ExacTime';

  @override
  String get settingsTitle => 'Impostazioni';

  @override
  String get appearance => 'Aspetto';

  @override
  String get language => 'Lingua';

  @override
  String get systemDefault => 'Predefinito di sistema';

  @override
  String get english => 'Inglese';

  @override
  String get portuguese => 'Portoghese';

  @override
  String get spanish => 'Spagnolo';

  @override
  String get german => 'Tedesco';

  @override
  String get french => 'Francese';

  @override
  String get italian => 'Italiano';

  @override
  String get theme => 'Tema';

  @override
  String get light => 'Chiaro';

  @override
  String get dark => 'Scuro';

  @override
  String get help => 'Aiuto';

  @override
  String get commandsAndGestures => 'Comandi e gesti';

  @override
  String get clockTheme => 'Tema orologio';

  @override
  String get clockThemeDigital => 'Digitale';

  @override
  String get clockThemeFlip => 'Flip';

  @override
  String get adjustments => 'Regolazioni';

  @override
  String get fontSize => 'Dimensione font';

  @override
  String get selectFontSize => 'Seleziona dimensione font';

  @override
  String get enableSlidingMovement => 'Abilita movimento scorrevole';

  @override
  String get showSecondsInPortrait => 'Mostra secondi in verticale';

  @override
  String get showDate => 'Mostra data';

  @override
  String get saveAndClose => 'Salva e chiudi';

  @override
  String get settingsSaved => 'Impostazioni salvate con successo';

  @override
  String get ok => 'OK';

  @override
  String get developedBy => 'Sviluppato da allc 🤖';

  @override
  String get aboutTitle => 'Informazioni';

  @override
  String get aboutContactLinks => 'Contatto e collegamenti:';

  @override
  String get aboutSupportMessage =>
      'Se questa app ti è stata utile,\nconsidera di supportare lo sviluppo con un caffè ☕!';

  @override
  String get close => 'Chiudi';

  @override
  String get aboutPixCopied => 'Chiave PIX copiata!';

  @override
  String get aboutSupportWithPix => 'Supporta con PIX';

  @override
  String get commandsDialogTitle => 'Comandi e gesti';

  @override
  String get doubleTapCommand => 'Doppio tocco sullo schermo';

  @override
  String get doubleTapDescription =>
      'Il robot annuncia l\'ora corrente ad alta voce.';

  @override
  String get singleTapCommand => 'Tocco singolo sullo schermo';

  @override
  String get singleTapDescription =>
      'Mostra o nasconde il pulsante impostazioni e il collegamento sviluppatore.';

  @override
  String get iUnderstand => 'Capito';

  @override
  String get settingsTooltip => 'Impostazioni';

  @override
  String timeInHours(String count) {
    String _temp0 = intl.Intl.selectLogic(count, {
      '0': 'dodici',
      '1': 'una',
      '2': 'due',
      '3': 'tre',
      '4': 'quattro',
      '5': 'cinque',
      '6': 'sei',
      '7': 'sette',
      '8': 'otto',
      '9': 'nove',
      '10': 'dieci',
      '11': 'undici',
      '12': 'dodici',
      '13': 'una',
      '14': 'due',
      '15': 'tre',
      '16': 'quattro',
      '17': 'cinque',
      '18': 'sei',
      '19': 'sette',
      '20': 'otto',
      '21': 'nove',
      '22': 'dieci',
      '23': 'undici',
      'other': '',
    });
    return '$_temp0';
  }

  @override
  String timeInMinutes(String count) {
    String _temp0 = intl.Intl.selectLogic(count, {
      '0': '',
      '1': 'uno',
      '2': 'due',
      '3': 'tre',
      '4': 'quattro',
      '5': 'cinque',
      '6': 'sei',
      '7': 'sette',
      '8': 'otto',
      '9': 'nove',
      '10': 'dieci',
      '11': 'undici',
      '12': 'dodici',
      '13': 'tredici',
      '14': 'quattordici',
      '15': 'quindici',
      '16': 'sedici',
      '17': 'diciassette',
      '18': 'diciotto',
      '19': 'diciannove',
      '20': 'venti',
      '21': 'ventuno',
      '22': 'ventidue',
      '23': 'ventitré',
      '24': 'ventiquattro',
      '25': 'venticinque',
      '26': 'ventisei',
      '27': 'ventisette',
      '28': 'ventotto',
      '29': 'ventinove',
      '30': 'trenta',
      '31': 'trentuno',
      '32': 'trentadue',
      '33': 'trentatré',
      '34': 'trentaquattro',
      '35': 'trentacinque',
      '36': 'trentasei',
      '37': 'trentasette',
      '38': 'trentotto',
      '39': 'trentanove',
      '40': 'quaranta',
      '41': 'quarantuno',
      '42': 'quarantadue',
      '43': 'quarantatré',
      '44': 'quarantaquattro',
      '45': 'quarantacinque',
      '46': 'quarantasei',
      '47': 'quarantasette',
      '48': 'quarantotto',
      '49': 'quarantanove',
      '50': 'cinquanta',
      '51': 'cinquantuno',
      '52': 'cinquantadue',
      '53': 'cinquantatré',
      '54': 'cinquantaquattro',
      '55': 'cinquantacinque',
      '56': 'cinquantasei',
      '57': 'cinquantasette',
      '58': 'cinquantotto',
      '59': 'cinquantanove',
      'other': '',
    });
    return '$_temp0';
  }

  @override
  String timeIsExactly(String time) {
    return 'Sono le $time in punto.';
  }

  @override
  String timeIs(String hours, String minutes) {
    return 'Sono le $hours e $minutes.';
  }

  @override
  String get speakTimeOnChange => 'Annuncia l\'ora automaticamente';

  @override
  String get clockThemeText => 'Testo';

  @override
  String timeInSeconds(String count) {
    String _temp0 = intl.Intl.selectLogic(count, {
      '0': '',
      '1': 'uno',
      '2': 'due',
      '3': 'tre',
      '4': 'quattro',
      '5': 'cinque',
      '6': 'sei',
      '7': 'sette',
      '8': 'otto',
      '9': 'nove',
      '10': 'dieci',
      '11': 'undici',
      '12': 'dodici',
      '13': 'tredici',
      '14': 'quattordici',
      '15': 'quindici',
      '16': 'sedici',
      '17': 'diciassette',
      '18': 'diciotto',
      '19': 'diciannove',
      '20': 'venti',
      '21': 'ventuno',
      '22': 'ventidue',
      '23': 'ventitré',
      '24': 'ventiquattro',
      '25': 'venticinque',
      '26': 'ventisei',
      '27': 'ventisette',
      '28': 'ventotto',
      '29': 'ventinove',
      '30': 'trenta',
      '31': 'trentuno',
      '32': 'trentadue',
      '33': 'trentatré',
      '34': 'trentaquattro',
      '35': 'trentacinque',
      '36': 'trentasei',
      '37': 'trentasette',
      '38': 'trentotto',
      '39': 'trentanove',
      '40': 'quaranta',
      '41': 'quarantuno',
      '42': 'quarantadue',
      '43': 'quarantatré',
      '44': 'quarantaquattro',
      '45': 'quarantacinque',
      '46': 'quarantasei',
      '47': 'quarantasette',
      '48': 'quarantotto',
      '49': 'quarantanove',
      '50': 'cinquanta',
      '51': 'cinquantuno',
      '52': 'cinquantadue',
      '53': 'cinquantatré',
      '54': 'cinquantaquattro',
      '55': 'cinquantacinque',
      '56': 'cinquantasei',
      '57': 'cinquantasette',
      '58': 'cinquantotto',
      '59': 'cinquantanove',
      'other': '',
    });
    return '$_temp0';
  }

  @override
  String timeIsAll(String hours, String minutes, String seconds) {
    return 'Sono le $hours ora(e), $minutes minuto(i) e $seconds secondo(i).';
  }

  @override
  String timeIsHourAndSeconds(String hours, String seconds) {
    return 'Sono le $hours ora(e) e $seconds secondo(i).';
  }

  @override
  String get clockThemeAnalog => 'Analogico';

  @override
  String get clockThemeAnalogRoman => 'Analogico (Romano)';

  @override
  String get showClockFrame => 'Mostra cornice orologio';

  @override
  String get use24HourFormat => 'Usa formato 24 ore';

  @override
  String get alarms => 'Sveglie';

  @override
  String get addAlarm => 'Aggiungi sveglia';

  @override
  String get alarmMessageHint => 'Inserisci un messaggio da pronunciare';

  @override
  String get save => 'Salva';

  @override
  String get cancel => 'Annulla';

  @override
  String get delete => 'Elimina';

  @override
  String get noAlarms => 'Nessuna sveglia impostata.';

  @override
  String get settingsAlarms => 'Gestisci sveglie';

  @override
  String get tapToDismiss => 'Tocca per chiudere';

  @override
  String get alarm => 'Sveglia';

  @override
  String alarmDeleted(String alarmName) {
    return 'Sveglia \"$alarmName\" eliminata.';
  }

  @override
  String get daySundayShort => 'D';

  @override
  String get dayMondayShort => 'L';

  @override
  String get dayTuesdayShort => 'M';

  @override
  String get dayWednesdayShort => 'M';

  @override
  String get dayThursdayShort => 'G';

  @override
  String get dayFridayShort => 'V';

  @override
  String get daySaturdayShort => 'S';

  @override
  String get alarmNew => 'Nuova sveglia';

  @override
  String get alarmEdit => 'Modifica sveglia';

  @override
  String get alarmTime => 'Ora';

  @override
  String get alarmLabelHint => 'Etichetta (opzionale)';

  @override
  String get alarmRepeat => 'Ripeti';

  @override
  String get alarmSound => 'Suono sveglia';

  @override
  String get alarmSoundAsset => 'File audio';

  @override
  String get alarmSoundTts => 'Testo parlato';

  @override
  String get alarmTtsHint => 'Testo da pronunciare';

  @override
  String get alarmStopCondition => 'Condizione di arresto';

  @override
  String get alarmStopOnInteraction => 'Al tocco dello schermo';

  @override
  String get alarmStopAfterReps => 'Dopo N ripetizioni';

  @override
  String get alarmRepsHint => 'Numero di ripetizioni';

  @override
  String get soundSelection => 'Suono';

  @override
  String get soundBeep => 'Bip';

  @override
  String get soundRooster => 'Gallo';

  @override
  String get selectAll => 'Seleziona tutto';

  @override
  String get deselectAll => 'Deseleziona tutto';

  @override
  String get accentColorLabel => 'Colore lancetta e evidenziazione';

  @override
  String get themeClassicBlack => 'Nero Classico';

  @override
  String get themeModernBlue => 'Blu Moderno';

  @override
  String get themeMinimalWhite => 'Bianco Minimalista';

  @override
  String get themeRetroGreen => 'Verde Retrò';

  @override
  String get themeGoldLuxury => 'Lusso Oro';

  @override
  String get themeSpaceGray => 'Grigio Spaziale';

  @override
  String get themeRoseGold => 'Oro Rosa';

  @override
  String get themeNightBlue => 'Blu Notte';

  @override
  String get themeIvoryElegance => 'Eleganza Avorio';

  @override
  String get themeDigitalNeon => 'Neon Digitale';

  @override
  String get themeCopperVintage => 'Rame Vintage';

  @override
  String get proThemeMessage => 'Tema esclusivo del piano PRO!';

  @override
  String get upgradeToProTitle => 'Aggiorna a PRO';

  @override
  String get upgradeToProDesc =>
      'Sblocca funzionalità esclusive e rimuovi annunci!';

  @override
  String get noAds => 'Nessun annuncio';

  @override
  String get exclusiveThemes => 'Temi esclusivi';

  @override
  String get supportDeveloper => 'Supporta lo sviluppatore';

  @override
  String get buyFor => 'Compra per';

  @override
  String get buyProVersion => 'Compra versione PRO';

  @override
  String get processing => 'Elaborazione...';

  @override
  String get unavailable => 'Non disponibile';

  @override
  String get restorePurchases => 'Ripristina acquisti';

  @override
  String get loading => 'Caricamento...';
}
