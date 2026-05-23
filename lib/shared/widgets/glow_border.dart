import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:orbitalis/core/theme/app_colors.dart';

class GlowBorder extends StatelessWidget {
  const GlowBorder({
    required this.child,
    super.key,
    this.color = AppColors.cyan,
    this.borderRadius = 16,
    this.animate = true,
  });


  final Widget child;
  final Color color;
  final double borderRadius;
  final bool animate;

  @override
  Widget build(BuildContext context) {
    final Widget bordered = DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: color.withAlpha(120)),
        boxShadow: [
          BoxShadow(
            color: color.withAlpha(50),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: child,
    );

    if (!animate) return bordered;

    return bordered
        .animate(onPlay: (c) => c.repeat(reverse: true))
        .custom(
          duration: 1800.ms,
          builder: (context, value, child) => DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              boxShadow: [
                BoxShadow(
                  color: color.withAlpha((30 + value * 40).toInt()),
                  blurRadius: 4 + value * 12,
                  spreadRadius: value,
                ),
              ],
            ),
            child: child,
          ),
        );
  }
}
