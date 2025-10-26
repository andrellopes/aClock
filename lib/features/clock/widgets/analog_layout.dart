import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:a_clock/core/themes/theme_manager.dart';

import 'calendar_view.dart';

enum AnalogNumeralType { arabic, roman }

class AnalogClockLayout extends StatelessWidget {
  final Stream<DateTime> timeStream;
  final double fontSize;
  final bool showDate;
  final bool showFrame;
  final AnalogNumeralType numeralType;

  const AnalogClockLayout({
    super.key,
    required this.timeStream,
    required this.fontSize,
    required this.showDate,
    this.showFrame = true,
    this.numeralType = AnalogNumeralType.arabic,
  });

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context, listen: true);
    final theme = themeManager.currentTheme;
    
    return StreamBuilder<DateTime>(
      stream: timeStream,
      builder: (context, snapshot) {
        final dateTime = snapshot.data ?? DateTime.now();

        final clockWidget = Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: AspectRatio(
              aspectRatio: 1,
              child: CustomPaint(
                painter: _AnalogClockPainter(
                  time: dateTime,
                  fontColor: theme.fontColor,
                  accentColor: theme.accentColor,
                  showFrame: showFrame,
                  numeralType: numeralType,
                  numeralSizeRatio: 0.1 + (fontSize / 1000),
                ),
              ),
            ),
          ),
        );

        final dateWidget = showDate
            ? CalendarView(
                currentDate: dateTime,
                accentColor: theme.accentColor,
                fontColor: theme.fontColor,
                baseFontSize: fontSize,
              ) : null;

        Widget layout;
        if (MediaQuery.of(context).orientation == Orientation.landscape) {
          layout = Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(flex: dateWidget != null ? 3 : 1, child: clockWidget),
              if (dateWidget != null)
                Flexible(
                  flex: 2,
                  child: Padding(
                    // 1. Added horizontal padding to prevent date cutoff
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: dateWidget,
                  ),
                ),
            ],
          );
        } else {
          // For portrait screens, we use a SingleChildScrollView to prevent the layout
          // from breaking on screens with less vertical height.
          layout = Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  clockWidget,
                  if (dateWidget != null)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: dateWidget,
                    ),
                ],
              ),
            ),
          );
        }

        // 2. Added overall padding to prevent overlap with other UI elements
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: layout,
        );
      },
    );
  }
}

class _AnalogClockPainter extends CustomPainter {
  final DateTime time;
  final Color fontColor;
  final Color accentColor;
  final bool showFrame;
  final AnalogNumeralType numeralType;
  final double numeralSizeRatio;

