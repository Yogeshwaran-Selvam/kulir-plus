import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:kulir_plus/features/ac_details/ac_details.dart';
import '/app/app.dart';
import '/core/core.dart';

class AcTile extends StatefulWidget {
  final int id;
  final ACModel ac;

  const AcTile({super.key, required this.id, required this.ac});

  @override
  State<StatefulWidget> createState() => _AcTileState();
}

class _AcTileState extends State<AcTile> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      type: MaterialType.transparency,
      child: Stack(
        fit: StackFit.expand,
        children: [_buildIconAndName(context), _buildOnlineIndicator(context)],
      ),
    );
  }

  Widget _buildIconAndName(BuildContext context) {
    return OpenContainer(
      openColor: Colors.transparent,
      closedColor: Colors.transparent,
      useRootNavigator: true,
      transitionDuration: Duration(milliseconds: 500),
      openElevation: 0,
      closedElevation: 0,
      closedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      openBuilder: (context, _) => AcDetails(ac: widget.ac),
      closedBuilder: (context, openContainer) => InkWell(
        onTap: openContainer,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          width: 150,
          height: 150,
          margin: EdgeInsets.all(10),
          decoration: AppCards.forAcTile(context),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppCards.iconsPrimaryBG(
                  context: context,
                  child: Center(
                    child: AppSvgs.getSvgForAcTile(context, widget.ac.nickname),
                  ),
                  width: 50,
                  height: 50,
                ),
                SizedBox(height: 5),
                Text(widget.ac.nickname, style: AppTexts.titleMedium(context)),
                SizedBox(height: 2),
                _buildTemperatureIndicator(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOnlineIndicator(BuildContext context) {
    return Positioned(
      top: 20,
      right: 30,
      child: Center(child: AppIcons.onlineIcon(context, widget.ac.isOnline)),
    );
  }

  Widget _buildTemperatureIndicator(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppIcons.powerIcon(context, widget.ac.isPowerOn),
        Text('  |  ', style: AppTexts.bodySmall(context)),
        Text(
          '${widget.ac.temperature}${AppStrings.degree}',
          style: AppTexts.bodySmall(context, font: AppFont.aDLaMDisplay),
        ),
        Column(
          children: [
            SizedBox(height: 2.5),
            Text(
              AppStrings.celsius,
              style: AppTexts.bodySmall(context).copyWith(fontSize: 8),
            ),
          ],
        ),
      ],
    );
  }
}
