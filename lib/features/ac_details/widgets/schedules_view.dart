import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/app/app.dart';
import '/core/core.dart';
import '/features/add_schequles/add_schedules.dart';
import 'widgets.dart';

class SchedulesView extends StatelessWidget {
  final int acId;

  const SchedulesView({super.key, required this.acId});

  @override
  Widget build(BuildContext context) {
    final schedules = Provider.of<ScheduleProvider>(
      context,
      listen: false,
    ).getSchedulesForAC(acId);

    return Container(
      width: 350,
      height: 590,
      decoration: AppCards.forACContainers(context),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 20, 0, 20),
              child: Text(
                'Schedules',
                style: AppTexts.titleLarge(context, font: AppFont.aDLaMDisplay),
              ),
            ),
            if (schedules.isEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'No schedules for this AC',
                      style: AppTexts.bodyLarge(context),
                    ),
                  ),
                  SizedBox(height: 30),
                  Center(child: AppLotties.nothingHere()),
                ],
              )
            else
              Container(
                width: 340,
                height: schedules.length * 195,
                color: Colors.transparent,
                child: CarouselView(
                  backgroundColor: Colors.transparent,
                  itemExtent: 190,
                  shrinkExtent: 50,
                  enableSplash: false,
                  scrollDirection: Axis.vertical,
                  children: List.generate(schedules.length, (index) {
                    final schedule = schedules[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: OpenContainer(
                        openColor: Colors.transparent,
                        closedColor: Colors.transparent,
                        transitionDuration: Duration(milliseconds: 500),
                        closedElevation: 0,
                        openElevation: 0,
                        closedBuilder: (context, action) =>
                            ScheduleTile(schedule: schedule, onTap: action),
                        openBuilder: (context, _) =>
                            AddSchedulePage(id: schedule.id),
                      ),
                    );
                  }),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