  _AnalogClockPainter({
    required this.time,
    required this.fontColor,
    required this.accentColor,
    required this.showFrame,
    required this.numeralType,
    required this.numeralSizeRatio,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2) * 0.9;

    // Draw outer frame with gradient and shadow
    if (showFrame) {
      // Shadow for depth
      final shadowPaint = Paint()
        ..color = Colors.black.withValues(alpha: 76.5)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
      canvas.drawCircle(center + const Offset(3, 3), radius + 2, shadowPaint);

      // Single elegant outer ring
      final outerPaint = Paint()
        ..color = fontColor.withValues(alpha: 178.5)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4;
      canvas.drawCircle(center, radius, outerPaint);

      // Hour markers - elegant lines with more spacing from numbers
      for (int i = 0; i < 12; i++) {
        final angle = (i * 30 - 90) * (pi / 180);
        final startRadius = radius * 0.90; // Closer to the rim
        final endRadius = radius * 0.97;   // Very close to the edge
        
        final startPos = center + Offset(cos(angle) * startRadius, sin(angle) * startRadius);
        final endPos = center + Offset(cos(angle) * endRadius, sin(angle) * endRadius);
        
        final hourMarkerPaint = Paint()
          ..color = fontColor.withValues(alpha: 204)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3
          ..strokeCap = StrokeCap.round;
        
        canvas.drawLine(startPos, endPos, hourMarkerPaint);
      }

      // Minute markers - more subtle and closer to the rim
      for (int i = 0; i < 60; i++) {
        if (i % 5 != 0) { // Skip hour positions
          final angle = (i * 6 - 90) * (pi / 180);
          final startRadius = radius * 0.92; // Close to the rim
          final endRadius = radius * 0.97;   // Very close to the edge
          
          final startPos = center + Offset(cos(angle) * startRadius, sin(angle) * startRadius);
          final endPos = center + Offset(cos(angle) * endRadius, sin(angle) * endRadius);
          
          final minuteMarkerPaint = Paint()
            ..color = fontColor.withValues(alpha: 76.5)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1
            ..strokeCap = StrokeCap.round;
          
          canvas.drawLine(startPos, endPos, minuteMarkerPaint);
        }
      }
    }

    // Draw numerals (Arabic or Roman)
    _paintNumerals(canvas, center, radius);

    // Hour hand - elegant tapered design
    final hourAngle = (time.hour % 12 * 30 + time.minute * 0.5 - 90) * (pi / 180);
    _drawTaperedHand(canvas, center, hourAngle, radius * 0.5, radius * 0.06, fontColor);

    // Minute hand - longer and thinner
    final minuteAngle = (time.minute * 6 - 90) * (pi / 180);
    _drawTaperedHand(canvas, center, minuteAngle, radius * 0.7, radius * 0.04, fontColor);

    // Second hand - thin and elegant
    final secondAngle = (time.second * 6 - 90) * (pi / 180);
    _drawSecondHand(canvas, center, secondAngle, radius * 0.8, accentColor);

    // Center hub with gradient
    _drawCenterHub(canvas, center, radius * 0.08, fontColor);
  }

  @override
  bool shouldRepaint(covariant _AnalogClockPainter oldDelegate) {
    return oldDelegate.time != time ||
        oldDelegate.fontColor != fontColor ||
        oldDelegate.accentColor != accentColor ||
        oldDelegate.showFrame != showFrame ||
        oldDelegate.numeralType != numeralType ||
        oldDelegate.numeralSizeRatio != numeralSizeRatio;
  }

  String _intToRoman(int number) {
    const List<String> romans = [
      'I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X', 'XI', 'XII'
    ];
    return romans[number - 1];
  }

  void _paintNumerals(Canvas canvas, Offset center, double radius) {
    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: ui.TextDirection.ltr,
    );

    final textStyle = TextStyle(
      color: fontColor,
      fontSize: radius * numeralSizeRatio,
      fontWeight: FontWeight.w600,
      shadows: [
        Shadow(
          color: Colors.black.withValues(alpha: 76.5),
          offset: const Offset(1, 1),
          blurRadius: 2,
        ),
      ],
    );

