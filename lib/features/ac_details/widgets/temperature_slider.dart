import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import '/app/app.dart';
import '/core/core.dart';

class TemperatureSlider extends StatelessWidget {
  final int id;
  final ValueChanged<double> onChange;

  const TemperatureSlider({super.key, required this.id, required this.onChange});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: SleekCircularSlider(
        initialValue: context.watch<ACProvider>().getById(id).temperature.toDouble(),
        min: 15,
        max: 30,
        appearance: CircularSliderAppearance(
          size: 200,
          customWidths: CustomSliderWidths(
            progressBarWidth: 8,
            handlerSize: 10,
            trackWidth: 8
          ),
          customColors: CustomSliderColors(
            trackColor: colorScheme.onSurface.withAlpha(150),
            progressBarColors: context.read<ThemeProvider>().gradientData + [colorScheme.primary],
            dotColor: colorScheme.onSurface,
          ),
          infoProperties: InfoProperties(
            topLabelText: '30°C\n',
            bottomLabelText: '\n10°C',
            topLabelStyle: AppTexts.bodyLarge(context),
            bottomLabelStyle: AppTexts.bodyLarge(context),
            mainLabelStyle: AppTexts.displaySmall(context),
            modifier: (double value) => '${value.toInt()}°C',
          ),
          startAngle: 80,
          angleRange: 200,
        ),
        onChange: (value) => onChange(value),
      ),
    );
  }
}