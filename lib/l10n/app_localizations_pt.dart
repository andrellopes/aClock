// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'ExacTime';

  @override
  String get settingsTitle => 'Configurações';

  @override
  String get appearance => 'Aparência';

  @override
  String get language => 'Idioma';

  @override
  String get systemDefault => 'Padrão do Sistema';

  @override
  String get english => 'Inglês';

  @override
  String get portuguese => 'Português';

  @override
  String get spanish => 'Espanhol';

  @override
  String get german => 'Alemão';

  @override
  String get french => 'Francês';

  @override
  String get italian => 'Italiano';

  @override
  String get theme => 'Tema';

  @override
  String get light => 'Claro';

  @override
  String get dark => 'Escuro';

  @override
  String get help => 'Ajuda';

  @override
  String get commandsAndGestures => 'Comandos e Gestos';

  @override
  String get clockTheme => 'Tema do Relógio';

  @override
  String get clockThemeDigital => 'Digital';

  @override
  String get clockThemeFlip => 'Flip';

  @override
  String get adjustments => 'Ajustes';

  @override
  String get fontSize => 'Tamanho da Fonte';

  @override
  String get selectFontSize => 'Selecionar Tamanho da Fonte';

  @override
  String get enableSlidingMovement => 'Ativar Movimento Deslizante';

  @override
  String get showSecondsInPortrait => 'Exibir segundos (retrato)';

  @override
  String get showDate => 'Exibir Data';

  @override
  String get saveAndClose => 'Salvar e Fechar';

  @override
  String get settingsSaved => 'Configurações salvas com sucesso';

  @override
  String get ok => 'OK';

  @override
  String get developedBy => 'Desenvolvido por allc 🤖';

  @override
  String get aboutTitle => 'Sobre';

  @override
  String get aboutContactLinks => 'Contato e Links:';

  @override
  String get aboutSupportMessage =>
      'Se este aplicativo foi útil para você,\nconsidere apoiar o desenvolvimento com um café ☕!';

  @override
  String get close => 'Fechar';

  @override
  String get aboutPixCopied => 'Chave PIX copiada!';

  @override
  String get aboutSupportWithPix => 'Apoiar com PIX';

  @override
  String get commandsDialogTitle => 'Comandos e Gestos';

  @override
  String get doubleTapCommand => 'Toque Duplo na Tela';

  @override
  String get doubleTapDescription => 'O robô falará a hora atual em voz alta.';

  @override
  String get singleTapCommand => 'Toque Único na Tela';

  @override
  String get singleTapDescription =>
      'Exibe ou esconde o botão de configurações e o link de desenvolvedor.';

  @override
  String get iUnderstand => 'Entendi';

  @override
  String get settingsTooltip => 'Configurações';

  @override
  String timeInHours(String count) {
    String _temp0 = intl.Intl.selectLogic(
      count,
      {
        '0': 'doze',
        '1': 'uma',
        '2': 'duas',
        '3': 'três',
        '4': 'quatro',
        '5': 'cinco',
        '6': 'seis',
        '7': 'sete',
        '8': 'oito',
        '9': 'nove',
        '10': 'dez',
        '11': 'onze',
        '12': 'doze',
        '13': 'uma',
        '14': 'duas',
        '15': 'três',
        '16': 'quatro',
        '17': 'cinco',
        '18': 'seis',
        '19': 'sete',
        '20': 'oito',
        '21': 'nove',
        '22': 'dez',
        '23': 'onze',
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
        '1': 'um',
        '2': 'dois',
        '3': 'três',
        '4': 'quatro',
        '5': 'cinco',
        '6': 'seis',
        '7': 'sete',
        '8': 'oito',
        '9': 'nove',
        '10': 'dez',
        '11': 'onze',
        '12': 'doze',
        '13': 'treze',
        '14': 'quatorze',
        '15': 'quinze',
        '16': 'dezesseis',
        '17': 'dezessete',
        '18': 'dezoito',
        '19': 'dezenove',
        '20': 'vinte',
        '21': 'vinte e um',
        '22': 'vinte e dois',
        '23': 'vinte e três',
        '24': 'vinte e quatro',
        '25': 'vinte e cinco',
        '26': 'vinte e seis',
        '27': 'vinte e sete',
        '28': 'vinte e oito',
        '29': 'vinte e nove',
        '30': 'trinta',
        '31': 'trinta e um',
        '32': 'trinta e dois',
        '33': 'trinta e três',
        '34': 'trinta e quatro',
        '35': 'trinta e cinco',
        '36': 'trinta e seis',
        '37': 'trinta e sete',
        '38': 'trinta e oito',
        '39': 'trinta e nove',
        '40': 'quarenta',
        '41': 'quarenta e um',
        '42': 'quarenta e dois',
        '43': 'quarenta e três',
        '44': 'quarenta e quatro',
        '45': 'quarenta e cinco',
        '46': 'quarenta e seis',
        '47': 'quarenta e sete',
        '48': 'quarenta e oito',
        '49': 'quarenta e nove',
        '50': 'cinquenta',
        '51': 'cinquenta e um',
        '52': 'cinquenta e dois',
        '53': 'cinquenta e três',
        '54': 'cinquenta e quatro',
        '55': 'cinquenta e cinco',
        '56': 'cinquenta e seis',
        '57': 'cinquenta e sete',
        '58': 'cinquenta e oito',
        '59': 'cinquenta e nove',
        'other': '',
      },
    );
    return '$_temp0';
  }

  @override
  String timeIsExactly(String time) {
    return 'São $time em ponto.';
  }

  @override
  String timeIs(String hours, String minutes) {
    return 'São $hours e $minutes.';
  }

  @override
  String get speakTimeOnChange => 'Anunciar hora automaticamente';

  @override
  String get clockThemeText => 'Texto';

  @override
  String timeInSeconds(String count) {
    String _temp0 = intl.Intl.selectLogic(
      count,
      {
        '0': '',
        '1': 'um',
        '2': 'dois',
        '3': 'três',
        '4': 'quatro',
        '5': 'cinco',
        '6': 'seis',
        '7': 'sete',
        '8': 'oito',
        '9': 'nove',
        '10': 'dez',
        '11': 'onze',
        '12': 'doze',
        '13': 'treze',
        '14': 'quatorze',
        '15': 'quinze',
        '16': 'dezesseis',
        '17': 'dezessete',
        '18': 'dezoito',
        '19': 'dezenove',
        '20': 'vinte',
        '21': 'vinte e um',
        '22': 'vinte e dois',
        '23': 'vinte e três',
        '24': 'vinte e quatro',
        '25': 'vinte e cinco',
        '26': 'vinte e seis',
        '27': 'vinte e sete',
        '28': 'vinte e oito',
        '29': 'vinte e nove',
        '30': 'trinta',
        '31': 'trinta e um',
        '32': 'trinta e dois',
        '33': 'trinta e três',
        '34': 'trinta e quatro',
        '35': 'trinta e cinco',
        '36': 'trinta e seis',
        '37': 'trinta e sete',
        '38': 'trinta e oito',
        '39': 'trinta e nove',
        '40': 'quarenta',
        '41': 'quarenta e um',
        '42': 'quarenta e dois',
        '43': 'quarenta e três',
        '44': 'quarenta e quatro',
        '45': 'quarenta e cinco',
        '46': 'quarenta e seis',
        '47': 'quarenta e sete',
        '48': 'quarenta e oito',
        '49': 'quarenta e nove',
        '50': 'cinquenta',
        '51': 'cinquenta e um',
        '52': 'cinquenta e dois',
        '53': 'cinquenta e três',
        '54': 'cinquenta e quatro',
        '55': 'cinquenta e cinco',
        '56': 'cinquenta e seis',
        '57': 'cinquenta e sete',
        '58': 'cinquenta e oito',
        '59': 'cinquenta e nove',
        'other': '',
      },
    );
    return '$_temp0';
  }

  @override
  String timeIsAll(String hours, String minutes, String seconds) {
    return 'São $hours hora(s), $minutes minuto(s) e $seconds segundo(s).';
  }

  @override
  String timeIsHourAndSeconds(String hours, String seconds) {
    return 'São $hours hora(s) e $seconds segundo(s).';
  }

  @override
  String get clockThemeAnalog => 'Analógico';

  @override
  String get clockThemeAnalogRoman => 'Analógico (Romano)';

  @override
  String get showClockFrame => 'Exibir aro do relógio';

  @override
  String get use24HourFormat => 'Usar formato 24 horas';

  @override
  String get alarms => 'Alarmes';

  @override
  String get addAlarm => 'Adicionar Alarme';

  @override
  String get alarmMessageHint => 'Digite uma mensagem para ser falada';

  @override
  String get save => 'Salvar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Excluir';

  @override
  String get noAlarms => 'Nenhum alarme configurado.';

  @override
  String get settingsAlarms => 'Gerenciar Alarmes';

  @override
  String get tapToDismiss => 'Toque para dispensar';

  @override
  String get alarm => 'Alarme';

  @override
  String alarmDeleted(String alarmName) {
    return 'Alarme \"$alarmName\" excluído.';
  }

  @override
  String get daySundayShort => 'D';

  @override
  String get dayMondayShort => 'S';

  @override
  String get dayTuesdayShort => 'T';

  @override
  String get dayWednesdayShort => 'Q';

  @override
  String get dayThursdayShort => 'Q';

  @override
  String get dayFridayShort => 'S';

  @override
  String get daySaturdayShort => 'S';

  @override
  String get alarmNew => 'Novo Alarme';

  @override
  String get alarmEdit => 'Editar Alarme';

  @override
  String get alarmTime => 'Horário';

  @override
  String get alarmLabelHint => 'Etiqueta (opcional)';

  @override
  String get alarmRepeat => 'Repetir';

  @override
  String get alarmSound => 'Som do Alarme';

  @override
  String get alarmSoundAsset => 'Som de arquivo';

  @override
  String get alarmSoundTts => 'Texto Falado';

  @override
  String get alarmTtsHint => 'Texto para falar';

  @override
  String get alarmStopCondition => 'Condição de Parada';

  @override
  String get alarmStopOnInteraction => 'Ao tocar na tela';

  @override
  String get alarmStopAfterReps => 'Após N repetições';

  @override
  String get alarmRepsHint => 'Número de repetições';

  @override
  String get soundSelection => 'Som';

  @override
  String get soundBeep => 'Bip';

  @override
  String get soundRooster => 'Galo';

  @override
  String get selectAll => 'Selecionar Todos';

  @override
  String get deselectAll => 'Desmarcar Todos';

  @override
  String get accentColorLabel => 'Cor do Ponteiro e Destaque';

  @override
  String get themeClassicBlack => 'Preto Clássico';

  @override
  String get themeModernBlue => 'Azul Moderno';

  @override
  String get themeMinimalWhite => 'Branco Minimalista';

  @override
  String get themeRetroGreen => 'Verde Retrô';

  @override
  String get themeGoldLuxury => 'Luxo Dourado';

  @override
  String get themeSpaceGray => 'Cinza Espacial';

  @override
  String get themeRoseGold => 'Ouro Rosé';

  @override
  String get themeNightBlue => 'Azul da Noite';

  @override
  String get themeIvoryElegance => 'Elegância Marfim';

  @override
  String get themeDigitalNeon => 'Neon Digital';

  @override
  String get themeCopperVintage => 'Cobre Vintage';

  @override
  String get proThemeMessage => 'Tema exclusivo do plano PRO!';

  @override
  String get upgradeToProTitle => 'Atualizar para PRO';

  @override
  String get upgradeToProDesc =>
      'Desbloqueie recursos exclusivos e remova os anúncios!';

  @override
  String get noAds => 'Sem Anúncios';

  @override
  String get exclusiveThemes => 'Temas Exclusivos';

  @override
  String get supportDeveloper => 'Apoie o Desenvolvedor';

  @override
  String get buyFor => 'Comprar por';

  @override
  String get buyProVersion => 'Comprar Versão PRO';

  @override
  String get processing => 'Processando...';

  @override
  String get unavailable => 'Indisponível';

  @override
  String get restorePurchases => 'Restaurar Compras';

  @override
  String get loading => 'Carregando...';
}
