import 'package:flutter/material.dart';
import 'widgets.dart';

class DateSelector extends StatefulWidget {
  final DateTime initialDate;
  final List<Color> Function(DateTime)? dotIndicatorBuilder;

  const DateSelector({
    super.key,
    required this.initialDate,
    this.dotIndicatorBuilder,
  });

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  late DateTime _selectedDate;
  late List<DateTime> _weekDates;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _weekDates = _generateWeekDates(_selectedDate);
  }

  List<DateTime> _generateWeekDates(DateTime startDate) {
    final dates = <DateTime>[];
    
    for (int i = 0; i < 4; i++) {
      dates.add(startDate.add(Duration(days: i)));
    }
    return dates;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(4, (index) {
            final date = _weekDates[index];
            return DateBox(
              time: date,
              dots: widget.dotIndicatorBuilder?.call(date) ?? [],
            );
          }),
        ),
      ],
    );
  }
}