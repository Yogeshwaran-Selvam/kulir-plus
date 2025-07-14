import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'constants.dart';

abstract class AppSvgs {
  static Widget getSvg(
    String asset, {
    double? width,
    double? height,
    ColorFilter? colorFilter,
    Color? color,
    BoxFit fit = BoxFit.contain,
  }) {
    try {
      return SvgPicture.asset(
        asset,
        width: width,
        height: height,
        colorFilter:
            colorFilter ??
            (color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null),
        fit: fit,
        placeholderBuilder: (context) =>
            Container(width: width, height: height, color: Colors.grey[200]),
        allowDrawingOutsideViewBox: true,
      );
    } catch (e) {
      debugPrint('Error loading SVG $asset: $e');
      return _buildErrorPlaceholder(width, height);
    }
  }

  static Widget getSvgForAcTile(BuildContext context, String name) {
    final colorScheme = Theme.of(context).colorScheme;

    return getSvg(
      getSvgAsset(name),
      width: 30,
      height: 30,
      color: colorScheme.onSurface,
    );
  }

  static String getSvgAsset(String name) {
    switch (name) {
      case 'Bedroom':
        return AppStrings.bedroomAsset;
      case 'Living Room':
        return AppStrings.livingroomAsset;
      case 'Hallway':
        return AppStrings.hallwayAsset;
      case 'Office':
        return AppStrings.officeAsset;
      default:
        return AppStrings.kitchenAsset;
    }
  }

  static Widget _buildErrorPlaceholder([double? width, double? height]) {
    return Container(
      width: width,
      height: height,
      color: Colors.grey[300],
      child: Center(
        child: Icon(
          Icons.error_outline,
          size: (width ?? height ?? 24) / 2,
          color: Colors.red,
        ),
      ),
    );
  }
}
