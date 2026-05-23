import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:orbitalis/core/theme/app_colors.dart';

class GlassContainer extends StatelessWidget {
  const GlassContainer({
    required this.child,
    super.key,
    this.borderRadius = 16,
    this.blurSigma = 12,
    this.padding,
    this.glowColor,
    this.border = true,
  });

  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final bool border;
  final double blurSigma;
  final Color? glowColor;

  @override
  Widget build(BuildContext context) {
    final content = padding != null
        ? Padding(padding: padding!, child: child)
        : child;

    final decoration = BoxDecoration(
      color: kIsWeb
          ? AppColors.surface.withAlpha(230)
          : AppColors.surface.withAlpha(200),
      borderRadius: BorderRadius.circular(borderRadius),
      border: border
          ? Border.all(color: AppColors.border)
          : null,
      boxShadow: glowColor != null
          ? [
              BoxShadow(
                color: glowColor!.withAlpha(50),
                blurRadius: 12,
                spreadRadius: 1,
              ),
            ]
          : null,
    );

    // Skip expensive BackdropFilter on web — it causes major jank
    if (kIsWeb) {
      return DecoratedBox(
        decoration: decoration,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: content,
        ),
      );
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: glowColor != null
            ? [
                BoxShadow(
                  color: glowColor!.withAlpha(60),
                  blurRadius: 16,
                  spreadRadius: 1,
                ),
              ]
            : null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
          child: DecoratedBox(
            decoration: decoration,
            child: content,
          ),
        ),
      ),
    );
  }
}
