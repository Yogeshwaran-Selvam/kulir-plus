import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum AppFont { poppins, aDLaMDisplay }

class AppTexts {
  static TextStyle _getStyle(
    BuildContext context, {
    required double fontSize,
    required FontWeight fontWeight,
    required double letterSpacing,
    Color? color,
    double? alpha,
    AppFont font = AppFont.poppins, // Default to Poppins
  }) {
    final baseColor = color ?? Theme.of(context).colorScheme.onSurface;
    final textColor = alpha != null
        ? baseColor.withAlpha(alpha.round())
        : baseColor;

    switch (font) {
      case AppFont.poppins:
        return GoogleFonts.poppins(
          fontSize: fontSize,
          fontWeight: fontWeight,
          letterSpacing: letterSpacing,
          color: textColor,
        );
      case AppFont.aDLaMDisplay:
        return GoogleFonts.aDLaMDisplay(
          fontSize: fontSize,
          fontWeight: fontWeight,
          letterSpacing: letterSpacing,
          color: textColor,
        );
    }
  }

  // Display styles (large, prominent text)
  static TextStyle displayLarge(
    BuildContext context, {
    AppFont font = AppFont.poppins,
    Color? color,
  }) {
    return _getStyle(
      context,
      fontSize: 57,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.25,
      font: font,
      color: color,
    );
  }

  static TextStyle displayMedium(
    BuildContext context, {
    AppFont font = AppFont.poppins,
    Color? color,
  }) {
    return _getStyle(
      context,
      fontSize: 45,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      font: font,
      color: color,
    );
  }

  static TextStyle displaySmall(
    BuildContext context, {
    AppFont font = AppFont.poppins,
    Color? color,
  }) {
    return _getStyle(
      context,
      fontSize: 36,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      font: font,
      color: color,
    );
  }

  // Headline styles (titles and headers)
  static TextStyle headlineLarge(
    BuildContext context, {
    AppFont font = AppFont.poppins,
    Color? color,
  }) {
    return _getStyle(
      context,
      fontSize: 32,
      fontWeight: FontWeight.w700,
      letterSpacing: 0,
      font: font,
      color: color,
    );
  }

  static TextStyle headlineMedium(
    BuildContext context, {
    AppFont font = AppFont.poppins,
    Color? color,
  }) {
    return _getStyle(
      context,
      fontSize: 28,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      font: font,
      color: color,
    );
  }

  static TextStyle headlineSmall(
    BuildContext context, {
    AppFont font = AppFont.poppins,
    Color? color,
  }) {
    return _getStyle(
      context,
      fontSize: 24,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      font: font,
      color: color,
    );
  }

  // Title styles (section titles, subtitles)
  static TextStyle titleLarge(
    BuildContext context, {
    AppFont font = AppFont.poppins,
    Color? color,
  }) {
    return _getStyle(
      context,
      fontSize: 22,
      fontWeight: FontWeight.w500,
      letterSpacing: 0,
      font: font,
      color: color,
    );
  }

  static TextStyle titleMedium(
    BuildContext context, {
    AppFont font = AppFont.poppins,
    Color? color,
  }) {
    return _getStyle(
      context,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      font: font,
      color: color,
    );
  }

  static TextStyle titleSmall(
    BuildContext context, {
    AppFont font = AppFont.poppins,
    Color? color,
  }) {
    return _getStyle(
      context,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      font: font,
      color: color,
    );
  }

  // Body styles (main content)
  static TextStyle bodyLarge(
    BuildContext context, {
    AppFont font = AppFont.poppins,
    Color? color,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    return _getStyle(
      context,
      fontSize: 16,
      fontWeight: fontWeight,
      letterSpacing: 0.5,
      font: font,
      color: color,
    );
  }

  static TextStyle bodyMedium(
    BuildContext context, {
    AppFont font = AppFont.poppins,
    Color? color,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    return _getStyle(
      context,
      fontSize: 14,
      fontWeight: fontWeight,
      letterSpacing: 0.25,
      font: font,
      color: color,
    );
  }

  static TextStyle bodySmall(
    BuildContext context, {
    AppFont font = AppFont.poppins,
    Color? color,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    return _getStyle(
      context,
      fontSize: 12,
      fontWeight: fontWeight,
      letterSpacing: 0.4,
      font: font,
      color: color,
    );
  }

  // Label styles (buttons, navigation)
  static TextStyle labelLarge(
    BuildContext context, {
    AppFont font = AppFont.poppins,
    Color? color,
  }) {
    return _getStyle(
      context,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      font: font,
      color: color,
    );
  }

  static TextStyle labelMedium(
    BuildContext context, {
    AppFont font = AppFont.poppins,
    Color? color,
  }) {
    return _getStyle(
      context,
      fontSize: 12,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      font: font,
      color: color,
    );
  }

  static TextStyle labelSmall(
    BuildContext context, {
    AppFont font = AppFont.poppins,
    Color? color,
  }) {
    return _getStyle(
      context,
      fontSize: 10,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      font: font,
      color: color,
    );
  }

  // Caption and overline (small text, hints)
  static TextStyle caption(
    BuildContext context, {
    AppFont font = AppFont.poppins,
    Color? color,
  }) {
    return _getStyle(
      context,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      alpha: 160,
      font: font,
      color: color,
    );
  }

  static TextStyle overline(
    BuildContext context, {
    AppFont font = AppFont.poppins,
    Color? color,
  }) {
    return _getStyle(
      context,
      fontSize: 10,
      fontWeight: FontWeight.w400,
      letterSpacing: 1.5,
      alpha: 160,
      font: font,
      color: color,
    );
  }

  // Bottom Navigation Bar
  static TextStyle forBotNavi(BuildContext context) {
    return GoogleFonts.aDLaMDisplay(
      fontSize: 12,
      color: Theme.of(context).colorScheme.inversePrimary,
    );
  }
}
