import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:orbitalis/core/theme/app_colors.dart';
import 'package:orbitalis/core/theme/app_text_styles.dart';

class OrbitalisAppBar extends StatelessWidget implements PreferredSizeWidget {
  const OrbitalisAppBar({
    required this.title,
    super.key,
    this.actions,
    this.leading,
    this.bottom,
  });

  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final PreferredSizeWidget? bottom;

  @override
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight + (bottom?.preferredSize.height ?? 0),
      );

  @override
  Widget build(BuildContext context) {
    // On web (Chrome) there is no system status bar.  Using the raw
    // MediaQuery value can return sub-pixel rounding artefacts (e.g. 1 px)
    // that reduce the available content height and cause overflow.
    final topPad = kIsWeb ? 0.0 : MediaQuery.paddingOf(context).top;
    final barContent = Container(
      padding: EdgeInsets.only(top: topPad),
      decoration: BoxDecoration(
        color: kIsWeb
            ? AppColors.surface.withAlpha(242)
            : const Color(0xB3050A18),
        border: const Border(
          bottom: BorderSide(color: AppColors.border),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: kToolbarHeight,
            child: Row(
              children: [
                if (leading != null)
                  leading!
                else
                  const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: AppTextStyles.headlineMedium.copyWith(
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                if (actions != null) ...actions!,
                const SizedBox(width: 8),
              ],
            ),
          ),
          if (bottom != null) bottom!,
        ],
      ),
    );

    if (kIsWeb) return barContent;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: barContent,
      ),
    );
  }
}
