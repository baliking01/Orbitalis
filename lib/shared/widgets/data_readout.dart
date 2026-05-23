import 'package:flutter/material.dart';
import 'package:orbitalis/core/theme/app_text_styles.dart';

class DataReadout extends StatelessWidget {
  const DataReadout({
    required this.label,
    required this.value,
    super.key,
    this.unit,
    this.valueStyle,
  });

  final String label;
  final String value;
  final String? unit;
  final TextStyle? valueStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label.toUpperCase(), style: AppTextStyles.labelSmall),
        const SizedBox(height: 2),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              value,
              style: valueStyle ?? AppTextStyles.monoMedium,
            ),
            if (unit != null) ...[
              const SizedBox(width: 3),
              Padding(
                padding: const EdgeInsets.only(bottom: 1),
                child: Text(unit!, style: AppTextStyles.monoSmall),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
