// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'ExacTime';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get appearance => 'Appearance';

  @override
  String get language => 'Language';

  @override
  String get systemDefault => 'System Default';

  @override
  String get english => 'English';

  @override
  String get portuguese => 'Portuguese';

  @override
  String get spanish => 'Spanish';

  @override
  String get german => 'German';

  @override
  String get french => 'French';

  @override
  String get italian => 'Italian';

  @override
  String get theme => 'Theme';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get help => 'Help';

  @override
  String get commandsAndGestures => 'Commands and Gestures';

  @override
  String get clockTheme => 'Clock Theme';

  @override
  String get clockThemeDigital => 'Digital';

  @override
  String get clockThemeFlip => 'Flip';

  @override
  String get adjustments => 'Adjustments';

  @override
  String get fontSize => 'Font Size';

  @override
  String get selectFontSize => 'Select Font Size';

  @override
  String get enableSlidingMovement => 'Enable Sliding Movement';

  @override
  String get showSecondsInPortrait => 'Show seconds in portrait';

  @override
  String get showDate => 'Show Date';

  @override
  String get saveAndClose => 'Save and Close';

  @override
  String get settingsSaved => 'Settings saved successfully';

  @override
  String get ok => 'OK';

  @override
  String get developedBy => 'Developed by allc 🤖';

  @override
  String get aboutTitle => 'About';

  @override
  String get aboutContactLinks => 'Contact and Links:';

  @override
  String get aboutSupportMessage =>
      'If this app was useful to you,\nconsider supporting the development with a coffee ☕!';

  @override
  String get close => 'Close';

  @override
  String get aboutPixCopied => 'PIX key copied!';

  @override
  String get aboutSupportWithPix => 'Support with PIX';

  @override
  String get commandsDialogTitle => 'Commands and Gestures';

  @override
  String get doubleTapCommand => 'Double Tap on Screen';

  @override
  String get doubleTapDescription =>
      'The robot will speak the current time aloud.';

  @override
  String get singleTapCommand => 'Single Tap on Screen';

  @override
  String get singleTapDescription =>
      'Shows or hides the settings button and the developer link.';

  @override
  String get iUnderstand => 'Got it';

  @override
  String get settingsTooltip => 'Settings';

  @override
  String timeInHours(String count) {
    String _temp0 = intl.Intl.selectLogic(
      count,
      {
        '0': 'twelve',
        '1': 'one',
        '2': 'two',
        '3': 'three',
        '4': 'four',
        '5': 'five',
        '6': 'six',
        '7': 'seven',
        '8': 'eight',
        '9': 'nine',
        '10': 'ten',
        '11': 'eleven',
        '12': 'twelve',
        '13': 'one',
        '14': 'two',
        '15': 'three',
        '16': 'four',
        '17': 'five',
        '18': 'six',
        '19': 'seven',
        '20': 'eight',
        '21': 'nine',
        '22': 'ten',
        '23': 'eleven',
        'other': '',
      },
    );
    return '$_temp0';
  }

  @override
  String timeInMinutes(String count) {
    String _temp0 = intl.Intl.selectLogic(
      count,
      {
        '0': '',
        '1': 'oh one',
        '2': 'oh two',
        '3': 'oh three',
        '4': 'oh four',
        '5': 'oh five',
        '6': 'oh six',
        '7': 'oh seven',
        '8': 'oh eight',
        '9': 'oh nine',
        '10': 'ten',
        '11': 'eleven',
        '12': 'twelve',
        '13': 'thirteen',
        '14': 'fourteen',
        '15': 'fifteen',
        '16': 'sixteen',
        '17': 'seventeen',
        '18': 'eighteen',
        '19': 'nineteen',
        '20': 'twenty',
        '21': 'twenty-one',
        '22': 'twenty-two',
        '23': 'twenty-three',
        '24': 'twenty-four',
        '25': 'twenty-five',
        '26': 'twenty-six',
        '27': 'twenty-seven',
        '28': 'twenty-eight',
        '29': 'twenty-nine',
        '30': 'thirty',
        '31': 'thirty-one',
        '32': 'thirty-two',
        '33': 'thirty-three',
        '34': 'thirty-four',
        '35': 'thirty-five',
        '36': 'thirty-six',
        '37': 'thirty-seven',
        '38': 'thirty-eight',
        '39': 'thirty-nine',
        '40': 'forty',
        '41': 'forty-one',
        '42': 'forty-two',
        '43': 'forty-three',
        '44': 'forty-four',
        '45': 'forty-five',
        '46': 'forty-six',
        '47': 'forty-seven',
        '48': 'forty-eight',
        '49': 'forty-nine',
        '50': 'fifty',
        '51': 'fifty-one',
        '52': 'fifty-two',
        '53': 'fifty-three',
        '54': 'fifty-four',
        '55': 'fifty-five',
        '56': 'fifty-six',
        '57': 'fifty-seven',
        '58': 'fifty-eight',
        '59': 'fifty-nine',
        'other': '',
      },
    );
    return '$_temp0';
  }

  @override
  String timeIsExactly(String time) {
    return 'It\'s $time o\'clock.';
  }

  @override
  String timeIs(String hours, String minutes) {
    return 'It\'s $hours $minutes.';
  }

  @override
  String get speakTimeOnChange => 'Speak the time automatically';

  @override
  String get clockThemeText => 'Text';

  @override
  String timeInSeconds(String count) {
    String _temp0 = intl.Intl.selectLogic(
      count,
      {
        '0': '',
        '1': 'one',
        '2': 'two',
        '3': 'three',
        '4': 'four',
        '5': 'five',
        '6': 'six',
        '7': 'seven',
        '8': 'eight',
        '9': 'nine',
        '10': 'ten',
        '11': 'eleven',
        '12': 'twelve',
        '13': 'thirteen',
        '14': 'fourteen',
        '15': 'fifteen',
        '16': 'sixteen',
        '17': 'seventeen',
        '18': 'eighteen',
        '19': 'nineteen',
        '20': 'twenty',
        '21': 'twenty-one',
        '22': 'twenty-two',
        '23': 'twenty-three',
        '24': 'twenty-four',
        '25': 'twenty-five',
        '26': 'twenty-six',
        '27': 'twenty-seven',
        '28': 'twenty-eight',
        '29': 'twenty-nine',
        '30': 'thirty',
        '31': 'thirty-one',
        '32': 'thirty-two',
        '33': 'thirty-three',
        '34': 'thirty-four',
        '35': 'thirty-five',
        '36': 'thirty-six',
        '37': 'thirty-seven',
        '38': 'thirty-eight',
        '39': 'thirty-nine',
        '40': 'forty',
        '41': 'forty-one',
        '42': 'forty-two',
        '43': 'forty-three',
        '44': 'forty-four',
        '45': 'forty-five',
        '46': 'forty-six',
        '47': 'forty-seven',
        '48': 'forty-eight',
        '49': 'forty-nine',
        '50': 'fifty',
        '51': 'fifty-one',
        '52': 'fifty-two',
        '53': 'fifty-three',
        '54': 'fifty-four',
        '55': 'fifty-five',
        '56': 'fifty-six',
        '57': 'fifty-seven',
        '58': 'fifty-eight',
        '59': 'fifty-nine',
        'other': '',
      },
    );
    return '$_temp0';
  }

  @override
  String timeIsAll(String hours, String minutes, String seconds) {
    return 'It\'s $hours hour(s), $minutes minute(s), and $seconds second(s).';
  }

  @override
  String timeIsHourAndSeconds(String hours, String seconds) {
    return 'It\'s $hours hour(s) and $seconds second(s).';
  }

  @override
  String get clockThemeAnalog => 'Analog';

  @override
  String get clockThemeAnalogRoman => 'Analog (Roman)';

  @override
  String get showClockFrame => 'Show clock frame';

  @override
  String get use24HourFormat => 'Use 24-hour format';

  @override
  String get alarms => 'Alarms';

  @override
  String get addAlarm => 'Add Alarm';

  @override
  String get alarmMessageHint => 'Enter a message to be spoken';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get noAlarms => 'No alarms set.';

  @override
  String get settingsAlarms => 'Manage Alarms';

  @override
  String get tapToDismiss => 'Tap to dismiss';

  @override
  String get alarm => 'Alarm';

  @override
  String alarmDeleted(String alarmName) {
    return 'Alarm \"$alarmName\" deleted.';
  }

  @override
  String get daySundayShort => 'S';

  @override
  String get dayMondayShort => 'M';

  @override
  String get dayTuesdayShort => 'T';

  @override
  String get dayWednesdayShort => 'W';

  @override
  String get dayThursdayShort => 'T';

  @override
  String get dayFridayShort => 'F';

  @override
  String get daySaturdayShort => 'S';

  @override
  String get alarmNew => 'New Alarm';

  @override
  String get alarmEdit => 'Edit Alarm';

  @override
  String get alarmTime => 'Time';

  @override
  String get alarmLabelHint => 'Label (optional)';

  @override
  String get alarmRepeat => 'Repeat';

  @override
  String get alarmSound => 'Alarm Sound';

  @override
  String get alarmSoundAsset => 'Sound file';

  @override
  String get alarmSoundTts => 'Spoken Text';

  @override
  String get alarmTtsHint => 'Text to speak';

  @override
  String get alarmStopCondition => 'Stop Condition';

  @override
  String get alarmStopOnInteraction => 'On screen tap';

  @override
  String get alarmStopAfterReps => 'After N repetitions';

  @override
  String get alarmRepsHint => 'Number of repetitions';

  @override
  String get soundSelection => 'Sound';

  @override
  String get soundBeep => 'Beep';

  @override
  String get soundRooster => 'Rooster';

  @override
  String get selectAll => 'Select All';

  @override
  String get deselectAll => 'Deselect All';

  @override
  String get accentColorLabel => 'Pointer and Highlight Color';

  @override
  String get themeClassicBlack => 'Classic Black';

  @override
  String get themeModernBlue => 'Modern Blue';

  @override
  String get themeMinimalWhite => 'Minimal White';

  @override
  String get themeRetroGreen => 'Retro Green';

  @override
  String get themeGoldLuxury => 'Gold Luxury';

  @override
  String get themeSpaceGray => 'Space Gray';

  @override
  String get themeRoseGold => 'Rose Gold';

  @override
  String get themeNightBlue => 'Night Blue';

  @override
  String get themeIvoryElegance => 'Ivory Elegance';

  @override
  String get themeDigitalNeon => 'Digital Neon';

  @override
  String get themeCopperVintage => 'Copper Vintage';

  @override
  String get proThemeMessage => 'Theme exclusive to PRO plan!';

  @override
  String get upgradeToProTitle => 'Upgrade to PRO';

  @override
  String get upgradeToProDesc => 'Unlock exclusive features and remove ads!';

  @override
  String get noAds => 'No Ads';

  @override
  String get exclusiveThemes => 'Exclusive Themes';

  @override
  String get supportDeveloper => 'Support Developer';

  @override
  String get buyFor => 'Buy for';

  @override
  String get buyProVersion => 'Buy PRO Version';

  @override
  String get processing => 'Processing...';

  @override
  String get unavailable => 'Unavailable';

  @override
  String get restorePurchases => 'Restore Purchases';

  @override
  String get loading => 'Loading...';
}
