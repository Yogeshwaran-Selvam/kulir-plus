import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/app/app.dart';
import '/core/core.dart';

abstract class AppCards {
  // ==================== For Icons ====================
  static Widget iconsGlassCard({
    required BuildContext context,
    required Widget child,
    required double width,
    required double height,
  }) {
    final isDark = Provider.of<ThemeProvider>(context).isDark;
    final bgColor = isDark
        ? Colors.white.withAlpha(50)
        : Colors.black.withAlpha(25);
    final shadowColor = isDark
        ? Colors.black.withAlpha(25)
        : Colors.white.withAlpha(100);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: bgColor,
        border: Border.all(
          color: Theme.of(context).colorScheme.onSurface,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(color: shadowColor, blurRadius: 10, spreadRadius: 2),
        ],
      ),
      child: child,
    );
  }

  static Widget iconsPrimaryBG({
    required BuildContext context,
    required Widget child,
    required double width,
    required double height,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.primary.withAlpha(200),
        border: Border.all(
          color: Theme.of(context).colorScheme.onSurface,
          width: 1,
        ),
      ),
      child: child,
    );
  }

  // ==================== For Bottom Navigator ====================
  static BoxDecoration forBottomNavigator(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return BoxDecoration(
      color: Colors.blueGrey,
      gradient: RadialGradient(
        radius: 1.8,
        center: Alignment.topCenter,
        colors: themeProvider.gradientData,
      ),
    );
  }

  // ==================== For Weather Bar ====================
  // ==================== For All Rooms ====================
  static BoxDecoration forCommon1(BuildContext context, [double radius = 25]) {
    final colorScheme = Theme.of(context).colorScheme;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return BoxDecoration(
      color: Colors.blueGrey,
      borderRadius: BorderRadius.circular(radius),
      boxShadow: [BoxShadow(color: colorScheme.onSurface)],
      gradient: LinearGradient(
        colors: themeProvider.gradientData,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    );
  }

  static InputDecorationTheme forCommon2(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return InputDecorationTheme(
      filled: true,
      fillColor: Colors.blueGrey,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: BorderSide(color: colorScheme.onSurface),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      hintStyle: TextStyle(color: colorScheme.onSurface.withAlpha(150)),
    );
  }

  // ==================== For Ac Tile ====================
  static BoxDecoration forAcTile(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final color1 = themeProvider.isDark ? Colors.white : Colors.black;
    final color2 = themeProvider.isDark ? Colors.black : Colors.white;

    return BoxDecoration(
      gradient: LinearGradient(
        colors: [color1.withAlpha(38), color1.withAlpha(13)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(24),
      border: Border.all(color: color1.withAlpha(25)),
      boxShadow: [
        BoxShadow(
          color: color2.withAlpha(100),
          blurRadius: 12,
          offset: Offset(4, 4),
        ),
      ],
    );
  }

  // =================== Core Controls ===================
  static BoxDecoration forACContainers(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    if (isDark) {
      // Glass Effect for Black Background
      return BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(30.0),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.05),
            blurRadius: 10,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 5,
            spreadRadius: -2,
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withValues(alpha: 0.05),
            Colors.white.withValues(alpha: 0.1),
          ],
          stops: const [0.1, 0.9],
        ),
      );
    } else {
      // Metallic Shine for White Background
      return BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(30.0),
        border: Border.all(color: Colors.grey[300]!, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.6),
            offset: const Offset(-2, -2),
            blurRadius: 8,
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            offset: const Offset(2, 2),
            blurRadius: 8,
          ),
        ],
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFEFEFEF), Color(0xFFDADADA)],
        ),
      );
    }
  }

  static BoxDecoration forCoreModes(BuildContext context, bool isSelected) {
    final color1 = Colors.white;
    final color2 = Colors.black;

    return isSelected
        ? BoxDecoration(
            gradient: LinearGradient(
              colors: Provider.of<ThemeProvider>(
                context,
                listen: false,
              ).gradientData,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: color1.withAlpha(25)),
            boxShadow: [
              BoxShadow(
                color: color2.withAlpha(100),
                blurRadius: 12,
                offset: Offset(4, 4),
              ),
            ],
          )
        : forAcTile(context);
  }

  // ==================== For Cost Table ====================
  static BoxDecoration forTable(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final color1 = themeProvider.isDark ? Colors.white : Colors.black;
    final color2 = themeProvider.isDark ? Colors.black : Colors.white;

    return BoxDecoration(
      gradient: LinearGradient(
        colors: [color1.withAlpha(20), color1.withAlpha(8)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: color1.withAlpha(30), width: 0.5),
      boxShadow: [
        BoxShadow(
          color: color2.withAlpha(80),
          blurRadius: 8,
          offset: Offset(2, 2),
        ),
      ],
    );
  }

  static Gradient forBarChart(BuildContext context) {
    return LinearGradient(
      colors: Provider.of<ThemeProvider>(context, listen: false).gradientData,
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  // ==================== For Schedule Tile ====================
  static BoxDecoration forScheduleTile(BuildContext context, Color color) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final color2 = themeProvider.isDark ? Colors.black : Colors.white;

    return BoxDecoration(
      gradient: LinearGradient(
        colors: [color.withAlpha(200), color.withAlpha(75)],
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
      ),
      borderRadius: BorderRadius.circular(24),
      border: Border.all(color: color2.withAlpha(100)),
      boxShadow: [
        BoxShadow(
          color: color2.withAlpha(50),
          blurRadius: 12,
          offset: Offset(4, 4),
        ),
      ],
    );
  }

  static BoxDecoration forTableCell(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final color1 = themeProvider.isDark ? Colors.white : Colors.black;

    return BoxDecoration(
      color: color1.withAlpha(10),
      border: Border(
        bottom: BorderSide(color: color1.withAlpha(15), width: 0.5),
        right: BorderSide(color: color1.withAlpha(15), width: 0.5),
      ),
    );
  }

  static BoxDecoration forTableHeader(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final color1 = themeProvider.isDark ? Colors.white : Colors.black;

    return BoxDecoration(
      gradient: LinearGradient(
        colors: [color1.withAlpha(30), color1.withAlpha(15)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      border: Border(bottom: BorderSide(color: color1.withAlpha(25), width: 1)),
    );
  }

  // ==================== For Date Selector ====================
  static BoxDecoration forDateSelector(BuildContext context, bool isSelected) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final color1 = themeProvider.isDark ? Colors.white : Colors.black;

    return BoxDecoration(
      gradient: LinearGradient(
        colors: isSelected
            ? themeProvider.gradientData
            : [color1.withAlpha(30), color1.withAlpha(15)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.all(Radius.circular(12)),
    );
  }

  // ==================== For Snack Bar ====================
  static void showTopBar(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    final entry = OverlayEntry(
      builder: (_) => Positioned(
        top: MediaQuery.of(context).padding.top + 16,
        left: 16,
        right: 16,
        child: Material(
          borderRadius: BorderRadius.circular(14),
          color: Theme.of(context).colorScheme.onSurface.withAlpha(200),
          elevation: 6,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Theme.of(context).colorScheme.primary.withAlpha(200),
                width: 2,
              ),
            ),
            child: Text(
              message,
              style: AppTexts.labelLarge(
                context,
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(entry);
    Future.delayed(const Duration(seconds: 3), () => entry.remove());
  }
}
