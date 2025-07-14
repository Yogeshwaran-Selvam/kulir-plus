import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/core/core.dart';

abstract class AppIcons {
  // ==================== Bottom Navigation Bar ====================
  static Widget home(BuildContext context, bool isActive) => Icon(
    CupertinoIcons.home,
    color: Provider.of<ThemeProvider>(context).isDark
        ? (isActive ? Colors.black : Colors.white)
        : Colors.white,
  );
  static Widget schedules(BuildContext context, bool isActive) => Icon(
    CupertinoIcons.calendar_today,
    color: Provider.of<ThemeProvider>(context).isDark
        ? (isActive ? Colors.black : Colors.white)
        : Colors.white,
  );
  static Widget menu(BuildContext context, bool isActive) => Icon(
    CupertinoIcons.square_grid_2x2,
    color: Provider.of<ThemeProvider>(context).isDark
        ? (isActive ? Colors.black : Colors.white)
        : Colors.white,
  );

  // ==================== Welcome Bar ====================
  static Widget avatar(BuildContext context, [double size = 30]) => Icon(
    CupertinoIcons.person_fill,
    color: Theme.of(context).colorScheme.onSurface,
    size: size,
  );

  static Widget themeBtn(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return Icon(
      themeProvider.isDark ? CupertinoIcons.moon_fill : Icons.light_mode,
      color: Theme.of(context).colorScheme.onSurface,
      size: 30,
    );
  }

  static Widget gradientIcon(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return Icon(
      themeProvider.isGalaxy ? CupertinoIcons.star_fill : Icons.flash_on,
      size: 12,
      color: Theme.of(context).colorScheme.onSurface,
    );
  }

  //  Weather Bar
  static Widget locationIcon(BuildContext context) {
    return Icon(CupertinoIcons.location, size: 10, color: Colors.white);
  }

  // ==================== All Rooms ====================
  static Widget addAcIcon(BuildContext context) {
    return Icon(CupertinoIcons.add, color: Colors.white);
  }

  // ==================== Ac Tile ====================
  static Widget onlineIcon(BuildContext context, bool isConnected) {
    return Icon(
      (isConnected) ? CupertinoIcons.wifi : CupertinoIcons.wifi_slash,
      color: Theme.of(context).colorScheme.onSurface,
      size: 20,
    );
  }

  static Widget powerIcon(BuildContext context, bool isOn) {
    return Icon(
      Icons.power_settings_new,
      color: (isOn) ? Colors.green : Colors.red,
      size: 18,
    );
  }

  // ==================== Ac Tile ====================
  static Widget backIcon(BuildContext context) {
    return Icon(
      Icons.arrow_back_ios_new,
      size: 24,
      color: Theme.of(context).colorScheme.onSurface,
    );
  }

  static Widget deleteIcon(BuildContext context, [Color? color]) {
    return Icon(
      CupertinoIcons.delete_solid,
      size: 24,
      color: color ?? Theme.of(context).colorScheme.onSurface,
    );
  }

  static Widget bigPowerIcon(BuildContext context) {
    return Icon(
      Icons.power_settings_new,
      size: 35,
    );
  }

  static Widget timerIcon(BuildContext context, bool isOn) {
    final colorScheme = Theme.of(context).colorScheme;
    return Icon(
      Icons.timer,
      size: 25,
      color: isOn ? Colors.white : colorScheme.onSurface,
    );
  }

  static Widget fanIcon(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Icon(Icons.wind_power, size: 25, color: colorScheme.onSurface);
  }

  static Widget swingIcons(BuildContext context, bool isOn) {
    final colorScheme = Theme.of(context).colorScheme;
    return Icon(
      Icons.swipe,
      size: 25,
      color: isOn ? Colors.white : colorScheme.onSurface,
    );
  }

  static IconData getModeIcon(String mode) {
    switch (mode.toLowerCase()) {
      case 'cool':
        return Icons.ac_unit;
      case 'eco':
        return Icons.eco_rounded;
      case 'turbo':
        return Icons.bolt_rounded;
      case 'sleep':
        return Icons.nightlight_round;
      case 'low':
        return Icons.fast_rewind;
      case 'medium':
        return Icons.slow_motion_video;
      case 'high':
        return Icons.fast_forward;
      case 'auto':
        return Icons.auto_awesome_rounded;
      case 'heat':
        return Icons.thermostat_auto_rounded;
      case 'dry':
        return Icons.water_drop_rounded;
      case 'fan':
        return Icons.air_rounded;
      default:
        return Icons.settings_rounded;
    }
  }
}
