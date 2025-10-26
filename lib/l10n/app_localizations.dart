import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('pt')
  ];

  /// No description provided for @appTitle.
  ///
  /// In pt, this message translates to:
  /// **'ExacTime'**
  String get appTitle;

  /// No description provided for @settingsTitle.
  ///
  /// In pt, this message translates to:
  /// **'Configurações'**
  String get settingsTitle;

  /// No description provided for @appearance.
  ///
  /// In pt, this message translates to:
  /// **'Aparência'**
  String get appearance;

  /// No description provided for @language.
  ///
  /// In pt, this message translates to:
  /// **'Idioma'**
  String get language;

  /// No description provided for @systemDefault.
  ///
  /// In pt, this message translates to:
  /// **'Padrão do Sistema'**
  String get systemDefault;

  /// No description provided for @english.
  ///
  /// In pt, this message translates to:
  /// **'Inglês'**
  String get english;

  /// No description provided for @portuguese.
  ///
  /// In pt, this message translates to:
  /// **'Português'**
  String get portuguese;

  /// No description provided for @spanish.
  ///
  /// In pt, this message translates to:
  /// **'Espanhol'**
  String get spanish;

  /// No description provided for @german.
  ///
  /// In pt, this message translates to:
  /// **'Alemão'**
  String get german;

  /// No description provided for @french.
  ///
  /// In pt, this message translates to:
  /// **'Francês'**
  String get french;

  /// No description provided for @italian.
  ///
  /// In pt, this message translates to:
  /// **'Italiano'**
  String get italian;

  /// No description provided for @theme.
  ///
  /// In pt, this message translates to:
  /// **'Tema'**
  String get theme;

  /// No description provided for @light.
  ///
  /// In pt, this message translates to:
  /// **'Claro'**
  String get light;

  /// No description provided for @dark.
  ///
  /// In pt, this message translates to:
  /// **'Escuro'**
  String get dark;

  /// No description provided for @help.
  ///
  /// In pt, this message translates to:
  /// **'Ajuda'**
  String get help;

  /// No description provided for @commandsAndGestures.
  ///
  /// In pt, this message translates to:
  /// **'Comandos e Gestos'**
  String get commandsAndGestures;

  /// No description provided for @clockTheme.
  ///
  /// In pt, this message translates to:
  /// **'Tema do Relógio'**
  String get clockTheme;

  /// No description provided for @clockThemeDigital.
  ///
  /// In pt, this message translates to:
  /// **'Digital'**
  String get clockThemeDigital;

  /// No description provided for @clockThemeFlip.
  ///
  /// In pt, this message translates to:
  /// **'Flip'**
  String get clockThemeFlip;

  /// No description provided for @adjustments.
  ///
  /// In pt, this message translates to:
  /// **'Ajustes'**
  String get adjustments;

  /// No description provided for @fontSize.
  ///
  /// In pt, this message translates to:
  /// **'Tamanho da Fonte'**
  String get fontSize;

  /// No description provided for @selectFontSize.
  ///
  /// In pt, this message translates to:
  /// **'Selecionar Tamanho da Fonte'**
  String get selectFontSize;

  /// No description provided for @enableSlidingMovement.
  ///
  /// In pt, this message translates to:
  /// **'Ativar Movimento Deslizante'**
  String get enableSlidingMovement;

  /// No description provided for @showSecondsInPortrait.
  ///
  /// In pt, this message translates to:
  /// **'Exibir segundos (retrato)'**
  String get showSecondsInPortrait;

  /// No description provided for @showDate.
  ///
  /// In pt, this message translates to:
  /// **'Exibir Data'**
  String get showDate;

  /// No description provided for @saveAndClose.
  ///
  /// In pt, this message translates to:
  /// **'Salvar e Fechar'**
  String get saveAndClose;

  /// No description provided for @settingsSaved.
  ///
  /// In pt, this message translates to:
  /// **'Configurações salvas com sucesso'**
  String get settingsSaved;

  /// No description provided for @ok.
  ///
  /// In pt, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @developedBy.
  ///
  /// In pt, this message translates to:
  /// **'Desenvolvido por allc 🤖'**
  String get developedBy;

  /// No description provided for @aboutTitle.
  ///
  /// In pt, this message translates to:
  /// **'Sobre'**
  String get aboutTitle;

  /// No description provided for @aboutContactLinks.
  ///
  /// In pt, this message translates to:
  /// **'Contato e Links:'**
  String get aboutContactLinks;

  /// No description provided for @aboutSupportMessage.
  ///
  /// In pt, this message translates to:
  /// **'Se este aplicativo foi útil para você,\nconsidere apoiar o desenvolvimento com um café ☕!'**
  String get aboutSupportMessage;

  /// No description provided for @close.
  ///
  /// In pt, this message translates to:
  /// **'Fechar'**
  String get close;

  /// No description provided for @aboutPixCopied.
  ///
  /// In pt, this message translates to:
  /// **'Chave PIX copiada!'**
  String get aboutPixCopied;

  /// No description provided for @aboutSupportWithPix.
  ///
  /// In pt, this message translates to:
  /// **'Apoiar com PIX'**
  String get aboutSupportWithPix;

  /// No description provided for @commandsDialogTitle.
  ///
  /// In pt, this message translates to:
  /// **'Comandos e Gestos'**
  String get commandsDialogTitle;

  /// No description provided for @doubleTapCommand.
  ///
  /// In pt, this message translates to:
  /// **'Toque Duplo na Tela'**
  String get doubleTapCommand;

  /// No description provided for @doubleTapDescription.
  ///
  /// In pt, this message translates to:
  /// **'O robô falará a hora atual em voz alta.'**
  String get doubleTapDescription;

  /// No description provided for @singleTapCommand.
  ///
  /// In pt, this message translates to:
  /// **'Toque Único na Tela'**
  String get singleTapCommand;

  /// No description provided for @singleTapDescription.
  ///
  /// In pt, this message translates to:
  /// **'Exibe ou esconde o botão de configurações e o link de desenvolvedor.'**
  String get singleTapDescription;

  /// No description provided for @iUnderstand.
  ///
  /// In pt, this message translates to:
  /// **'Entendi'**
  String get iUnderstand;

  /// No description provided for @settingsTooltip.
  ///
  /// In pt, this message translates to:
  /// **'Configurações'**
  String get settingsTooltip;

  /// Converte o número da hora em palavra para o TTS. Trata o formato 24h, convertendo para 12h para a fala.
  ///
  /// In pt, this message translates to:
  /// **'{count,select, 0{doze} 1{uma} 2{duas} 3{três} 4{quatro} 5{cinco} 6{seis} 7{sete} 8{oito} 9{nove} 10{dez} 11{onze} 12{doze} 13{uma} 14{duas} 15{três} 16{quatro} 17{cinco} 18{seis} 19{sete} 20{oito} 21{nove} 22{dez} 23{onze} other{}}'**
  String timeInHours(String count);

  /// Converte o número do minuto em palavra para o TTS.
  ///
  /// In pt, this message translates to:
  /// **'{count,select, 0{} 1{um} 2{dois} 3{três} 4{quatro} 5{cinco} 6{seis} 7{sete} 8{oito} 9{nove} 10{dez} 11{onze} 12{doze} 13{treze} 14{quatorze} 15{quinze} 16{dezesseis} 17{dezessete} 18{dezoito} 19{dezenove} 20{vinte} 21{vinte e um} 22{vinte e dois} 23{vinte e três} 24{vinte e quatro} 25{vinte e cinco} 26{vinte e seis} 27{vinte e sete} 28{vinte e oito} 29{vinte e nove} 30{trinta} 31{trinta e um} 32{trinta e dois} 33{trinta e três} 34{trinta e quatro} 35{trinta e cinco} 36{trinta e seis} 37{trinta e sete} 38{trinta e oito} 39{trinta e nove} 40{quarenta} 41{quarenta e um} 42{quarenta e dois} 43{quarenta e três} 44{quarenta e quatro} 45{quarenta e cinco} 46{quarenta e seis} 47{quarenta e sete} 48{quarenta e oito} 49{quarenta e nove} 50{cinquenta} 51{cinquenta e um} 52{cinquenta e dois} 53{cinquenta e três} 54{cinquenta e quatro} 55{cinquenta e cinco} 56{cinquenta e seis} 57{cinquenta e sete} 58{cinquenta e oito} 59{cinquenta e nove} other{}}'**
  String timeInMinutes(String count);

  /// Frase para dizer a hora exata.
  ///
  /// In pt, this message translates to:
  /// **'São {time} em ponto.'**
  String timeIsExactly(String time);

  /// Frase para dizer a hora com horas e minutos.
  ///
  /// In pt, this message translates to:
  /// **'São {hours} e {minutes}.'**
  String timeIs(String hours, String minutes);

  /// No description provided for @speakTimeOnChange.
  ///
  /// In pt, this message translates to:
  /// **'Anunciar hora automaticamente'**
  String get speakTimeOnChange;

  /// The name for the text-based clock theme
  ///
  /// In pt, this message translates to:
  /// **'Texto'**
  String get clockThemeText;

  /// Converte o número do segundo em palavra.
  ///
  /// In pt, this message translates to:
  /// **'{count,select, 0{} 1{um} 2{dois} 3{três} 4{quatro} 5{cinco} 6{seis} 7{sete} 8{oito} 9{nove} 10{dez} 11{onze} 12{doze} 13{treze} 14{quatorze} 15{quinze} 16{dezesseis} 17{dezessete} 18{dezoito} 19{dezenove} 20{vinte} 21{vinte e um} 22{vinte e dois} 23{vinte e três} 24{vinte e quatro} 25{vinte e cinco} 26{vinte e seis} 27{vinte e sete} 28{vinte e oito} 29{vinte e nove} 30{trinta} 31{trinta e um} 32{trinta e dois} 33{trinta e três} 34{trinta e quatro} 35{trinta e cinco} 36{trinta e seis} 37{trinta e sete} 38{trinta e oito} 39{trinta e nove} 40{quarenta} 41{quarenta e um} 42{quarenta e dois} 43{quarenta e três} 44{quarenta e quatro} 45{quarenta e cinco} 46{quarenta e seis} 47{quarenta e sete} 48{quarenta e oito} 49{quarenta e nove} 50{cinquenta} 51{cinquenta e um} 52{cinquenta e dois} 53{cinquenta e três} 54{cinquenta e quatro} 55{cinquenta e cinco} 56{cinquenta e seis} 57{cinquenta e sete} 58{cinquenta e oito} 59{cinquenta e nove} other{}}'**
  String timeInSeconds(String count);

  /// Frase para exibir a hora com horas, minutos e segundos.
  ///
  /// In pt, this message translates to:
  /// **'São {hours} hora(s), {minutes} minuto(s) e {seconds} segundo(s).'**
  String timeIsAll(String hours, String minutes, String seconds);

  /// Frase para exibir a hora com horas e segundos (quando o minuto é zero).
  ///
  /// In pt, this message translates to:
  /// **'São {hours} hora(s) e {seconds} segundo(s).'**
  String timeIsHourAndSeconds(String hours, String seconds);

  /// No description provided for @clockThemeAnalog.
  ///
  /// In pt, this message translates to:
  /// **'Analógico'**
  String get clockThemeAnalog;

  /// No description provided for @clockThemeAnalogRoman.
  ///
  /// In pt, this message translates to:
  /// **'Analógico (Romano)'**
  String get clockThemeAnalogRoman;

  /// No description provided for @showClockFrame.
  ///
  /// In pt, this message translates to:
  /// **'Exibir aro do relógio'**
  String get showClockFrame;

  /// No description provided for @use24HourFormat.
  ///
  /// In pt, this message translates to:
  /// **'Usar formato 24 horas'**
  String get use24HourFormat;

  /// No description provided for @alarms.
  ///
  /// In pt, this message translates to:
  /// **'Alarmes'**
  String get alarms;

  /// No description provided for @addAlarm.
  ///
  /// In pt, this message translates to:
  /// **'Adicionar Alarme'**
  String get addAlarm;

  /// No description provided for @alarmMessageHint.
  ///
  /// In pt, this message translates to:
  /// **'Digite uma mensagem para ser falada'**
  String get alarmMessageHint;

  /// No description provided for @save.
  ///
  /// In pt, this message translates to:
  /// **'Salvar'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In pt, this message translates to:
  /// **'Cancelar'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In pt, this message translates to:
  /// **'Excluir'**
  String get delete;

  /// No description provided for @noAlarms.
  ///
  /// In pt, this message translates to:
  /// **'Nenhum alarme configurado.'**
  String get noAlarms;

  /// No description provided for @settingsAlarms.
  ///
  /// In pt, this message translates to:
  /// **'Gerenciar Alarmes'**
  String get settingsAlarms;

  /// No description provided for @tapToDismiss.
  ///
  /// In pt, this message translates to:
  /// **'Toque para dispensar'**
  String get tapToDismiss;

  /// No description provided for @alarm.
  ///
  /// In pt, this message translates to:
  /// **'Alarme'**
  String get alarm;

  /// Mensagem de confirmação quando um alarme é excluído.
  ///
  /// In pt, this message translates to:
  /// **'Alarme \"{alarmName}\" excluído.'**
  String alarmDeleted(String alarmName);

  /// No description provided for @daySundayShort.
  ///
  /// In pt, this message translates to:
  /// **'D'**
  String get daySundayShort;

  /// No description provided for @dayMondayShort.
  ///
  /// In pt, this message translates to:
  /// **'S'**
  String get dayMondayShort;

  /// No description provided for @dayTuesdayShort.
  ///
  /// In pt, this message translates to:
  /// **'T'**
  String get dayTuesdayShort;

  /// No description provided for @dayWednesdayShort.
  ///
  /// In pt, this message translates to:
  /// **'Q'**
  String get dayWednesdayShort;

  /// No description provided for @dayThursdayShort.
  ///
  /// In pt, this message translates to:
  /// **'Q'**
  String get dayThursdayShort;

  /// No description provided for @dayFridayShort.
  ///
  /// In pt, this message translates to:
  /// **'S'**
  String get dayFridayShort;

  /// No description provided for @daySaturdayShort.
  ///
  /// In pt, this message translates to:
  /// **'S'**
  String get daySaturdayShort;

  /// No description provided for @alarmNew.
  ///
  /// In pt, this message translates to:
  /// **'Novo Alarme'**
  String get alarmNew;

  /// No description provided for @alarmEdit.
  ///
  /// In pt, this message translates to:
  /// **'Editar Alarme'**
  String get alarmEdit;

  /// No description provided for @alarmTime.
  ///
  /// In pt, this message translates to:
  /// **'Horário'**
  String get alarmTime;

  /// No description provided for @alarmLabelHint.
  ///
  /// In pt, this message translates to:
  /// **'Etiqueta (opcional)'**
  String get alarmLabelHint;

  /// No description provided for @alarmRepeat.
  ///
  /// In pt, this message translates to:
  /// **'Repetir'**
  String get alarmRepeat;

  /// No description provided for @alarmSound.
  ///
  /// In pt, this message translates to:
  /// **'Som do Alarme'**
  String get alarmSound;

  /// No description provided for @alarmSoundAsset.
  ///
  /// In pt, this message translates to:
  /// **'Som de arquivo'**
  String get alarmSoundAsset;

  /// No description provided for @alarmSoundTts.
  ///
  /// In pt, this message translates to:
  /// **'Texto Falado'**
  String get alarmSoundTts;

  /// No description provided for @alarmTtsHint.
  ///
  /// In pt, this message translates to:
  /// **'Texto para falar'**
  String get alarmTtsHint;

  /// No description provided for @alarmStopCondition.
  ///
  /// In pt, this message translates to:
  /// **'Condição de Parada'**
  String get alarmStopCondition;

  /// No description provided for @alarmStopOnInteraction.
  ///
  /// In pt, this message translates to:
  /// **'Ao tocar na tela'**
  String get alarmStopOnInteraction;

  /// No description provided for @alarmStopAfterReps.
  ///
  /// In pt, this message translates to:
  /// **'Após N repetições'**
  String get alarmStopAfterReps;

  /// No description provided for @alarmRepsHint.
  ///
  /// In pt, this message translates to:
  /// **'Número de repetições'**
  String get alarmRepsHint;

  /// No description provided for @soundSelection.
  ///
  /// In pt, this message translates to:
  /// **'Som'**
  String get soundSelection;

  /// No description provided for @soundBeep.
  ///
  /// In pt, this message translates to:
  /// **'Bip'**
  String get soundBeep;

  /// No description provided for @soundRooster.
  ///
  /// In pt, this message translates to:
  /// **'Galo'**
  String get soundRooster;

  /// No description provided for @selectAll.
  ///
  /// In pt, this message translates to:
  /// **'Selecionar Todos'**
  String get selectAll;

  /// No description provided for @deselectAll.
  ///
  /// In pt, this message translates to:
  /// **'Desmarcar Todos'**
  String get deselectAll;

  /// No description provided for @accentColorLabel.
  ///
  /// In pt, this message translates to:
  /// **'Cor do Ponteiro e Destaque'**
  String get accentColorLabel;

  /// No description provided for @themeClassicBlack.
  ///
  /// In pt, this message translates to:
  /// **'Preto Clássico'**
  String get themeClassicBlack;

  /// No description provided for @themeModernBlue.
  ///
  /// In pt, this message translates to:
  /// **'Azul Moderno'**
  String get themeModernBlue;

  /// No description provided for @themeMinimalWhite.
  ///
  /// In pt, this message translates to:
  /// **'Branco Minimalista'**
  String get themeMinimalWhite;

  /// No description provided for @themeRetroGreen.
  ///
  /// In pt, this message translates to:
  /// **'Verde Retrô'**
  String get themeRetroGreen;

  /// No description provided for @themeGoldLuxury.
  ///
  /// In pt, this message translates to:
  /// **'Luxo Dourado'**
  String get themeGoldLuxury;

  /// No description provided for @themeSpaceGray.
  ///
  /// In pt, this message translates to:
  /// **'Cinza Espacial'**
  String get themeSpaceGray;

  /// No description provided for @themeRoseGold.
  ///
  /// In pt, this message translates to:
  /// **'Ouro Rosé'**
  String get themeRoseGold;

  /// No description provided for @themeNightBlue.
  ///
  /// In pt, this message translates to:
  /// **'Azul da Noite'**
  String get themeNightBlue;

  /// No description provided for @themeIvoryElegance.
  ///
  /// In pt, this message translates to:
  /// **'Elegância Marfim'**
  String get themeIvoryElegance;

  /// No description provided for @themeDigitalNeon.
  ///
  /// In pt, this message translates to:
  /// **'Neon Digital'**
  String get themeDigitalNeon;

  /// No description provided for @themeCopperVintage.
  ///
  /// In pt, this message translates to:
  /// **'Cobre Vintage'**
  String get themeCopperVintage;

  /// No description provided for @proThemeMessage.
  ///
  /// In pt, this message translates to:
  /// **'Tema exclusivo do plano PRO!'**
  String get proThemeMessage;

  /// No description provided for @upgradeToProTitle.
  ///
  /// In pt, this message translates to:
  /// **'Atualizar para PRO'**
  String get upgradeToProTitle;

  /// No description provided for @upgradeToProDesc.
  ///
  /// In pt, this message translates to:
  /// **'Desbloqueie recursos exclusivos e remova os anúncios!'**
  String get upgradeToProDesc;

  /// No description provided for @noAds.
  ///
  /// In pt, this message translates to:
  /// **'Sem Anúncios'**
  String get noAds;

  /// No description provided for @exclusiveThemes.
  ///
  /// In pt, this message translates to:
  /// **'Temas Exclusivos'**
  String get exclusiveThemes;

  /// No description provided for @supportDeveloper.
  ///
  /// In pt, this message translates to:
  /// **'Apoie o Desenvolvedor'**
  String get supportDeveloper;

  /// No description provided for @buyFor.
  ///
  /// In pt, this message translates to:
  /// **'Comprar por'**
  String get buyFor;

  /// No description provided for @buyProVersion.
  ///
  /// In pt, this message translates to:
  /// **'Comprar Versão PRO'**
  String get buyProVersion;

  /// No description provided for @processing.
  ///
  /// In pt, this message translates to:
  /// **'Processando...'**
  String get processing;

  /// No description provided for @unavailable.
  ///
  /// In pt, this message translates to:
  /// **'Indisponível'**
  String get unavailable;

  /// No description provided for @restorePurchases.
  ///
  /// In pt, this message translates to:
  /// **'Restaurar Compras'**
  String get restorePurchases;

  /// No description provided for @loading.
  ///
  /// In pt, this message translates to:
  /// **'Carregando...'**
  String get loading;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'de',
        'en',
        'es',
        'fr',
        'it',
        'pt'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
