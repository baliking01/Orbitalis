import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color background = Color(0xFF040912);
  static const Color surface = Color(0xFF0C1528);
  static const Color surfaceVariant = Color(0xFF121F38);
  static const Color border = Color(0xFF1E3454);

  static const Color cyan = Color(0xFF00D4FF);
  static const Color electricBlue = Color(0xFF4499FF);
  static const Color glowCyan = Color(0x4000D4FF);
  static const Color glowBlue = Color(0x404499FF);

  static const Color orange = Color(0xFFFF8C42);
  static const Color green = Color(0xFF00E676);
  static const Color red = Color(0xFFFF4444);

  // High-contrast text: each level is clearly distinguishable on dark backgrounds
  static const Color textPrimary = Color(0xFFF0F4FF);   // near-white, slightly cool
  static const Color textSecondary = Color(0xFFB8C8E0); // clearly visible mid-tone
  static const Color textMuted = Color(0xFF6E8CAD);     // visible but subdued
}
