// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'ExacTime';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get appearance => 'Apariencia';

  @override
  String get language => 'Idioma';

  @override
  String get systemDefault => 'Predeterminado del Sistema';

  @override
  String get english => 'Inglés';

  @override
  String get portuguese => 'Portugués';

  @override
  String get spanish => 'Español';

  @override
  String get german => 'Alemán';

  @override
  String get french => 'Francés';

  @override
  String get italian => 'Italiano';

  @override
  String get theme => 'Tema';

  @override
  String get light => 'Claro';

  @override
  String get dark => 'Oscuro';

  @override
  String get help => 'Ayuda';

  @override
  String get commandsAndGestures => 'Comandos y Gestos';

  @override
  String get clockTheme => 'Tema del Reloj';

  @override
  String get clockThemeDigital => 'Digital';

  @override
  String get clockThemeFlip => 'Flip';

  @override
  String get adjustments => 'Ajustes';

  @override
  String get fontSize => 'Tamaño de Fuente';

  @override
  String get selectFontSize => 'Seleccionar Tamaño de Fuente';

  @override
  String get enableSlidingMovement => 'Activar Movimiento Deslizante';

  @override
  String get showSecondsInPortrait => 'Mostrar segundos (vertical)';

  @override
  String get showDate => 'Mostrar Fecha';

  @override
  String get saveAndClose => 'Guardar y Cerrar';

  @override
  String get settingsSaved => 'Configuración guardada con éxito';

  @override
  String get ok => 'Aceptar';

  @override
  String get developedBy => 'Desarrollado por allc 🤖';

  @override
  String get aboutTitle => 'Acerca de';

  @override
  String get aboutContactLinks => 'Contacto y Enlaces:';

  @override
  String get aboutSupportMessage =>
      'Si esta aplicación te ha sido útil,\n¡considera apoyar el desarrollo con un café ☕!';

  @override
  String get close => 'Cerrar';

  @override
  String get aboutPixCopied => '¡Clave PIX copiada!';

  @override
  String get aboutSupportWithPix => 'Apoyar con PIX';

  @override
  String get commandsDialogTitle => 'Comandos y Gestos';

  @override
  String get doubleTapCommand => 'Doble Toque en la Pantalla';

  @override
  String get doubleTapDescription =>
      'El robot dirá la hora actual en voz alta.';

  @override
  String get singleTapCommand => 'Toque Único en la Pantalla';

  @override
  String get singleTapDescription =>
      'Muestra u oculta el botón de ajustes y el enlace del desarrollador.';

  @override
  String get iUnderstand => 'Entendido';

  @override
  String get settingsTooltip => 'Ajustes';

  @override
  String timeInHours(String count) {
    String _temp0 = intl.Intl.selectLogic(count, {
      '0': 'doce',
      '1': 'una',
      '2': 'dos',
      '3': 'tres',
      '4': 'cuatro',
      '5': 'cinco',
      '6': 'seis',
      '7': 'siete',
      '8': 'ocho',
      '9': 'nueve',
      '10': 'diez',
      '11': 'once',
      '12': 'doce',
      '13': 'una',
      '14': 'dos',
      '15': 'tres',
      '16': 'cuatro',
      '17': 'cinco',
      '18': 'seis',
      '19': 'siete',
      '20': 'ocho',
      '21': 'nueve',
      '22': 'diez',
      '23': 'once',
      'other': '',
    });
    return '$_temp0';
  }

  @override
  String timeInMinutes(String count) {
    String _temp0 = intl.Intl.selectLogic(count, {
      '0': '',
      '1': 'uno',
      '2': 'dos',
      '3': 'tres',
      '4': 'cuatro',
      '5': 'cinco',
      '6': 'seis',
      '7': 'siete',
      '8': 'ocho',
      '9': 'nueve',
      '10': 'diez',
      '11': 'once',
      '12': 'doce',
      '13': 'trece',
      '14': 'catorce',
      '15': 'quince',
      '16': 'dieciséis',
      '17': 'diecisiete',
      '18': 'dieciocho',
      '19': 'diecinueve',
      '20': 'veinte',
      '21': 'veintiuno',
      '22': 'veintidós',
      '23': 'veintitrés',
      '24': 'veinticuatro',
      '25': 'veinticinco',
      '26': 'veintiséis',
      '27': 'veintisiete',
      '28': 'veintiocho',
      '29': 'veintinueve',
      '30': 'treinta',
      '31': 'treinta y uno',
      '32': 'treinta y dos',
      '33': 'treinta y tres',
      '34': 'treinta y cuatro',
      '35': 'treinta y cinco',
      '36': 'treinta y seis',
      '37': 'treinta y siete',
      '38': 'treinta y ocho',
      '39': 'treinta y nueve',
      '40': 'cuarenta',
      '41': 'cuarenta y uno',
      '42': 'cuarenta y dos',
      '43': 'cuarenta y tres',
      '44': 'cuarenta y cuatro',
      '45': 'cuarenta y cinco',
      '46': 'cuarenta y seis',
      '47': 'cuarenta y siete',
      '48': 'cuarenta y ocho',
      '49': 'cuarenta y nueve',
      '50': 'cincuenta',
      '51': 'cincuenta y uno',
      '52': 'cincuenta y dos',
      '53': 'cincuenta y tres',
      '54': 'cincuenta y cuatro',
      '55': 'cincuenta y cinco',
      '56': 'cincuenta y seis',
      '57': 'cincuenta y siete',
      '58': 'cincuenta y ocho',
      '59': 'cincuenta y nueve',
      'other': '',
    });
    return '$_temp0';
  }

  @override
  String timeIsExactly(String time) {
    return 'Son las $time en punto.';
  }

  @override
  String timeIs(String hours, String minutes) {
    return 'Son las $hours y $minutes.';
  }

  @override
  String get speakTimeOnChange => 'Anunciar la hora automáticamente';

  @override
  String get clockThemeText => 'Texto';

  @override
  String timeInSeconds(String count) {
    String _temp0 = intl.Intl.selectLogic(count, {
      '0': '',
      '1': 'un',
      '2': 'dos',
      '3': 'tres',
      '4': 'cuatro',
      '5': 'cinco',
      '6': 'seis',
      '7': 'siete',
      '8': 'ocho',
      '9': 'nueve',
      '10': 'diez',
      '11': 'once',
      '12': 'doce',
      '13': 'trece',
      '14': 'catorce',
      '15': 'quince',
      '16': 'dieciséis',
      '17': 'diecisiete',
      '18': 'dieciocho',
      '19': 'diecinueve',
      '20': 'veinte',
      '21': 'veintiuno',
      '22': 'veintidós',
      '23': 'veintitrés',
      '24': 'veinticuatro',
      '25': 'veinticinco',
      '26': 'veintiséis',
      '27': 'veintisiete',
      '28': 'veintiocho',
      '29': 'veintinueve',
      '30': 'treinta',
      '31': 'treinta y uno',
      '32': 'treinta y dos',
      '33': 'treinta y tres',
      '34': 'treinta y cuatro',
      '35': 'treinta y cinco',
      '36': 'treinta y seis',
      '37': 'treinta y siete',
      '38': 'treinta y ocho',
      '39': 'treinta y nueve',
      '40': 'cuarenta',
      '41': 'cuarenta y uno',
      '42': 'cuarenta y dos',
      '43': 'cuarenta y tres',
      '44': 'cuarenta y cuatro',
      '45': 'cuarenta y cinco',
      '46': 'cuarenta y seis',
      '47': 'cuarenta y siete',
      '48': 'cuarenta y ocho',
      '49': 'cuarenta y nueve',
      '50': 'cincuenta',
      '51': 'cincuenta y uno',
      '52': 'cincuenta y dos',
      '53': 'cincuenta y tres',
      '54': 'cincuenta y cuatro',
      '55': 'cincuenta y cinco',
      '56': 'cincuenta y seis',
      '57': 'cincuenta y siete',
      '58': 'cincuenta y ocho',
      '59': 'cincuenta y nueve',
      'other': '',
    });
    return '$_temp0';
  }

  @override
  String timeIsAll(String hours, String minutes, String seconds) {
    return 'Son las $hours, $minutes y $seconds segundos.';
  }

  @override
  String timeIsHourAndSeconds(String hours, String seconds) {
    return 'Son las $hours y $seconds segundos.';
  }

  @override
  String get clockThemeAnalog => 'Analógico';

  @override
  String get clockThemeAnalogRoman => 'Analógico (Romano)';

  @override
  String get showClockFrame => 'Mostrar marco del reloj';

  @override
  String get use24HourFormat => 'Usar formato de 24 horas';

  @override
  String get alarms => 'Alarmas';

  @override
  String get addAlarm => 'Añadir Alarma';

  @override
  String get alarmMessageHint => 'Escriba un mensaje para ser hablado';

  @override
  String get save => 'Guardar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String get noAlarms => 'No hay alarmas configuradas.';

  @override
  String get settingsAlarms => 'Gestionar Alarmas';

  @override
  String get tapToDismiss => 'Toque para descartar';

  @override
  String get alarm => 'Alarma';

  @override
  String alarmDeleted(String alarmName) {
    return 'Alarma \"$alarmName\" eliminada.';
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
  String get alarmNew => 'Nueva Alarma';

  @override
  String get alarmEdit => 'Editar Alarma';

  @override
  String get alarmTime => 'Hora';

  @override
  String get alarmLabelHint => 'Etiqueta (opcional)';

  @override
  String get alarmRepeat => 'Repetir';

  @override
  String get alarmSound => 'Sonido de la Alarma';

  @override
  String get alarmSoundAsset => 'Archivo de sonido';

  @override
  String get alarmSoundTts => 'Texto Hablado';

  @override
  String get alarmTtsHint => 'Texto para hablar';

  @override
  String get alarmStopCondition => 'Condición de Parada';

  @override
  String get alarmStopOnInteraction => 'Al tocar la pantalla';

  @override
  String get alarmStopAfterReps => 'Tras N repeticiones';

  @override
  String get alarmRepsHint => 'Número de repeticiones';

  @override
  String get soundSelection => 'Sonido';

  @override
  String get soundBeep => 'Bip';

  @override
  String get soundRooster => 'Gallo';

  @override
  String get selectAll => 'Seleccionar Todos';

  @override
  String get deselectAll => 'Desmarcar Todos';

  @override
  String get accentColorLabel => 'Color del puntero y resaltado';

  @override
  String get themeClassicBlack => 'Negro Clásico';

  @override
  String get themeModernBlue => 'Azul Moderno';

  @override
  String get themeMinimalWhite => 'Blanco Minimalista';

  @override
  String get themeRetroGreen => 'Verde Retro';

  @override
  String get themeGoldLuxury => 'Lujo Dorado';

  @override
  String get themeSpaceGray => 'Gris Espacial';

  @override
  String get themeRoseGold => 'Oro Rosado';

  @override
  String get themeNightBlue => 'Azul Nocturno';

  @override
  String get themeIvoryElegance => 'Elegancia Marfil';

  @override
  String get themeDigitalNeon => 'Neón Digital';

  @override
  String get themeCopperVintage => 'Cobre Vintage';

  @override
  String get proThemeMessage => 'Tema exclusivo del plan PRO!';

  @override
  String get upgradeToProTitle => 'Actualizar a PRO';

  @override
  String get upgradeToProDesc =>
      '¡Desbloquea funciones exclusivas y elimina los anuncios!';

  @override
  String get noAds => 'Sin Anuncios';

  @override
  String get exclusiveThemes => 'Temas Exclusivos';

  @override
  String get supportDeveloper => 'Apoyar al Desarrollador';

  @override
  String get buyFor => 'Comprar por';

  @override
  String get buyProVersion => 'Comprar Versión PRO';

  @override
  String get processing => 'Procesando...';

  @override
  String get unavailable => 'No disponible';

  @override
  String get restorePurchases => 'Restaurar Compras';

  @override
  String get loading => 'Cargando...';
}
