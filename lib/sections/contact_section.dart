import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/utils/responsive.dart';
import 'package:portfolio/utils/url_utils.dart';
import 'package:portfolio/widgets/custom_cursor.dart';
import 'package:portfolio/widgets/drawn_circle.dart';
import 'package:portfolio/widgets/reveal.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  static const _accent = Color(0xFFE8B590);
  static const _circle = Color(0xFFEFCFB4);

  @override
  Widget build(BuildContext context) {
    final mobile = Responsive.isMobile(context);
    final width = Responsive.width(context);
    final big = mobile ? 28.0 : 40.0;

    return SizedBox(
      height: mobile ? 560 : 720,
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: ShaderMask(
              blendMode: BlendMode.dstIn,
              shaderCallback: (rect) => const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.white,
                  Colors.white,
                  Colors.transparent,
                ],
                stops: [0, 0.25, 0.75, 1],
              ).createShader(rect),
              child: Stack(
                clipBehavior: Clip.hardEdge,
                children: _circles(width),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Reveal(
                    child: Text(
                      "Let me know if you want to talk about a potential collaboration. I'm available for freelance work.",
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                        fontSize: big,
                        height: 1.3,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Reveal(
                    delay: const Duration(milliseconds: 200),
                    child: Clickable(
                      onTap: () => openUrl(PortfolioData.emailUrl),
                      semanticLabel: "Let's build your app",
                      builder: (context, hovered) => _CallToAction(
                        hovered: hovered,
                        fontSize: mobile ? 22 : 36,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

List<Widget> _circles(double width) => [
      Positioned(
        right: width * 0.45,
        top: 0,
        child: const FloatingCircle(size: 800, color: ContactSection._circle),
      ),
      Positioned(
        left: width * 0.55,
        top: 120,
        child: const FloatingCircle(
          size: 600,
          color: ContactSection._circle,
          drift: Offset(-20, -24),
          period: Duration(seconds: 12),
        ),
      ),
    ];

class _CallToAction extends StatelessWidget {
  const _CallToAction({required this.hovered, required this.fontSize});

  final bool hovered;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    const label = "Let's build your app";
    final color = hovered ? Colors.black : ContactSection._accent;
    final style = GoogleFonts.montserrat(
      color: color,
      fontWeight: FontWeight.bold,
      fontSize: fontSize,
    );
    final textWidth = (TextPainter(
      text: TextSpan(text: label, style: style),
      textDirection: TextDirection.ltr,
    )..layout())
        .width;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 250),
              style: style,
              child: const Text(label, maxLines: 1, softWrap: false),
            ),
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeOutCubic,
              height: 3,
              width: hovered ? textWidth : textWidth * 0.35,
              color: color,
            ),
          ],
        ),
        const SizedBox(width: 16),
        AnimatedSlide(
          offset: hovered ? const Offset(0.25, -0.25) : Offset.zero,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          child: Icon(LucideIcons.arrowUpRight, size: fontSize, color: color),
        ),
      ],
    );
  }
}
