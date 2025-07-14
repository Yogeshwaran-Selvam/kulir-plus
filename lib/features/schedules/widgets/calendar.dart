import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '/app/app.dart';

class CalendarWidget extends StatelessWidget {
  final DateTime initialDate;
  final Function(DateTime) onDateSelected;

  const CalendarWidget({
    super.key,
    required this.initialDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final startDate = DateTime(now.year, now.month, 1);
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(4),
      child: SingleChildScrollView(
        child: TableCalendar(
          firstDay: startDate,
          lastDay: initialDate.add(const Duration(days: 365)),
          focusedDay: initialDate,
          selectedDayPredicate: (day) => isSameDay(initialDate, day),
          onDaySelected: (selectedDay, focusedDay) {
            if (selectedDay.isBefore(DateTime(now.year, now.month, now.day))) {
              AppCards.showTopBar(context, 'History is not available');
            } else {
              onDateSelected(selectedDay);
            }
          },
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            titleTextStyle: AppTexts.titleLarge(
              context,
              font: AppFont.aDLaMDisplay,
            ),
            leftChevronIcon: Icon(
              Icons.chevron_left,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            rightChevronIcon: Icon(
              Icons.chevron_right,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: AppTexts.labelMedium(
              context,
              font: AppFont.aDLaMDisplay,
              color: colorScheme.primary,
            ),
            weekendStyle: AppTexts.labelMedium(
              context,
              font: AppFont.aDLaMDisplay,
              color: colorScheme.primary,
            ),
          ),
          calendarStyle: CalendarStyle(
            todayTextStyle: AppTexts.labelLarge(context),
            defaultTextStyle: AppTexts.labelLarge(context),
            weekendTextStyle: AppTexts.labelLarge(
              context,
              color: colorScheme.primary.withAlpha(200),
            ),
            selectedTextStyle: AppTexts.labelLarge(
              context,
              color: colorScheme.onPrimary,
            ),
            todayDecoration: BoxDecoration(
              color: colorScheme.primary.withAlpha(100),
              shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
              color: colorScheme.primary,
              shape: BoxShape.circle,
            ),
            defaultDecoration: const BoxDecoration(shape: BoxShape.circle),
            weekendDecoration: const BoxDecoration(shape: BoxShape.circle),
          ),
        ),
      ),
    );
  }
}
