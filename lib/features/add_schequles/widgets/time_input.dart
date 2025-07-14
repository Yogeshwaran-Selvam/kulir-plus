import 'package:flutter/material.dart';
import '/app/app.dart';

class TimeInput extends StatelessWidget {
  final String label;
  final TimeOfDay time;
  final VoidCallback onTap;
  final Color color;

  const TimeInput({
    super.key,
    required this.label,
    required this.time,
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
          suffixIcon: Icon(Icons.access_time, size: 20, color: color),
        ),
        child: Text(time.format(context), style: AppTexts.bodyLarge(context)),
      ),
    );
  }
}
