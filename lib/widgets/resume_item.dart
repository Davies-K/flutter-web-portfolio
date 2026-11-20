import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/theme/app_theme.dart';
import 'package:portfolio/utils/url_utils.dart';
import 'package:portfolio/widgets/custom_cursor.dart';

class ResumeItem extends StatelessWidget {
  const ResumeItem({super.key, required this.entry});

  final ResumeEntry entry;

  @override
  Widget build(BuildContext context) {
    final url = entry.url;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Clickable(
          onTap: url == null ? null : () => openUrl(url),
          semanticLabel: entry.title,
          builder: (context, hovered) => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(entry.title,
                    style: AppText.heading(25).copyWith(
                      fontWeight: FontWeight.w500,
                    )),
              ),
              const SizedBox(width: 20),
              AnimatedSlide(
                offset: hovered ? const Offset(0.2, -0.2) : Offset.zero,
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOut,
                child: const Icon(LucideIcons.arrowUpRight,
                    color: AppColors.ink, size: 22),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Text(entry.subtitle,
            style: AppText.body(size: 14, weight: FontWeight.w700)),
        const SizedBox(height: 6),
        Text(entry.period,
            style: AppText.body(
                size: 14, weight: FontWeight.w700, color: AppColors.muted)),
      ],
    );
  }
}
