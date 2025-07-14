import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '/app/app.dart';

abstract class AppLotties {
  // ==================== For All Rooms ====================
  // ==================== For Monthly Usage ====================
  static Widget showMoreLottie() {
    return Lottie.asset(AppStrings.showMoreAsset, width: 80, height: 70);
  }

  static Widget showCalendarLottie() {
    return Lottie.asset(
      AppStrings.calendarAsset,
      width: 50,
      height: 50,
      fit: BoxFit.cover,
    );
  }

  static Widget forScheduleAppBar(bool isDark) {
    String asset = isDark
        ? AppStrings.scheduleAppBarDarkAsset
        : AppStrings.scheduleAppBarLightAsset;

    return Lottie.asset(asset, fit: BoxFit.fill);
  }

  static Widget forACDetails() {
    return Lottie.asset(
      AppStrings.gradientBg,
      width: 400,
      height: 200,
      fit: BoxFit.fill,
    );
  }

  static Widget forACRoom(String room) {
    String asset = '';

    switch (room) {
      case 'Kitchen':
        asset = AppStrings.kitchen;
        break;
      case 'Bedroom':
        asset = AppStrings.bedroom;
        break;
      case 'Office':
        asset = AppStrings.office;
        break;
      default:
        asset = AppStrings.livingroom;
        break;
    }

    return Lottie.asset(asset, width: 400, height: 260, fit: BoxFit.fill);
  }

  static Widget nothingHere() {
    return Lottie.asset(
      AppStrings.nothingHere,
      fit: BoxFit.cover,
      width: 300,
      height: 300,
    );
  }

  static Widget profileLottie(BuildContext context) {
    return Lottie.asset(
      Theme.of(context).brightness == Brightness.dark ? AppStrings.profileDark : AppStrings.profileLight,
      width: 250,
      height: 250,
      fit: BoxFit.cover,
    );
  }

  static Widget loginLottie(BuildContext context) {
    return Lottie.asset(
      AppStrings.login,
      width: 250,
      height: 250,
      fit: BoxFit.cover,
    );
  }

  static Widget loadingLottie(bool isDark, AnimationController controller) {
    return Lottie.asset(
      isDark ? AppStrings.loadingDark : AppStrings.loadingLight,
      controller: controller,
      width: 150,
      height: 150,
    );
  }
}
