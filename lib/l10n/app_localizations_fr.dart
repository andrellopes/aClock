// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'ExacTime';

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get appearance => 'Apparence';

  @override
  String get language => 'Langue';

  @override
  String get systemDefault => 'Par défaut du système';

  @override
  String get english => 'Anglais';

  @override
  String get portuguese => 'Portugais';

  @override
  String get spanish => 'Espagnol';

  @override
  String get german => 'Allemand';

  @override
  String get french => 'Français';

  @override
  String get italian => 'Italien';

  @override
  String get theme => 'Thème';

  @override
  String get light => 'Clair';

  @override
  String get dark => 'Sombre';

  @override
  String get help => 'Aide';

  @override
  String get commandsAndGestures => 'Commandes et gestes';

  @override
  String get clockTheme => 'Thème de l\'horloge';

  @override
  String get clockThemeDigital => 'Numérique';

  @override
  String get clockThemeFlip => 'Flip';

  @override
  String get adjustments => 'Ajustements';

  @override
  String get fontSize => 'Taille de police';

  @override
  String get selectFontSize => 'Sélectionner la taille de police';

  @override
  String get enableSlidingMovement => 'Activer le mouvement coulissant';

  @override
  String get showSecondsInPortrait => 'Afficher les secondes en portrait';

  @override
  String get showDate => 'Afficher la date';

  @override
  String get saveAndClose => 'Enregistrer et fermer';

  @override
  String get settingsSaved => 'Paramètres enregistrés avec succès';

  @override
  String get ok => 'OK';

  @override
  String get developedBy => 'Développé par allc 🤖';

  @override
  String get aboutTitle => 'À propos';

  @override
  String get aboutContactLinks => 'Contact et liens :';

  @override
  String get aboutSupportMessage =>
      'Si cette application vous a été utile,\nconsidérez de soutenir le développement avec un café ☕ !';

  @override
  String get close => 'Fermer';

  @override
  String get aboutPixCopied => 'Clé PIX copiée !';

  @override
  String get aboutSupportWithPix => 'Soutenir avec PIX';

  @override
  String get commandsDialogTitle => 'Commandes et gestes';

  @override
  String get doubleTapCommand => 'Double appui sur l\'écran';

  @override
  String get doubleTapDescription =>
      'Le robot annonce l\'heure actuelle à voix haute.';

  @override
  String get singleTapCommand => 'Appui simple sur l\'écran';

  @override
  String get singleTapDescription =>
      'Affiche ou masque le bouton de paramètres et le lien développeur.';

  @override
  String get iUnderstand => 'Compris';

  @override
  String get settingsTooltip => 'Paramètres';

  @override
  String timeInHours(String count) {
    String _temp0 = intl.Intl.selectLogic(count, {
      '0': 'douze',
      '1': 'une',
      '2': 'deux',
      '3': 'trois',
      '4': 'quatre',
      '5': 'cinq',
      '6': 'six',
      '7': 'sept',
      '8': 'huit',
      '9': 'neuf',
      '10': 'dix',
      '11': 'onze',
      '12': 'douze',
      '13': 'une',
      '14': 'deux',
      '15': 'trois',
      '16': 'quatre',
      '17': 'cinq',
      '18': 'six',
      '19': 'sept',
      '20': 'huit',
      '21': 'neuf',
      '22': 'dix',
      '23': 'onze',
      'other': '',
    });
    return '$_temp0';
  }

  @override
  String timeInMinutes(String count) {
    String _temp0 = intl.Intl.selectLogic(count, {
      '0': '',
      '1': 'une',
      '2': 'deux',
      '3': 'trois',
      '4': 'quatre',
      '5': 'cinq',
      '6': 'six',
      '7': 'sept',
      '8': 'huit',
      '9': 'neuf',
      '10': 'dix',
      '11': 'onze',
      '12': 'douze',
      '13': 'treize',
      '14': 'quatorze',
      '15': 'quinze',
      '16': 'seize',
      '17': 'dix-sept',
      '18': 'dix-huit',
      '19': 'dix-neuf',
      '20': 'vingt',
      '21': 'vingt-et-un',
      '22': 'vingt-deux',
      '23': 'vingt-trois',
      '24': 'vingt-quatre',
      '25': 'vingt-cinq',
      '26': 'vingt-six',
      '27': 'vingt-sept',
      '28': 'vingt-huit',
      '29': 'vingt-neuf',
      '30': 'trente',
      '31': 'trente-et-un',
      '32': 'trente-deux',
      '33': 'trente-trois',
      '34': 'trente-quatre',
      '35': 'trente-cinq',
      '36': 'trente-six',
      '37': 'trente-sept',
      '38': 'trente-huit',
      '39': 'trente-neuf',
      '40': 'quarante',
      '41': 'quarante-et-un',
      '42': 'quarante-deux',
      '43': 'quarante-trois',
      '44': 'quarante-quatre',
      '45': 'quarante-cinq',
      '46': 'quarante-six',
      '47': 'quarante-sept',
      '48': 'quarante-huit',
      '49': 'quarante-neuf',
      '50': 'cinquante',
      '51': 'cinquante-et-un',
      '52': 'cinquante-deux',
      '53': 'cinquante-trois',
      '54': 'cinquante-quatre',
      '55': 'cinquante-cinq',
      '56': 'cinquante-six',
      '57': 'cinquante-sept',
      '58': 'cinquante-huit',
      '59': 'cinquante-neuf',
      'other': '',
    });
    return '$_temp0';
  }

  @override
  String timeIsExactly(String time) {
    return 'Il est $time heure(s).';
  }

  @override
  String timeIs(String hours, String minutes) {
    return 'Il est $hours $minutes.';
  }

  @override
  String get speakTimeOnChange => 'Annoncer l\'heure automatiquement';

  @override
  String get clockThemeText => 'Texte';

  @override
  String timeInSeconds(String count) {
    String _temp0 = intl.Intl.selectLogic(count, {
      '0': '',
      '1': 'une',
      '2': 'deux',
      '3': 'trois',
      '4': 'quatre',
      '5': 'cinq',
      '6': 'six',
      '7': 'sept',
      '8': 'huit',
      '9': 'neuf',
      '10': 'dix',
      '11': 'onze',
      '12': 'douze',
      '13': 'treize',
      '14': 'quatorze',
      '15': 'quinze',
      '16': 'seize',
      '17': 'dix-sept',
      '18': 'dix-huit',
      '19': 'dix-neuf',
      '20': 'vingt',
      '21': 'vingt-et-un',
      '22': 'vingt-deux',
      '23': 'vingt-trois',
      '24': 'vingt-quatre',
      '25': 'vingt-cinq',
      '26': 'vingt-six',
      '27': 'vingt-sept',
      '28': 'vingt-huit',
      '29': 'vingt-neuf',
      '30': 'trente',
      '31': 'trente-et-un',
      '32': 'trente-deux',
      '33': 'trente-trois',
      '34': 'trente-quatre',
      '35': 'trente-cinq',
      '36': 'trente-six',
      '37': 'trente-sept',
      '38': 'trente-huit',
      '39': 'trente-neuf',
      '40': 'quarante',
      '41': 'quarante-et-un',
      '42': 'quarante-deux',
      '43': 'quarante-trois',
      '44': 'quarante-quatre',
      '45': 'quarante-cinq',
      '46': 'quarante-six',
      '47': 'quarante-sept',
      '48': 'quarante-huit',
      '49': 'quarante-neuf',
      '50': 'cinquante',
      '51': 'cinquante-et-un',
      '52': 'cinquante-deux',
      '53': 'cinquante-trois',
      '54': 'cinquante-quatre',
      '55': 'cinquante-cinq',
      '56': 'cinquante-six',
      '57': 'cinquante-sept',
      '58': 'cinquante-huit',
      '59': 'cinquante-neuf',
      'other': '',
    });
    return '$_temp0';
  }

  @override
  String timeIsAll(String hours, String minutes, String seconds) {
    return 'Il est $hours heure(s), $minutes minute(s) et $seconds seconde(s).';
  }

  @override
  String timeIsHourAndSeconds(String hours, String seconds) {
    return 'Il est $hours heure(s) et $seconds seconde(s).';
  }

  @override
  String get clockThemeAnalog => 'Analogique';

  @override
  String get clockThemeAnalogRoman => 'Analogique (Romain)';

  @override
  String get showClockFrame => 'Afficher le cadre de l\'horloge';

  @override
  String get use24HourFormat => 'Utiliser le format 24 heures';

  @override
  String get alarms => 'Alarmes';

  @override
  String get addAlarm => 'Ajouter une alarme';

  @override
  String get alarmMessageHint => 'Entrez un message à prononcer';

  @override
  String get save => 'Enregistrer';

  @override
  String get cancel => 'Annuler';

  @override
  String get delete => 'Supprimer';

  @override
  String get noAlarms => 'Aucune alarme définie.';

  @override
  String get settingsAlarms => 'Gérer les alarmes';

  @override
  String get tapToDismiss => 'Appuyer pour rejeter';

  @override
  String get alarm => 'Alarme';

  @override
  String alarmDeleted(String alarmName) {
    return 'Alarme \"$alarmName\" supprimée.';
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
  String get dayThursdayShort => 'J';

  @override
  String get dayFridayShort => 'V';

  @override
  String get daySaturdayShort => 'S';

  @override
  String get alarmNew => 'Nouvelle alarme';

  @override
  String get alarmEdit => 'Modifier l\'alarme';

  @override
  String get alarmTime => 'Heure';

  @override
  String get alarmLabelHint => 'Étiquette (optionnel)';

  @override
  String get alarmRepeat => 'Répéter';

  @override
  String get alarmSound => 'Son de l\'alarme';

  @override
  String get alarmSoundAsset => 'Fichier audio';

  @override
  String get alarmSoundTts => 'Texte parlé';

  @override
  String get alarmTtsHint => 'Texte à prononcer';

  @override
  String get alarmStopCondition => 'Condition d\'arrêt';

  @override
  String get alarmStopOnInteraction => 'À l\'appui sur l\'écran';

  @override
  String get alarmStopAfterReps => 'Après N répétitions';

  @override
  String get alarmRepsHint => 'Nombre de répétitions';

  @override
  String get soundSelection => 'Son';

  @override
  String get soundBeep => 'Bip';

  @override
  String get soundRooster => 'Coq';

  @override
  String get selectAll => 'Tout sélectionner';

  @override
  String get deselectAll => 'Tout désélectionner';

  @override
  String get accentColorLabel => 'Couleur du pointeur et de surbrillance';

  @override
  String get themeClassicBlack => 'Noir Classique';

  @override
  String get themeModernBlue => 'Bleu Moderne';

  @override
  String get themeMinimalWhite => 'Blanc Minimaliste';

  @override
  String get themeRetroGreen => 'Vert Rétro';

  @override
  String get themeGoldLuxury => 'Luxe Doré';

  @override
  String get themeSpaceGray => 'Gris Spatial';

  @override
  String get themeRoseGold => 'Or Rosé';

  @override
  String get themeNightBlue => 'Bleu Nuit';

  @override
  String get themeIvoryElegance => 'Élégance Ivoire';

  @override
  String get themeDigitalNeon => 'Néon Numérique';

  @override
  String get themeCopperVintage => 'Cuivre Vintage';

  @override
  String get proThemeMessage => 'Thème exclusif au plan PRO !';

  @override
  String get upgradeToProTitle => 'Passer à PRO';

  @override
  String get upgradeToProDesc =>
      'Débloquez des fonctionnalités exclusives et supprimez les publicités !';

  @override
  String get noAds => 'Pas de publicités';

  @override
  String get exclusiveThemes => 'Thèmes exclusifs';

  @override
  String get supportDeveloper => 'Soutenir le développeur';

  @override
  String get buyFor => 'Acheter pour';

  @override
  String get buyProVersion => 'Acheter la version PRO';

  @override
  String get processing => 'Traitement...';

  @override
  String get unavailable => 'Indisponible';

  @override
  String get restorePurchases => 'Restaurer les achats';

  @override
  String get loading => 'Chargement...';
}
