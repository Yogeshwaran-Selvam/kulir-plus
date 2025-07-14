import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/app/app.dart';
import '/core/core.dart';
import 'weather_bar.dart';

class CustomAppBar extends StatelessWidget {
  final Future<void> Function() onChangeGrade;

  const CustomAppBar({super.key, required this.onChangeGrade});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: false,
      floating: true,
      elevation: 10,
      collapsedHeight: 90,
      titleSpacing: 25,
      leading: _avatar(context),
      title: _title(context),
      actions: [_themeBtn(context)],
      bottom: WeatherBar(height: 60),
    );
  }

  Widget _avatar(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 10),
        AppCards.iconsPrimaryBG(
          context: context,
          child: AppIcons.avatar(context),
          width: 45,
          height: 45,
        ),
      ],
    );
  }

  Widget _title(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.userName, style: AppTexts.titleSmall(context)),
        Text(
          AppStrings.welcomeHome,
          style: AppTexts.titleLarge(context, font: AppFont.aDLaMDisplay),
        ),
      ],
    );
  }

  Widget _themeBtn(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return Row(
      children: [
        Stack(
          children: [
            Padding(
              padding: EdgeInsetsGeometry.all(10),
              child: GestureDetector(
                onTap: () async {
                  // await onChangeGrade();
                  // await Future.delayed(const Duration(milliseconds: 2500));
                  // await onChangeGrade();
                  themeProvider.toggleNext();
                },
                child: AppCards.iconsPrimaryBG(
                  context: context,
                  child: AppIcons.themeBtn(context),
                  width: 45,
                  height: 45,
                ),
              ),
            ),
            Positioned(
              right: 4,
              bottom: 4,
              child: AppCards.iconsPrimaryBG(
                context: context,
                child: AppIcons.gradientIcon(context),
                width: 17.5,
                height: 17.5,
              ),
            ),
          ],
        ),
        SizedBox(width: 10),
      ],
    );
  }
}
