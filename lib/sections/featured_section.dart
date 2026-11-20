import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/theme/app_theme.dart';
import 'package:portfolio/utils/responsive.dart';
import 'package:portfolio/utils/url_utils.dart';
import 'package:portfolio/widgets/drawn_circle.dart';
import 'package:portfolio/widgets/reveal.dart';
import 'package:portfolio/widgets/rounded_button.dart';

/// The headline project: write-up on one side, phone screenshot on the other.
class FeaturedSection extends StatelessWidget {
  const FeaturedSection({super.key});

  @override
  Widget build(BuildContext context) {
    final mobile = Responsive.isMobile(context);
    final project = PortfolioData.featured;

    final writeUp = Reveal(
      child: Column(
        crossAxisAlignment:
            mobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'FEATURED WORK',
            style: AppText.body(
              size: 12,
              weight: FontWeight.w700,
              color: AppColors.muted,
            ).copyWith(letterSpacing: 2),
          ),
          const SizedBox(height: 12),
          Text(
            project.title,
            style:
                GoogleFonts.raleway(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(LucideIcons.star, size: 16, color: Color(0xFFE0A100)),
              const SizedBox(width: 6),
              Text(project.stat,
                  style: AppText.body(size: 14, weight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            project.description,
            textAlign: mobile ? TextAlign.center : TextAlign.left,
            style: AppText.body(size: 16, height: 1.7),
          ),
          const SizedBox(height: 32),
          RoundedButton(
            label: 'View on GitHub',
            width: 200,
            onTap: () => openUrl(project.url),
          ),
        ],
      ),
    );

    final phoneHeight = mobile ? 460.0 : 580.0;
    final phone = SizedBox(
      height: phoneHeight + 40,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          FloatingCircle(
            size: phoneHeight * 1.05,
            drift: const Offset(12, -10),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: phoneHeight * 0.62,
              height: phoneHeight * 0.62,
              decoration: const BoxDecoration(
                color: Color(0xFFE9FAFB),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Reveal(
            offset: 80,
            duration: const Duration(milliseconds: 1100),
            delay: const Duration(milliseconds: 200),
            child: Image.asset(project.image, height: phoneHeight),
          ),
        ],
      ),
    );

    return ContentBox(
      child: mobile
          ? Column(children: [writeUp, const SizedBox(height: 48), phone])
          : Row(
              children: [
                Expanded(child: writeUp),
                const SizedBox(width: 40),
                Expanded(child: phone),
              ],
            ),
    );
  }
}
