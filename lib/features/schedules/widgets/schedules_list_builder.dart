import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '/app/app.dart';
import '/core/core.dart';
import '/features/add_schequles/add_schedules.dart';
import 'widgets.dart';

class SchedulesListBuilder extends StatefulWidget {
  final DateTime? specificDate;
  final bool showRecurring;
  final bool showOneTime;

  const SchedulesListBuilder({
    super.key,
    this.specificDate,
    this.showRecurring = true,
    this.showOneTime = true,
  });

  @override
  State<SchedulesListBuilder> createState() => _SchedulesListBuilderState();
}

class _SchedulesListBuilderState extends State<SchedulesListBuilder> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ScheduleProvider>(
      builder: (context, provider, child) {
        DateTime filterDate =
            widget.specificDate ??
            Provider.of<SelectedItemProvider>(
              context,
              listen: true,
            ).getSelected;

        final schedules = provider
            .getSchedulesForDay(filterDate)
            .where(
              (s) =>
                  (s.isRecurring && widget.showRecurring) ||
                  (!s.isRecurring && widget.showOneTime),
            )
            .toList();

        if (schedules.isEmpty) {
          return SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    'No schedules for ${DateFormat('MMM dd, yyyy').format(filterDate)}',
                    style: AppTexts.bodyLarge(context),
                  ),
                ),
                SizedBox(height: 30),
                AppLotties.nothingHere(),
                SizedBox(height: 100),
              ],
            ),
          );
        }

        return SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 75),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final schedule = schedules[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: OpenContainer(
                  openColor: Colors.transparent,
                  closedColor: Colors.transparent,
                  transitionDuration: Duration(milliseconds: 500),
                  closedElevation: 10,
                  openElevation: 0,
                  closedBuilder: (context, action) =>
                      ScheduleTile(schedule: schedule, onTap: action),
                  openBuilder: (context, _) => AddSchedulePage(id: schedule.id),
                ),
              );
            }, childCount: schedules.length),
          ),
        );
      },
    );
  }
}
