import 'package:flutter/material.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/theme/app_theme.dart';
import 'package:portfolio/widgets/custom_cursor.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard({super.key, required this.service, this.size = 350});

  final Service service;
  final double size;

  @override
  Widget build(BuildContext context) {
    return CursorHoverBuilder(
      builder: (context, hovered) => AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        width: size,
        height: size,
        transform: Matrix4.translationValues(0, hovered ? -10 : 0, 0),
        padding: const EdgeInsets.all(36),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: hovered ? 0.08 : 0.0),
              blurRadius: 40,
              offset: const Offset(0, 20),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: hovered ? AppColors.ink : service.tint,
              ),
              child: AnimatedRotation(
                turns: hovered ? -0.05 : 0,
                duration: const Duration(milliseconds: 300),
                child: Icon(
                  service.icon,
                  size: 26,
                  color: hovered ? Colors.white : AppColors.ink,
                ),
              ),
            ),
            const Spacer(),
            Text(service.title, style: AppText.display(24)),
            const SizedBox(height: 14),
            Text(
              service.description,
              style: AppText.body(size: 15, color: const Color(0xFF6B6B6B)),
            ),
          ],
        ),
      ),
    );
  }
}
