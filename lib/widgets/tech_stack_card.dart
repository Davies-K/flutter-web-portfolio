import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/widgets/custom_cursor.dart';

class TechStackCard extends StatelessWidget {
  const TechStackCard({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return CursorHoverBuilder(
      builder: (context, hovered) => AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0, hovered ? -6 : 0, 0),
        constraints: const BoxConstraints(minWidth: 150),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: hovered ? 0.28 : 0.2),
              blurRadius: hovered ? 18 : 3,
              offset: hovered ? const Offset(0, 14) : const Offset(4, 8),
            ),
          ],
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: GoogleFonts.modernAntiqua(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
