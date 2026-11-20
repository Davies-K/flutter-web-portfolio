import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/theme/app_theme.dart';
import 'package:portfolio/utils/responsive.dart';
import 'package:portfolio/widgets/custom_cursor.dart';
import 'package:portfolio/widgets/email_widget.dart';
import 'package:portfolio/widgets/nav_item.dart';

class NavBar extends StatelessWidget {
  const NavBar({
    super.key,
    required this.items,
    required this.selected,
    required this.onSelect,
    required this.onMenu,
    required this.elevated,
  });

  final List<String> items;
  final int selected;
  final ValueChanged<int> onSelect;
  final VoidCallback onMenu;

  /// Whether the page has scrolled beneath the bar.
  final bool elevated;

  @override
  Widget build(BuildContext context) {
    final mobile = Responsive.isMobile(context);
    final width = Responsive.width(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      decoration: BoxDecoration(
        color: mobile ? Colors.white : AppColors.background,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: elevated ? 0.05 : 0),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: mobile
          ? const EdgeInsets.symmetric(horizontal: 20, vertical: 14)
          : EdgeInsets.symmetric(horizontal: width * 0.1, vertical: 18),
      child: mobile ? _mobile() : _web(width),
    );
  }

  Widget _mobile() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          PortfolioData.shortName,
          style: GoogleFonts.greatVibes(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: AppColors.ink,
          ),
        ),
        Clickable(
          onTap: onMenu,
          semanticLabel: 'Open menu',
          builder: (context, hovered) => const Padding(
            padding: EdgeInsets.all(8),
            child: Icon(Icons.menu, size: 30, color: AppColors.ink),
          ),
        ),
      ],
    );
  }

  Widget _web(double width) {
    // The last item drops off on narrow tablets to keep the bar on one line.
    final visible = width > 900 ? items.length : items.length - 1;
    final gap = width > 1100 ? 80.0 : 40.0;
    return Row(
      children: [
        const EmailWidget(),
        const Spacer(),
        for (var i = 0; i < visible; i++) ...[
          if (i > 0) SizedBox(width: gap),
          NavItem(
            title: items[i],
            selected: i == selected,
            onTap: () => onSelect(i),
          ),
        ],
      ],
    );
  }
}
