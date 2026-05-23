import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:orbitalis/core/theme/app_colors.dart';

enum StatusDotState { live, upcoming, offline }

class StatusDot extends StatelessWidget {
  const StatusDot({super.key, this.state = StatusDotState.live, this.size = 8});

  final StatusDotState state;
  final double size;

  Color get _color => switch (state) {
        StatusDotState.live => AppColors.green,
        StatusDotState.upcoming => AppColors.orange,
        StatusDotState.offline => AppColors.textMuted,
      };

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size * 2.5,
      height: size * 2.5,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (state == StatusDotState.live)
            Container(
              width: size * 2.5,
              height: size * 2.5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _color.withAlpha(40),
              ),
            )
                .animate(onPlay: (c) => c.repeat())
                .scaleXY(begin: 0.4, end: 1, duration: 1200.ms)
                .fadeOut(begin: 0.6, duration: 1200.ms),
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _color,
              boxShadow: [
                BoxShadow(
                  color: _color.withAlpha(120),
                  blurRadius: 4,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
