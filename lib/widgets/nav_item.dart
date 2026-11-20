import 'package:flutter/material.dart';
import 'package:portfolio/theme/app_theme.dart';
import 'package:portfolio/widgets/custom_cursor.dart';

class NavItem extends StatelessWidget {
  const NavItem({
    super.key,
    required this.title,
    required this.selected,
    required this.onTap,
    this.style,
  });

  final String title;
  final bool selected;
  final VoidCallback onTap;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Clickable(
      onTap: onTap,
      semanticLabel: title,
      builder: (context, hovered) {
        final active = selected || hovered;
        final base = style ?? AppText.nav(selected: selected);
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: base.copyWith(color: active ? AppColors.ink : null),
              child: Text(title),
            ),
            const SizedBox(height: 6),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              height: 2,
              width: selected ? 18 : (hovered ? 8 : 0),
              decoration: BoxDecoration(
                color: AppColors.ink,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        );
      },
    );
  }
}
