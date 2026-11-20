import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/theme/app_theme.dart';
import 'package:portfolio/utils/responsive.dart';
import 'package:portfolio/widgets/drawn_circle.dart';
import 'package:portfolio/widgets/reveal.dart';
import 'package:portfolio/widgets/service_card.dart';
import 'package:portfolio/widgets/underlined_text.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  static const _height = 600.0;

  @override
  Widget build(BuildContext context) {
    final desktop = Responsive.isDesktop(context);
    final cardSize =
        desktop ? 350.0 : (Responsive.width(context) * 0.8).clamp(280.0, 350.0);

    final cards = [
      for (var i = 0; i < PortfolioData.services.length; i++)
        Reveal(
          delay: Duration(milliseconds: 150 * i),
          offset: 48,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ServiceCard(
              service: PortfolioData.services[i],
              size: cardSize,
            ),
          ),
        ),
    ];

    return SizedBox(
      height: desktop ? _height : cardSize + 220,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // The pastel band the cards overflow.
          Center(
            child: Container(
              width: desktop ? Responsive.contentWidth : double.infinity,
              height: double.infinity,
              color: AppColors.servicesBand,
              child: ClipRect(
                child: Stack(
                  children: [
                    const Positioned(
                      right: 400,
                      top: -10,
                      child: FloatingCircle(),
                    ),
                    const Positioned(
                      left: 600,
                      top: -300,
                      child: FloatingCircle(
                        drift: Offset(-30, 20),
                        period: Duration(seconds: 11),
                      ),
                    ),
                    Positioned(
                      top: 20,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: UnderlinedText(
                          'Services',
                          style: AppText.display(30),
                          color: AppColors.lavender,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            top: desktop ? 0 : 90,
            child: desktop
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: cards,
                  )
                : ScrollConfiguration(
                    // Let mouse users drag the carousel too.
                    behavior: ScrollConfiguration.of(context).copyWith(
                      dragDevices: PointerDeviceKind.values.toSet(),
                      scrollbars: false,
                    ),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 30),
                      children: cards,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
