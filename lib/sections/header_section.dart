import 'package:flutter/material.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/showcase/code_panel.dart';
import 'package:portfolio/theme/app_theme.dart';
import 'package:portfolio/utils/responsive.dart';
import 'package:portfolio/utils/url_utils.dart';
import 'package:portfolio/widgets/profile_avatar.dart';
import 'package:portfolio/widgets/reveal.dart';
import 'package:portfolio/widgets/rounded_button.dart';
import 'package:portfolio/widgets/social_icons_bar.dart';
import 'package:portfolio/widgets/tech_stack_card.dart';
import 'package:portfolio/widgets/underlined_text.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final fontSize =
        Responsive.value<double>(context, mobile: 34, tablet: 44, desktop: 50);
    final mobile = Responsive.isMobile(context);
    final headlineStyle = AppText.display(fontSize);
    final rest = PortfolioData.headline
        .substring(PortfolioData.headlineUnderlined.length);

    Duration step(int i) => Duration(milliseconds: 120 * i);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: mobile ? 20 : 40),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Reveal(
            child: ProfileAvatar(
              image: 'assets/images/8.png',
              size: mobile ? 120 : 150,
            ),
          ),
          const SizedBox(height: 24),
          Reveal(
            delay: step(1),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: fontSize * 10.8),
              child: Text.rich(
                TextSpan(
                  children: [
                    WidgetSpan(
                      alignment: PlaceholderAlignment.baseline,
                      baseline: TextBaseline.alphabetic,
                      child: UnderlinedText(
                        PortfolioData.headlineUnderlined,
                        style: headlineStyle,
                        color: AppColors.aqua,
                      ),
                    ),
                    TextSpan(text: rest),
                  ],
                ),
                textAlign: TextAlign.center,
                style: headlineStyle,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Reveal(
            delay: step(2),
            child: Text(
              mobile
                  ? PortfolioData.intro.replaceAll('\n', ' ')
                  : PortfolioData.intro,
              textAlign: TextAlign.center,
              style: AppText.body(size: 14, height: 1.6),
            ),
          ),
          const SizedBox(height: 24),
          Reveal(
            delay: step(3),
            child: SocialIconsBar(width: mobile ? 170 : 200),
          ),
          const SizedBox(height: 20),
          Reveal(
            delay: step(4),
            child: RoundedButton(
              label: 'Connect with Me',
              onTap: () => openUrl(PortfolioData.emailUrl),
            ),
          ),
          const SizedBox(height: 24),
          Reveal(
            delay: step(5),
            child: const ShowMeTheCodeLink(prefix: 'Talk is cheap. '),
          ),
          SizedBox(height: mobile ? 64 : 80),
          Reveal(
            child: UnderlinedText(
              'Worked with',
              style: AppText.display(30),
              color: AppColors.peach,
            ),
          ),
          const SizedBox(height: 32),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 20,
            runSpacing: 20,
            children: [
              for (var i = 0; i < PortfolioData.companies.length; i++)
                Reveal(
                  delay: step(i),
                  child: TechStackCard(label: PortfolioData.companies[i]),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
