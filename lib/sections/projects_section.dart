import 'package:flutter/material.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/showcase/code_panel.dart';
import 'package:portfolio/theme/app_theme.dart';
import 'package:portfolio/utils/responsive.dart';
import 'package:portfolio/widgets/project_card.dart';
import 'package:portfolio/widgets/reveal.dart';
import 'package:portfolio/widgets/underlined_text.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final mobile = Responsive.isMobile(context);
    final titleStyle = AppText.heading(mobile ? 26 : 30);
    final projects = PortfolioData.projects;

    Widget card(int i) => Padding(
          padding: const EdgeInsets.only(top: 48),
          child: Reveal(
            offset: 56,
            child:
                ProjectCard(project: projects[i], height: mobile ? 280 : 340),
          ),
        );

    return ContentBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Reveal(child: Text('Works I have done,', style: titleStyle)),
          Reveal(
            delay: const Duration(milliseconds: 100),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text('open-sourced ', style: titleStyle),
                UnderlinedText('projects',
                    style: titleStyle, color: AppColors.peach),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Reveal(
            delay: Duration(milliseconds: 200),
            child: ShowMeTheCodeLink(color: AppColors.muted),
          ),
          if (mobile)
            for (var i = 0; i < projects.length; i++) card(i)
          else
            // Staggered two-column grid; the right column starts lower.
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(children: [
                    for (var i = 0; i < projects.length; i += 2) card(i),
                  ]),
                ),
                const SizedBox(width: 32),
                Expanded(
                  child: Column(children: [
                    const SizedBox(height: 160),
                    for (var i = 1; i < projects.length; i += 2) card(i),
                  ]),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
