import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/app/app.dart';
import '/core/core.dart';
import 'widgets.dart';

class CoreControls extends StatefulWidget {
  final ACModel ac;

  const CoreControls({super.key, required this.ac});

  @override
  State<StatefulWidget> createState() => _CoreControlsState();
}

class _CoreControlsState extends State<CoreControls> {
  String selectedMode = AppStrings.cool;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 590,
      width: 350,
      decoration: AppCards.forACContainers(context),
      child: Stack(
        children: [
          Center(child: _buildTitle(context)),
          _buildModes(context),
          Positioned(
            top: 100,
            right: -40,
              child: TemperatureSlider(
                id: widget.ac.id,
                onChange: (newValue) {
                  context.read<ACProvider>().setTemperature(
                    widget.ac.id,
                    newValue.toInt(),
                  );
                },
              ),
          ),
          Align(alignment: Alignment.bottomCenter, child: UseButtons()),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.fromLTRB(15, 20, 35, 25),
        child: Text(
          AppStrings.coreSettings,
          style: AppTexts.titleLarge(context, font: AppFont.aDLaMDisplay),
        ),
      ),
    );
  }

  Widget _buildModes(BuildContext context) {
    return Positioned(
      top: 75,
      left: 10,
      child: Padding(
        padding: EdgeInsets.fromLTRB(15, 30, 0, 0),
        child: Column(
          children: [
            _buildModesStyle(
              context,
              selectedMode == AppStrings.cool,
              AppStrings.cool,
            ),
            SizedBox(height: 15),
            _buildModesStyle(
              context,
              selectedMode == AppStrings.eco,
              AppStrings.eco,
            ),
            SizedBox(height: 15),
            _buildModesStyle(
              context,
              selectedMode == AppStrings.turbo,
              AppStrings.turbo,
            ),
            SizedBox(height: 15),
            _buildModesStyle(
              context,
              selectedMode == AppStrings.sleep,
              AppStrings.sleep,
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  Widget _buildModesStyle(BuildContext context, bool isSelected, String mode) {
    final theme = Theme.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => setState(() => selectedMode = mode),
      child: Container(
        width: 100,
        height: 40,
        decoration: AppCards.forCoreModes(context, isSelected),
        child: Row(
          children: [
            SizedBox(width: 2.5),
            CircleAvatar(
              backgroundColor: theme.brightness == Brightness.dark || isSelected
                  ? Colors.black87
                  : Colors.white70,
              radius: 18,
              child: Icon(
                AppIcons.getModeIcon(mode),
                color: isSelected ? colorScheme.primary : colorScheme.onSurface,
              ),
            ),
            SizedBox(width: 5),
            Text(mode, style: AppTexts.labelLarge(context, color: isSelected ? Colors.white : null)),
          ],
        ),
      ),
    );
  }
}
