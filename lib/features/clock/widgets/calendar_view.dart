import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarView extends StatelessWidget {
  final DateTime currentDate;
  final Color accentColor;
  final Color fontColor;
  final double baseFontSize;

  const CalendarView({
    super.key,
    required this.currentDate,
    required this.accentColor,
    required this.fontColor,
    required this.baseFontSize,
  });

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;

    // Calendar logic
    final firstDayOfMonth = DateTime(currentDate.year, currentDate.month, 1);
    final lastDayOfMonth = DateTime(currentDate.year, currentDate.month + 1, 0);
    // In Dart, Monday = 1 and Sunday = 7. We adjust for a grid that starts on Monday.
    final firstWeekdayOffset = firstDayOfMonth.weekday - 1;
    final daysInMonth = lastDayOfMonth.day;

    // Weekday headers based on language
    final List<String> weekDays = List.generate(7, (index) {
      // 01/01/2024 was a Monday, a safe reference point to get the day names.
      return DateFormat.E(locale).format(DateTime(2024, 1, 1 + index));
    });

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Month and year
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            DateFormat.yMMMM(locale).format(currentDate),
            style: TextStyle(
              color: fontColor,
              fontWeight: FontWeight.bold,
              fontSize: baseFontSize * 0.35,
            ),
          ),
        ),

        // Weekday headers
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: weekDays
              .map(
                (day) => Expanded(
                  child: Center(
                    child: Text(
                      day,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: fontColor.withValues(alpha: 178.5),
                        fontSize: baseFontSize * 0.15,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),

        const SizedBox(height: 5),

        // Days grid
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisSpacing: 3,
            crossAxisSpacing: 3,
          ),
          itemCount: daysInMonth + firstWeekdayOffset,
          itemBuilder: (context, index) {
            if (index < firstWeekdayOffset) {
              // Empty cells before the first day of the month
              return const SizedBox.shrink();
            }

            final dayNumber = index - firstWeekdayOffset + 1;
            final isToday = currentDate.day == dayNumber;

            return Container(
              decoration: BoxDecoration(
                color: isToday ? accentColor : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '$dayNumber',
                  style: TextStyle(
                    color: isToday ? Theme.of(context).colorScheme.onPrimary : fontColor,
                    fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                    fontSize: baseFontSize * 0.3,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
