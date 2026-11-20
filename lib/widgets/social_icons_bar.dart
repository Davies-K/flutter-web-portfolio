import 'package:flutter/material.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/utils/url_utils.dart';
import 'package:portfolio/widgets/brand_icon.dart';
import 'package:portfolio/widgets/custom_cursor.dart';

const _links = [
  (Brand.github, PortfolioData.githubUrl, 'GitHub'),
  (Brand.twitter, PortfolioData.twitterUrl, 'Twitter'),
  (Brand.linkedin, PortfolioData.linkedInUrl, 'LinkedIn'),
];

/// The bordered, segmented row of social links from the hero.
class SocialIconsBar extends StatelessWidget {
  const SocialIconsBar({super.key, this.width = 200});

  final double width;

  @override
  Widget build(BuildContext context) {
    const borderColor = Color(0xFF9E9E9E);
    return Container(
      width: width,
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: borderColor),
        borderRadius: BorderRadius.circular(5),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(3),
        child: Row(
          children: [
            for (var i = 0; i < _links.length; i++) ...[
              if (i > 0) Container(width: 2, color: borderColor),
              Expanded(
                child: Clickable(
                  onTap: () => openUrl(_links[i].$2),
                  semanticLabel: _links[i].$3,
                  builder: (context, hovered) => AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    color: hovered ? Colors.black : Colors.transparent,
                    alignment: Alignment.center,
                    child: AnimatedSlide(
                      offset: hovered ? const Offset(0, -0.08) : Offset.zero,
                      duration: const Duration(milliseconds: 220),
                      child: BrandIcon(
                        _links[i].$1,
                        color: hovered ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Compact icon-only social links, used in the footer.
class SocialIconsRow extends StatelessWidget {
  const SocialIconsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final link in _links)
          Clickable(
            onTap: () => openUrl(link.$2),
            semanticLabel: link.$3,
            builder: (context, hovered) => Padding(
              padding: const EdgeInsets.all(8),
              child: AnimatedScale(
                scale: hovered ? 1.15 : 1,
                duration: const Duration(milliseconds: 180),
                child: BrandIcon(
                  link.$1,
                  size: 20,
                  color: hovered ? Colors.black : Colors.black54,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
