import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/app/app.dart';
import '/core/core.dart';

class ScheduleTile extends StatefulWidget {
  final ScheduleModel schedule;
  final VoidCallback? onTap;

  const ScheduleTile({super.key, required this.schedule, required this.onTap});

  @override
  State<ScheduleTile> createState() => _ScheduleTileState();
}

class _ScheduleTileState extends State<ScheduleTile> {
  String _getScheduleTimeText() {
    final start = widget.schedule.startTime;
    final end = widget.schedule.endTime;
    return '${start.hour}:${start.minute.toString().padLeft(2, '0')} - '
        '${end.hour}:${end.minute.toString().padLeft(2, '0')}';
  }

  String _getScheduleDateText() {
    if (widget.schedule.isRecurring) {
      final days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
      return widget.schedule.weekdays.map((day) => days[day % 7]).join(', ');
    } else {
      final format = DateFormat('MMM dd');
      return '${format.format(widget.schedule.dates[0])} - '
          '${format.format(widget.schedule.dates[1])}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 280,
      height: 180,
      margin: const EdgeInsets.all(5.0),
      padding: const EdgeInsets.all(10.0),
      decoration: AppCards.forScheduleTile(context, widget.schedule.color),
      child: InkWell(
        onTap: widget.onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 10,
              alignment: Alignment.center,
              child: Container(
                width: 4,
                height: 125,
                decoration: BoxDecoration(
                  color: widget.schedule.color,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            SizedBox(width: 10,),
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.schedule_rounded,
                        color: colorScheme.primary,
                        size: 30,
                      ),
                      const SizedBox(width: 15),
                      Flexible(
                        fit: FlexFit.loose,
                        child: Text(
                          widget.schedule.title,
                          style: AppTexts.titleLarge(
                            context,
                            font: AppFont.aDLaMDisplay,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _InfoRow(
                    icon: widget.schedule.isRecurring
                        ? Icons.repeat_rounded
                        : Icons.calendar_today_rounded,
                    text: _getScheduleDateText(),
                    color: colorScheme.primary,
                  ),
                  const SizedBox(height: 8),
                  _InfoRow(
                    icon: Icons.access_time_rounded,
                    text: _getScheduleTimeText(),
                    color: colorScheme.primary,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _ScheduleInfoChip(
                        icon: Icons.ac_unit_rounded,
                        label: widget.schedule.mode,
                        color: colorScheme.primary,
                      ),
                      _ScheduleInfoChip(
                        icon: Icons.thermostat_rounded,
                        label: '${widget.schedule.temperature}${AppStrings.degree}${AppStrings.celsius}',
                        color: colorScheme.primary,
                      ),
                      _ScheduleInfoChip(
                        icon: Icons.air_rounded,
                        label: widget.schedule.fanSpeed,
                        color: colorScheme.primary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;

  const _InfoRow({required this.icon, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 8),
        Text(text, style: AppTexts.bodyMedium(context)),
      ],
    );
  }
}

class _ScheduleInfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _ScheduleInfoChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withAlpha(40),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withAlpha(100), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: AppTexts.bodySmall(context),
          ),
        ],
      ),
    );
  }
}
