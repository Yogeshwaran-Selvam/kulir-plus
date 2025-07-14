import 'package:flutter/material.dart';
import '/app/app.dart';

class UseButtons extends StatefulWidget {
  const UseButtons({super.key});

  @override
  State<UseButtons> createState() => _UseButtonsState();
}

class _UseButtonsState extends State<UseButtons> {
  bool isOn = true;
  int val = 0;
  bool isSwing = false;

  @override
  Widget build(BuildContext context) {
    return _buildButtons(context);
  }

  Widget _buildButtons(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () => setState(() => isOn = !isOn),
            child: _buildBtn(
              context,
              isOn,
              AppIcons.timerIcon(context, isOn),
              Text(
                '5 hours',
                style: AppTexts.bodyMedium(
                  context,
                  color: isOn ? Colors.white : null,
                ),
              ),
              Text(
                'Timer',
                style: AppTexts.bodyLarge(
                  context,
                  color: isOn ? Colors.white : null,
                ),
              ),
              false,
            ),
          ),
          _buildBtn(
            context,
            false,
            AppIcons.fanIcon(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () => setState(() => (val > 0) ? val-- : val),
                  icon: Icon(Icons.remove, size: 15),
                  iconSize: 5,
                ),
                Text(val.toString(), style: AppTexts.bodyMedium(context)),
                IconButton(
                  onPressed: () => setState(() => (val < 3) ? val++ : val),
                  icon: Icon(Icons.add, size: 15),
                  iconSize: 5,
                ),
              ],
            ),
            Text('Speed', style: AppTexts.bodyLarge(context)),
            true,
          ),
          GestureDetector(
            onTap: () => setState(() => isSwing = !isSwing),
            child: _buildBtn(
              context,
              isSwing,
              AppIcons.swingIcons(context, isSwing),
              Text(
                isSwing ? 'On' : 'Off',
                style: AppTexts.bodyMedium(
                  context,
                  color: isSwing ? Colors.white : null,
                ),
              ),
              Text(
                'Swing',
                style: AppTexts.bodyLarge(
                  context,
                  color: isSwing ? Colors.white : null,
                ),
              ),
              false,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBtn(
    BuildContext context,
    bool isOn,
    Widget top,
    Widget center,
    Widget bottom,
    bool isNeeded,
  ) {
    return Container(
      width: isNeeded ? 108 : 80,
      height: 110,
      decoration: AppCards.forCoreModes(context, isOn),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [top, center, bottom],
      ),
    );
  }
}
