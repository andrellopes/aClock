import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flip_board/flip_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:a_clock/core/themes/theme_manager.dart';
import 'package:a_clock/core/themes/theme_preset.dart';

class FlipClockLayout extends StatefulWidget {
  final Stream<DateTime> timeStream;
  final double fontSize;
  final bool showSecondsInPortrait;
  final bool showDate;
  final bool use24HourFormat;

  const FlipClockLayout({
    super.key,
    required this.timeStream,
    required this.fontSize,
    required this.showSecondsInPortrait,
    required this.showDate,
    required this.use24HourFormat,
  });

  @override
  State<FlipClockLayout> createState() => _FlipClockLayoutState();
}

class _FlipClockLayoutState extends State<FlipClockLayout> {
  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context, listen: true);
    final theme = themeManager.currentTheme;
    
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: StreamBuilder<DateTime>(
        stream: widget.timeStream,
        initialData: DateTime.now(),
        builder: (context, snapshot) {
          final now = snapshot.data ?? DateTime.now();
          final hourStream = widget.timeStream.map((t) {
            if (widget.use24HourFormat) return t.hour;
            final h = t.hour % 12;
            return h == 0 ? 12 : h;
          });
          final initialHour = widget.use24HourFormat
              ? now.hour
              : (now.hour % 12 == 0 ? 12 : now.hour % 12);

          return OrientationBuilder(
            builder: (context, orientation) {
              return orientation == Orientation.portrait
                  ? _buildPortraitLayout(now, hourStream, initialHour, theme)
                  : _buildLandscapeLayout(now, hourStream, initialHour, theme);
            },
          );
        },
      ),
    );
  }

  Widget _buildPortraitLayout(DateTime now, Stream<int> hourStream, int initialHour, AppThemePreset theme) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    final dateStr = widget.showDate ? DateFormat.yMMMMEEEEd(locale).format(now) : null;

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          _buildFlipWidget('hour', hourStream, initialHour, theme: theme),
          const SizedBox(height: 16),
          _buildFlipWidget('minute', widget.timeStream.map((t) => t.minute), now.minute, theme: theme),
          if (widget.showSecondsInPortrait) ...[
            const SizedBox(height: 16),
            _buildFlipWidget('second', widget.timeStream.map((t) => t.second), now.second, theme: theme),
          ],
          if (!widget.use24HourFormat) ...[
            const SizedBox(height: 20),
            _buildAmPmIndicator(now, theme),
          ],
          
          if (dateStr != null) ...[
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: theme.surface.withValues(alpha: 25.5),
                borderRadius: BorderRadius.circular(12),
                // border removed
              ),
              child: Text(
                dateStr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: theme.fontColor.withValues(alpha: 229.5),
                  fontSize: widget.fontSize * 0.28,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildLandscapeLayout(DateTime now, Stream<int> hourStream, int initialHour, AppThemePreset theme) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    final dateStr = widget.showDate ? DateFormat.yMMMMEEEEd(locale).format(now) : null;

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildFlipWidget('hour', hourStream, initialHour, theme: theme),
              const SizedBox(width: 12),
              _buildSeparator(theme),
              const SizedBox(width: 12),
              _buildFlipWidget('minute', widget.timeStream.map((t) => t.minute), now.minute, theme: theme),
              const SizedBox(width: 12),
              _buildSeparator(theme),
              const SizedBox(width: 12),
              _buildFlipWidget('second', widget.timeStream.map((t) => t.second), now.second, theme: theme),
              if (!widget.use24HourFormat) ...[
                const SizedBox(width: 20),
                _buildAmPmIndicator(now, theme),
              ],
            ],
          ),
          if (dateStr != null) ...[
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: theme.surface.withValues(alpha: 25.5),
                borderRadius: BorderRadius.circular(12),
                // border removed
              ),
              child: Text(
                dateStr,
                style: TextStyle(
                  color: theme.fontColor.withValues(alpha: 229.5),
                  fontSize: widget.fontSize * 0.28,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildFlipWidget(String id, Stream<int> stream, int initialValue, {String? header, required AppThemePreset theme}) {
    final cardHeight = widget.fontSize * 1.9;
    final cardWidth = widget.fontSize * 1.6;

    final baseColor = theme.flipCardColor;
    final hsl = HSLColor.fromColor(baseColor);

    // Gradients for depth
    final topColor = hsl.withLightness((hsl.lightness + 0.12).clamp(0.0, 1.0)).toColor();
    final midTopColor = hsl.withLightness((hsl.lightness + 0.06).clamp(0.0, 1.0)).toColor();
    final midBottomColor = hsl.withLightness((hsl.lightness - 0.06).clamp(0.0, 1.0)).toColor();
    final bottomColor = hsl.withLightness((hsl.lightness - 0.12).clamp(0.0, 1.0)).toColor();

    final visualKey = ValueKey('$id-${theme.fontColor.toARGB32()}-${theme.flipCardColor.toARGB32()}-${header != null}');

    return FlipWidget(
      key: visualKey,
      flipType: FlipType.middleFlip,
      initialValue: initialValue,
      itemStream: stream,
      itemBuilder: (context, value) {
        return Container(
          width: cardWidth,
          height: cardHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 30.6),
                offset: const Offset(0, 8),
                blurRadius: 24,
                spreadRadius: -4,
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 15.3),
                offset: const Offset(0, 2),
                blurRadius: 8,
                spreadRadius: 0,
              ),
            ],
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                topColor.withValues(alpha: 242.25),
                midTopColor.withValues(alpha: 249.9),
                baseColor,
                midBottomColor.withValues(alpha: 249.9),
                bottomColor.withValues(alpha: 242.25),
              ],
              stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
            ),
            // Border with glassmorphism effect
            border: Border.all(
              color: Colors.white.withValues(alpha: 30.6),
              width: 0.8,
            ),
          ),
            child: Stack(
              children: [
                // Subtle shine on top
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: cardHeight * 0.15,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white.withValues(alpha: 51.0),
                          Colors.white.withValues(alpha: 5.1),
                        ],
                      ),
                    ),
                  ),
                ),
                
                if (header != null)
                  Positioned(
                    top: 12,
                    left: 0,
                    right: 0,
                    child: Text(
                      header,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: theme.fontColor.withValues(alpha: 178.5),
                        fontSize: widget.fontSize * 0.2,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                
                // Main number with shadow
                Center(
                  child: Text(
                    value.toString().padLeft(2, '0'),
                    style: TextStyle(
                      color: theme.fontColor,
                      fontSize: widget.fontSize * 0.92,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.2,
                      shadows: [
                        Shadow(
                          color: Colors.black.withValues(alpha: 63.75),
                          offset: const Offset(0, 3),
                          blurRadius: 6,
                        ),
                        Shadow(
                          color: Colors.white.withValues(alpha: 20.4),
                          offset: const Offset(0, -1),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                  ),
                ),
                
                Positioned(
                  top: cardHeight / 2 - 1,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 25.5),
                          Colors.black.withValues(alpha: 63.75),
                          Colors.black.withValues(alpha: 89.25),
                          Colors.black.withValues(alpha: 63.75),
                          Colors.black.withValues(alpha: 25.5),
                        ],
                        stops: const [0.0, 0.2, 0.5, 0.8, 1.0],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: cardHeight / 2 - 3,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 0.5,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.white.withValues(alpha: 76.5),
                          Colors.white.withValues(alpha: 51.0),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: cardHeight / 2 + 1,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 0.5,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 38.25),
                          Colors.black.withValues(alpha: 25.5),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                
                // Reflection at the bottom
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: cardHeight * 0.1,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withValues(alpha: 25.5),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        flipDirection: AxisDirection.down,
      );
  }

  Widget _buildSeparator(AppThemePreset theme) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: widget.fontSize * 0.15),
      child: AnimatedBuilder(
        animation: ModalRoute.of(context)?.animation ?? kAlwaysCompleteAnimation,
        builder: (context, child) {
          return StreamBuilder<DateTime>(
            stream: widget.timeStream,
            builder: (context, snapshot) {
              final shouldPulse = (snapshot.data?.second ?? 0) % 2 == 0;
              
              return AnimatedOpacity(
                opacity: shouldPulse ? 1.0 : 0.4,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: widget.fontSize * 0.12,
                      height: widget.fontSize * 0.12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: theme.accentColor,
                        boxShadow: [
                          BoxShadow(
                            color: theme.accentColor.withValues(alpha: 102.0),
                            blurRadius: 4,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: widget.fontSize * 0.15),
                    Container(
                      width: widget.fontSize * 0.12,
                      height: widget.fontSize * 0.12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: theme.accentColor,
                        boxShadow: [
                          BoxShadow(
                            color: theme.accentColor.withValues(alpha: 102.0),
                            blurRadius: 4,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildAmPmIndicator(DateTime now, AppThemePreset theme) {
    final amPm = now.hour < 12 ? 'AM' : 'PM';
    
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: widget.fontSize * 0.25,
        vertical: widget.fontSize * 0.15,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.fontSize * 0.2),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.accentColor.withValues(alpha: 229.5),
            theme.accentColor.withValues(alpha: 178.5),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: theme.accentColor.withValues(alpha: 76.5),
            offset: const Offset(0, 2),
            blurRadius: 6,
            spreadRadius: 0,
          ),
        ],
        border: Border.all(
          color: theme.accentColor.withValues(alpha: 76.5),
          width: 0.5,
        ),
      ),
      child: Text(
        amPm,
        style: TextStyle(
          fontSize: widget.fontSize * 0.35,
          color: Colors.white,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.2,
          shadows: [
            Shadow(
              color: Colors.black.withValues(alpha: 76.5),
              offset: const Offset(0, 1),
              blurRadius: 2,
            ),
          ],
        ),
      ),
    );
  }
}
