import '/app/app.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateInput extends StatelessWidget {
  final String label;
  final DateTime date;
  final VoidCallback onTap;
  final Color color;

  const DateInput({
    super.key,
    required this.label,
    required this.date,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: AppTexts.bodyLarge(context, fontWeight: FontWeight.w500),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: colorScheme.onSurface.withAlpha(100),
              width: 1.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: colorScheme.onSurface.withAlpha(100),
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: colorScheme.onSurface.withAlpha(100),
              width: 1.5,
            ),
          ),
          suffixIcon: Icon(Icons.calendar_today, size: 20, color: color),
        ),
        child: Text(
          DateFormat('MMM dd, yyyy').format(date),
          style: AppTexts.bodyLarge(context),
        ),
      ),
    );
  }
}