    for (int i = 1; i <= 12; i++) {
      final angle = (i * 30 - 90) * (pi / 180);
      String text;

      switch (numeralType) {
        case AnalogNumeralType.arabic:
          text = i.toString();
          break;
        case AnalogNumeralType.roman:
          text = _intToRoman(i);
          break;
      }

      textPainter.text = TextSpan(text: text, style: textStyle);
      textPainter.layout();

      final textRadius = radius * 0.75; // Closer to the center, away from the marks
      final position = Offset(
        center.dx + textRadius * cos(angle) - textPainter.width / 2,
        center.dy + textRadius * sin(angle) - textPainter.height / 2,
      );

      textPainter.paint(canvas, position);
    }
  }

  // Draws hands with elegant tapered shape
  void _drawTaperedHand(Canvas canvas, Offset center, double angle, double length, double width, Color color) {
    final endPoint = center + Offset(cos(angle), sin(angle)) * length;
    final perpAngle = angle + pi / 2;
    
    // Hand shadow
    final shadowPath = Path();
    shadowPath.moveTo(center.dx + 2, center.dy + 2);
    shadowPath.lineTo(endPoint.dx + 2, endPoint.dy + 2);
    shadowPath.lineTo(endPoint.dx + cos(perpAngle) * (width * 0.3) + 2, endPoint.dy + sin(perpAngle) * (width * 0.3) + 2);
    shadowPath.lineTo(center.dx + cos(perpAngle) * width + 2, center.dy + sin(perpAngle) * width + 2);
    shadowPath.lineTo(center.dx + cos(perpAngle + pi) * width + 2, center.dy + sin(perpAngle + pi) * width + 2);
    shadowPath.lineTo(endPoint.dx + cos(perpAngle + pi) * (width * 0.3) + 2, endPoint.dy + sin(perpAngle + pi) * (width * 0.3) + 2);
    shadowPath.close();
    
    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 76.5)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
    canvas.drawPath(shadowPath, shadowPaint);
    
    // Main hand
    final handPath = Path();
    handPath.moveTo(center.dx, center.dy);
    handPath.lineTo(endPoint.dx, endPoint.dy);
    handPath.lineTo(endPoint.dx + cos(perpAngle) * (width * 0.3), endPoint.dy + sin(perpAngle) * (width * 0.3));
    handPath.lineTo(center.dx + cos(perpAngle) * width, center.dy + sin(perpAngle) * width);
    handPath.lineTo(center.dx + cos(perpAngle + pi) * width, center.dy + sin(perpAngle + pi) * width);
    handPath.lineTo(endPoint.dx + cos(perpAngle + pi) * (width * 0.3), endPoint.dy + sin(perpAngle + pi) * (width * 0.3));
    handPath.close();
    
    final gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        color,
        color.withValues(alpha: 178.5),
      ],
    );
    
    final handPaint = Paint()
      ..shader = gradient.createShader(handPath.getBounds())
      ..style = PaintingStyle.fill;
    canvas.drawPath(handPath, handPaint);
    
    // Hand border
    final borderPaint = Paint()
      ..color = color.withValues(alpha: 204)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawPath(handPath, borderPaint);
  }

  // Draws thinner and more elegant second hand
  void _drawSecondHand(Canvas canvas, Offset center, double angle, double length, Color color) {
    final endPoint = center + Offset(cos(angle), sin(angle)) * length;
    final backPoint = center + Offset(cos(angle + pi), sin(angle + pi)) * (length * 0.15);
    
    // Shadow
    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 76.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);
    canvas.drawLine(backPoint + const Offset(1, 1), endPoint + const Offset(1, 1), shadowPaint);
    
    // Main hand
    final handPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(backPoint, endPoint, handPaint);
    
    // Circle in the middle of the second hand
    final circlePaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center + Offset(cos(angle), sin(angle)) * (length * 0.7), length * 0.015, circlePaint);
  }

  // Draws the clock center with gradient and details
  void _drawCenterHub(Canvas canvas, Offset center, double radius, Color color) {
    // Center shadow
    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 102)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    canvas.drawCircle(center + const Offset(2, 2), radius + 1, shadowPaint);
    
    // Outer circle with gradient
    final outerGradient = RadialGradient(
      colors: [
        color,
        color.withValues(alpha: 153),
      ],
    );
    final outerPaint = Paint()
      ..shader = outerGradient.createShader(Rect.fromCircle(center: center, radius: radius));
    canvas.drawCircle(center, radius, outerPaint);
    
    // Smaller inner circle with shine
    final innerGradient = RadialGradient(
      colors: [
        color.withValues(alpha: 229.5),
        color.withValues(alpha: 76.5),
      ],
    );
    final innerPaint = Paint()
      ..shader = innerGradient.createShader(Rect.fromCircle(center: center, radius: radius * 0.6));
    canvas.drawCircle(center, radius * 0.6, innerPaint);
    
    // Small central point
    final centerPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius * 0.25, centerPaint);
  }
}
