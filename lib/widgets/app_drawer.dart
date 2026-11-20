import 'package:flutter/material.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/theme/app_theme.dart';
import 'package:portfolio/utils/url_utils.dart';
import 'package:portfolio/widgets/custom_cursor.dart';
import 'package:portfolio/widgets/nav_item.dart';
import 'package:portfolio/widgets/profile_avatar.dart';
import 'package:portfolio/widgets/rounded_button.dart';
import 'package:portfolio/widgets/social_icons_bar.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
    required this.items,
    required this.selected,
    required this.onSelect,
  });

  final List<String> items;
  final int selected;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(),
      width: MediaQuery.sizeOf(context).width * 0.8,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Clickable(
                onTap: () => Navigator.of(context).pop(),
                semanticLabel: 'Close menu',
                builder: (context, _) => const Padding(
                  padding: EdgeInsets.all(16),
                  child: Icon(Icons.close, color: AppColors.ink),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.only(left: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var i = 0; i < items.length; i++)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: NavItem(
                        title: items[i],
                        selected: i == selected,
                        style: AppText.display(22).copyWith(
                          fontWeight:
                              i == selected ? FontWeight.w600 : FontWeight.w400,
                          color:
                              i == selected ? AppColors.ink : AppColors.muted,
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                          onSelect(i);
                        },
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Center(child: SocialIconsBar(width: 200)),
            const SizedBox(height: 32),
            const Center(
              child: ProfileAvatar(image: 'assets/images/memoji-5.png'),
            ),
            const Spacer(),
            RoundedButton(
              label: 'Connect with Me',
              width: double.infinity,
              height: 72,
              borderRadius: BorderRadius.zero,
              onTap: () => openUrl(PortfolioData.emailUrl),
            ),
          ],
        ),
      ),
    );
  }
}
