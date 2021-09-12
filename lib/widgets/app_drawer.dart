import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/presentation/layout/adaptive.dart';
import 'package:portfolio/utils/app_utils.dart';
import 'package:portfolio/values/spaces.dart';
import 'package:portfolio/values/values.dart';
import 'package:layout/layout.dart';
import 'package:portfolio/widgets/rounded_button.dart';
import 'package:portfolio/widgets/social_icons_container.dart';
import 'creators.dart';
import 'image_container.dart';
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
  Widget maxVerticalSpacing() {
    double height = context.layout.value(
      xs: Sizes.HEIGHT_24,
      sm: Sizes.HEIGHT_24,
      md: Sizes.HEIGHT_40,
      lg: Sizes.HEIGHT_40,
      xl: Sizes.HEIGHT_40,
    );
    return SizedBox(height: 2 * height);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthOfScreen(context) * 0.75,
      child: Drawer(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close, color: Colors.black)),
          ),
        ),
        maxVerticalSpacing(),
        Padding(
            padding: EdgeInsets.only(left: 20, bottom: 40),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ..._buildMenuList(context: context, menuList: widget.menuList),
            ])),
        Container(width: double.infinity, child: SocialIconsContainer()),
        SizedBox(height: 20),
        Align(
          alignment: Alignment.center,
          child: ProfileImageContainer(
            color: Colors.white,
            imageUrl: 'assets/images/memoji-5.png',
            scale: 1.0,
          ),
        ),
        Expanded(
            child: Align(
          alignment: Alignment.bottomCenter,
          child: RoundedButton(
              borderRadius: BorderRadius.circular(0.0),
              width: double.infinity,
              label: "Connect with Me",
              height: 80),
        ))
      ])),
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
          title: menuList[i].name.toLowerCase(),
          isSelected: menuList[i].isSelected,
          titleStyle: textTheme.bodyText1?.copyWith(
            color: menuList[i].isSelected ? Colors.black : Colors.black,
            fontSize: Sizes.TEXT_SIZE_18,
            fontWeight:
                menuList[i].isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      );
      // add spacer
      menuItems.add(SpaceH16());
    }
    return menuItems;
  }

// ontap nav item action
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
