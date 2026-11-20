import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/utils/url_utils.dart';
import 'package:portfolio/widgets/custom_cursor.dart';

class EmailWidget extends StatelessWidget {
  const EmailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Clickable(
      onTap: () => openUrl(PortfolioData.emailUrl),
      semanticLabel: 'Email ${PortfolioData.email}',
      builder: (context, hovered) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: hovered ? Colors.black : Colors.transparent,
              border: Border.all(
                width: 1,
                color: hovered ? Colors.black : Colors.grey.shade400,
              ),
            ),
            child: Icon(
              LucideIcons.mail,
              size: 14,
              color: hovered ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            PortfolioData.email,
            style: GoogleFonts.lato(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
