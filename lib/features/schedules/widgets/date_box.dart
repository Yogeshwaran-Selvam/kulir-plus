import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/app/app.dart';
import '/core/core.dart';

class DateBox extends StatelessWidget {
  final DateTime time;
  final List<Color> dots;

  const DateBox({super.key, required this.time, this.dots = const <Color>[]});

  @override
  Widget build(BuildContext context) {
    final selPro = Provider.of<SelectedItemProvider>(context);
    final isSelected = selPro.getSelected == time;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final color1 = themeProvider.isDark ? Colors.white : Colors.black;

    final day = _getShortWeekday(time.weekday);

    return Material(
      type: MaterialType.transparency,
      borderOnForeground: false,
      child: Container(
        width: 70,
        height: 100,
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        decoration: AppCards.forDateSelector(context, isSelected),
        child: InkWell(
          onTap: () => selPro.setSelected(time),
          borderRadius: BorderRadius.all(Radius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '${time.day}',
                  style: AppTexts.titleLarge(
                    context,
                    font: AppFont.aDLaMDisplay,
                    color: isSelected ? Colors.white : color1,
                  ),
                ),
                Text(
                  day,
                  style: AppTexts.titleSmall(
                    context,
                    font: AppFont.aDLaMDisplay,
                    color: isSelected ? Colors.white : color1,
                  ),
                ),
                Container(
                  height: 16,
                  alignment: Alignment.center,
                  child: Wrap(
                    spacing: 2,
                    runSpacing: 2,
                    alignment: WrapAlignment.center,
                    children: dots
                        .map(
                          (dotColor) => Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.white.withAlpha(225)
                                  : dotColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getShortWeekday(int weekday) {
    const days = ['', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[weekday];
  }
}
