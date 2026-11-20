import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/widgets/custom_cursor.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    super.key,
    required this.label,
    required this.onTap,
    this.width = 180,
    this.height = 60,
    this.borderRadius,
  });

  final String label;
  final VoidCallback onTap;
  final double width;
  final double height;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Clickable(
      onTap: onTap,
      semanticLabel: label,
      builder: (context, hovered) => AnimatedScale(
        scale: hovered ? 1.04 : 1,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: width,
          height: height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: borderRadius ?? BorderRadius.circular(height / 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: hovered ? 0.25 : 0.0),
                blurRadius: 24,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  style: GoogleFonts.lato(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: hovered ? 24 : 0,
                child: ClipRect(
                  child: hovered
                      ? const Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Icon(Icons.arrow_forward,
                              size: 16, color: Colors.white),
                        )
                      : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
