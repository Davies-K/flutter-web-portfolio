import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/theme/app_theme.dart';
import 'package:portfolio/utils/url_utils.dart';
import 'package:portfolio/widgets/custom_cursor.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({super.key, required this.project, this.height = 340});

  final Project project;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Clickable(
      onTap: () => openUrl(project.url),
      semanticLabel: project.title,
      builder: (context, hovered) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRect(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutCubic,
              height: height,
              width: double.infinity,
              color: hovered ? AppColors.ink : project.color,
              child: Stack(
                children: [
                  Positioned(
                    right: -40,
                    bottom: -40,
                    child: AnimatedScale(
                      scale: hovered ? 1.15 : 1,
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeOutCubic,
                      child: AnimatedRotation(
                        turns: hovered ? -0.04 : 0,
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeOutCubic,
                        child: Icon(
                          project.icon,
                          size: 220,
                          color: (hovered ? Colors.white : AppColors.ink)
                              .withValues(alpha: 0.08),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            for (final tag in project.tags)
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 400),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: hovered
                                        ? Colors.white38
                                        : AppColors.ink.withValues(alpha: 0.2),
                                  ),
                                ),
                                child: Text(
                                  tag,
                                  style: AppText.body(
                                    size: 12,
                                    weight: FontWeight.w700,
                                    color:
                                        hovered ? Colors.white : AppColors.ink,
                                    height: 1.2,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const Spacer(),
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 400),
                          style: AppText.display(34).copyWith(
                            color: hovered ? Colors.white : AppColors.ink,
                          ),
                          child: Text(project.title),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 28,
                    right: 28,
                    child: AnimatedOpacity(
                      opacity: hovered ? 1 : 0,
                      duration: const Duration(milliseconds: 300),
                      child: AnimatedSlide(
                        offset: hovered ? Offset.zero : const Offset(-0.4, 0.4),
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOutCubic,
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: const Icon(LucideIcons.arrowUpRight,
                              size: 20, color: AppColors.ink),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(project.title,
              style: AppText.body(size: 16, weight: FontWeight.w700)),
          const SizedBox(height: 4),
          Text(project.description,
              style: AppText.body(color: const Color(0xFF555555))),
        ],
      ),
    );
  }
}
