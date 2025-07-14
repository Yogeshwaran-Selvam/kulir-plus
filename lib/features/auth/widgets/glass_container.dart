import 'dart:ui';
import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {
  final double width;
  final double height;
  final Widget? child;

  final Color color = Colors.black12;
  final double blur = 10;
  final double borderWidth = 1.5;
  final Color borderColor = Colors.white;

  const GlassContainer({
    super.key,
    required this.width,
    required this.height,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: borderColor.withValues(alpha: 0.8),
            width: borderWidth,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.15),
              blurRadius: blur,
              spreadRadius: 1.0,
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: blur * 0.5,
              spreadRadius: -2.0,
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
        ),
        child: Stack(
          children: [
            // Frosted glass effect
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: blur * 0.6,
                sigmaY: blur * 0.6,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            // Inner highlight for more "glass" feel
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: IgnorePointer(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: Colors.white,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ),
            // Child content
            if (child != null) child!,
          ],
        ),
      ),
    );
  }
}