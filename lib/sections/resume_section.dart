import 'package:flutter/material.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/theme/app_theme.dart';
import 'package:portfolio/utils/responsive.dart';
import 'package:portfolio/widgets/resume_item.dart';
import 'package:portfolio/widgets/reveal.dart';
import 'package:portfolio/widgets/underlined_text.dart';

class ResumeSection extends StatelessWidget {
  const ResumeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final mobile = Responsive.isMobile(context);
    final gap = SizedBox(height: mobile ? 56 : 80);

    final columns = [
      _entries('Experience', AppColors.mint, PortfolioData.experience),
      _entries('Previously', AppColors.blush, PortfolioData.previously),
    ];

    final skillGroups = PortfolioData.skills.entries.toList();

    return ContentBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Reveal(
            child: UnderlinedText(
              'Resume',
              style: AppText.display(mobile ? 34 : 40),
              color: AppColors.lavenderLight,
            ),
          ),
          gap,
          _responsiveRow(mobile, columns),
          gap,
          Reveal(
            child: UnderlinedText(
              'Skills',
              style: AppText.display(30),
              color: AppColors.mint,
            ),
          ),
          const SizedBox(height: 40),
          _responsiveRow(
            mobile,
            [
              for (var i = 0; i < skillGroups.length; i++)
                Reveal(
                  delay: Duration(milliseconds: 120 * i),
                  child: _skillList(skillGroups[i].key, skillGroups[i].value),
                ),
            ],
            spacing: 32,
          ),
        ],
      ),
    );
  }

  Widget _responsiveRow(bool mobile, List<Widget> children,
      {double spacing = 56}) {
    if (mobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < children.length; i++) ...[
            if (i > 0) SizedBox(height: spacing),
            children[i],
          ],
        ],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < children.length; i++) ...[
          if (i > 0) const SizedBox(width: 24),
          Expanded(child: children[i]),
        ],
      ],
    );
  }

  Widget _entries(String title, Color color, List<ResumeEntry> entries) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Reveal(
          child:
              UnderlinedText(title, style: AppText.display(30), color: color),
        ),
        for (var i = 0; i < entries.length; i++) ...[
          const SizedBox(height: 40),
          Reveal(
            delay: Duration(milliseconds: 100 * (i + 1)),
            child: ResumeItem(entry: entries[i]),
          ),
        ],
      ],
    );
  }

  Widget _skillList(String title, List<String> skills) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: AppText.heading(22).copyWith(
              fontWeight: FontWeight.w500,
            )),
        const SizedBox(height: 12),
        for (final skill in skills)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 7),
            child: Text(skill, style: AppText.body(size: 15, height: 1.3)),
          ),
      ],
    );
  }
}
