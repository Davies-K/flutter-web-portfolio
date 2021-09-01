import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/presentation/layout/adaptive.dart';
import 'package:portfolio/utils/app_utils.dart';
import 'package:portfolio/values/spaces.dart';
import 'package:portfolio/values/values.dart';

import 'creators.dart';
import 'nav_item.dart';
import 'social_icons.dart';

const kSpacing20 = Sizes.SIZE_20;

class AppDrawer extends StatefulWidget {
  final Color color;
  final double? width;
  final List<NavItemData> menuList;
  final GestureTapCallback? onClose;

  AppDrawer({
    this.color = Colors.black,
    this.width,
    required this.menuList,
    this.onClose,
  });

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? assignWidth(context, 0.85),
      child: Drawer(
        child: Container(
          color: widget.color,
          child: Column(
            children: [
              SpaceH16(),
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: widget.onClose ?? () => _closeDrawer(),
                  ),
                ),
              ),
              Spacer(),
              ..._buildMenuList(
                context: context,
                menuList: widget.menuList,
              ),
              Spacer(),
              SocialIcons(
                icons: [
                  FontAwesomeIcons.linkedin,
                  FontAwesomeIcons.github,
                  FontAwesomeIcons.twitter,
                ],
                iconColor: Colors.white,
                socialLinks: [
                  StringConst.LINKED_IN_URL,
                  StringConst.GITHUB_URL,
                  StringConst.TWITTER_URL,
                ],
                spacing: kSpacing20,
              ),
              SpaceH24(),
              Creators(
                hasRightsText: false,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                builtInfoMainAxisAlignment: MainAxisAlignment.center,
                locationMainAxisAlignment: MainAxisAlignment.center,
                doesBuiltInfoComesFirst: false,
              ),
              SpaceH24(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildMenuList({
    required BuildContext context,
    required List<NavItemData> menuList,
  }) {
    TextTheme textTheme = Theme.of(context).textTheme;
    List<Widget> menuItems = [];
    for (var i = 0; i < menuList.length; i++) {
      menuItems.add(
        NavItem(
          onTap: () => _onTapNavItem(
            context: menuList[i].key,
            navItemName: menuList[i].name,
          ),
          title: menuList[i].name,
          isSelected: menuList[i].isSelected,
          titleStyle: textTheme.bodyText1?.copyWith(
            color: menuList[i].isSelected ? Colors.black : Colors.black,
            fontSize: Sizes.TEXT_SIZE_18,
            fontWeight:
                menuList[i].isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      );
      menuItems.add(Spacer());
    }
    return menuItems;
  }

  _onTapNavItem({
    required GlobalKey context,
    required String navItemName,
  }) {
    for (int index = 0; index < widget.menuList.length; index++) {
      if (navItemName == widget.menuList[index].name) {
        scrollToSection(context.currentContext!);
        setState(() {
          widget.menuList[index].isSelected = true;
        });
        _closeDrawer();
      } else {
        widget.menuList[index].isSelected = false;
      }
    }
  }

  _closeDrawer() {
    context.router.pop();
  }
}
