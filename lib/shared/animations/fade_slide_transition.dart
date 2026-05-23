import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class FadeSlideIn extends StatelessWidget {
  const FadeSlideIn({
    required this.child,
    super.key,
    this.delay = Duration.zero,
    this.offsetY = 24,
  });

  final Widget child;
  final Duration delay;
  final double offsetY;

  @override
  Widget build(BuildContext context) {
    // On web, skip stagger delays and reduce animation duration to avoid jank
    if (kIsWeb) {
      return child
          .animate()
          .fadeIn(duration: 200.ms, curve: Curves.easeOut);
    }
    return child
        .animate(delay: delay)
        .fadeIn(duration: 400.ms, curve: Curves.easeOut)
        .slideY(
          begin: offsetY / 100,
          end: 0,
          duration: 400.ms,
          curve: Curves.easeOut,
        );
  }
}
