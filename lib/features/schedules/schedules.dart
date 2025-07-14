import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/app/app.dart';
import '/core/core.dart';
import 'widgets/widgets.dart';

class SchedulesBody extends StatelessWidget {
  const SchedulesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SelectedItemProvider(DateTime.now()),
      child: _SchedulesPageContent(),
    );
  }
}

class _SchedulesPageContent extends StatefulWidget {
  @override
  State<_SchedulesPageContent> createState() => _SchedulesPageContentState();
}

class _SchedulesPageContentState extends State<_SchedulesPageContent> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(child: SizedBox(height: 25)),
        _appBar(context),
        SliverToBoxAdapter(child: SizedBox(height: 15)),
        _calendarPart(context),
        SliverToBoxAdapter(child: SizedBox(height: 30)),
        _header(context),
        SliverToBoxAdapter(child: SizedBox(height: 15)),
        SchedulesListBuilder(),
      ],
    );
  }

  Widget _appBar(BuildContext context) {
    return Selector<SelectedItemProvider, DateTime>(
      selector: (_, provider) => provider.getSelected,
      builder: (_, current, __) {
        return SliverAppBar(
          pinned: true,
          collapsedHeight: 50,
          toolbarHeight: 50,
          titleSpacing: 10,
          leadingWidth: 50,
          leading: AppLotties.showCalendarLottie(),
          title: _title(context, current),
        );
      },
    );
  }

  Widget _calendarPart(BuildContext context) {
    return Selector<SelectedItemProvider, DateTime>(
      selector: (_, provider) => provider.getSelected,
      builder: (_, current, __) {
        return SliverToBoxAdapter(
          child: DraggablePanel(
            collapsedChild: DateSelector(
              initialDate: current,
              dotIndicatorBuilder: (date) => Provider.of<ScheduleProvider>(
                context,
              ).getDotColorsForDate(date),
            ),
            expandedChild: CalendarWidget(
              initialDate: current,
              onDateSelected: (date) {
                Provider.of<SelectedItemProvider>(
                  context,
                  listen: false,
                ).setSelected(date);
              },
            ),
            collapsedHeight: 150,
            expandedHeight: 410,
            isExpanded: false,
          ),
        );
      },
    );
  }

  Widget _header(BuildContext context) {
    return Selector<SelectedItemProvider, DateTime>(
      selector: (_, provider) => provider.getSelected,
      builder: (_, current, __) {
        return SliverToBoxAdapter(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 20),
              Text(
                AppStrings.schedules,
                style: AppTexts.titleLarge(context, font: AppFont.aDLaMDisplay),
              ),
              SizedBox(width: 5),
              Text(
                '${Provider.of<ScheduleProvider>(context, listen: false).getSchedulesForDay(current).length}',
                style: AppTexts.labelLarge(
                  context,
                  font: AppFont.aDLaMDisplay,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () => AppRouter.push(
                  context,
                  RouteNames.addSchedule,
                  arguments: -1,
                ),
                child: Container(
                  width: 80,
                  height: 30,
                  decoration: AppCards.forCommon1(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        AppStrings.add,
                        style: AppTexts.titleMedium(
                          context,
                        ).copyWith(color: Colors.white),
                      ),
                      AppIcons.addAcIcon(context),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _title(BuildContext context, DateTime currentDate) {
    final formattedDate =
        "${_getMonthName(currentDate.month)}, ${currentDate.day}";
    final weekdayName = _getWeekdayName(currentDate.weekday);
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          formattedDate,
          style: AppTexts.headlineMedium(context, font: AppFont.aDLaMDisplay),
        ),
        const SizedBox(width: 10),
        Column(
          children: [
            SizedBox(height: 10),
            Text(
              weekdayName,
              style: AppTexts.titleMedium(context, color: Colors.grey),
            ),
          ],
        ),
        const SizedBox(width: 5),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: RotatedBox(
              quarterTurns: 1,
              child: AppLotties.forScheduleAppBar(themeProvider.isDark),
            ),
          ),
        ),
      ],
    );
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return '';
    }
  }

  String _getWeekdayName(int weekday) {
    switch (weekday) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return '';
    }
  }
}
