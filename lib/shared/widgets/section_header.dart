import 'package:flutter/material.dart';
import 'package:orbitalis/core/theme/app_colors.dart';
import 'package:orbitalis/core/theme/app_text_styles.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    required this.title,
    super.key,
    this.action,
  });

  final String title;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 3,
          height: 14,
          decoration: BoxDecoration(
            color: AppColors.cyan,
            borderRadius: BorderRadius.circular(2),
            boxShadow: const [
              BoxShadow(
                color: AppColors.glowCyan,
                blurRadius: 6,
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text(title.toUpperCase(), style: AppTextStyles.titleSmall),
        const Spacer(),
        if (action != null) action!,
      ],
    );
  }
}
