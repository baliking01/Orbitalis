import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class StaggeredList extends StatelessWidget {
  const StaggeredList({
    required this.children,
    super.key,
    this.staggerMs = 80,
    this.initialDelayMs = 0,
  });

  final List<Widget> children;
  final int staggerMs;
  final int initialDelayMs;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < children.length; i++)
          children[i]
              .animate(
                delay: Duration(
                  milliseconds: initialDelayMs + i * staggerMs,
                ),
              )
              .fadeIn(duration: 350.ms)
              .slideY(
                begin: 0.15,
                end: 0,
                duration: 350.ms,
                curve: Curves.easeOut,
              ),
      ],
    );
  }
}
