import 'package:flutter/material.dart';
import 'package:orbitalis/core/theme/app_colors.dart';

abstract final class AppTextStyles {
  static const String _mono = 'monospace';

  static const TextStyle displayLarge = TextStyle(
    fontSize: 28,
    color: AppColors.electricBlue,
    letterSpacing: 2,
    fontWeight: FontWeight.w300,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontSize: 18,
    color: AppColors.textPrimary,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle titleSmall = TextStyle(
    fontSize: 11,
    color: AppColors.textSecondary,
    letterSpacing: 1.8,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    color: AppColors.textSecondary,
    height: 1.4,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 10,
    color: AppColors.textSecondary,
    letterSpacing: 1.2,
  );

  static const TextStyle monoLarge = TextStyle(
    fontSize: 22,
    fontFamily: _mono,
    color: AppColors.cyan,
    fontWeight: FontWeight.w500,
    letterSpacing: 1,
  );

  static const TextStyle monoMedium = TextStyle(
    fontSize: 14,
    fontFamily: _mono,
    color: AppColors.textSecondary,
    letterSpacing: 0.5,
  );

  static const TextStyle monoSmall = TextStyle(
    fontSize: 11,
    fontFamily: _mono,
    color: AppColors.textMuted,
    letterSpacing: 0.5,
  );
}
