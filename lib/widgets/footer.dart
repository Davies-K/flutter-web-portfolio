import 'package:flutter/material.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/theme/app_theme.dart';
import 'package:portfolio/utils/responsive.dart';
import 'package:portfolio/widgets/email_widget.dart';
import 'package:portfolio/widgets/social_icons_bar.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final mobile = Responsive.isMobile(context);
    final credit = Text(
      '© ${DateTime.now().year} ${PortfolioData.name} · Built with Flutter in ${PortfolioData.location}',
      textAlign: mobile ? TextAlign.center : TextAlign.start,
      style: AppText.body(size: 12, color: AppColors.muted),
    );
    return Column(
      children: [
        const Divider(color: AppColors.border, height: 1),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 28),
          child: mobile
              ? Column(
                  children: [
                    const SocialIconsRow(),
                    const SizedBox(height: 12),
                    const EmailWidget(),
                    const SizedBox(height: 16),
                    credit,
                  ],
                )
              : Row(
                  children: [
                    const SocialIconsRow(),
                    const SizedBox(width: 24),
                    Expanded(child: credit),
                    const EmailWidget(),
                  ],
                ),
        ),
      ],
    );
  }
}
