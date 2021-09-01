import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/presentation/layout/adaptive.dart';
import 'package:portfolio/utils/app_utils.dart';
import 'package:portfolio/values/spaces.dart';
import 'package:portfolio/values/values.dart';
import 'package:portfolio/widgets/content_area.dart';
import 'package:portfolio/widgets/email_widget.dart';
import 'package:portfolio/widgets/nav_item.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:layout/layout.dart';

class NavSectionWeb extends StatefulWidget {
  final List<NavItemData> navItems;

  NavSectionWeb({required this.navItems});

  @override
  _NavSectionWebState createState() => _NavSectionWebState();
}

class _NavSectionWebState extends State<NavSectionWeb> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    double sidePadding = getSidePadding(context);
    double screenWidth = widthOfScreen(context);
    double contentAreaWidth = screenWidth * 0.5;

    return Align(
      alignment: Alignment.center,
      child: Container(
        //alignment: Alignment.center,
        width: widthOfScreen(context) * 0.8,
        child: Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: EmailWidget(),
                ),
              ),
              Expanded(
                  flex: 1,
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    NavItem(
                      title: widget.navItems[0].name,
                      isSelected: true,
                      textColor: Colors.grey,
                      // selectedColor: Colors.blue,
                      onTap: () => _onTapNavItem(
                        context: widget.navItems[0].key,
                        navItemName: widget.navItems[0].name,
                      ),
                    ),
                    doubleHorizontalSpacing(),
                    NavItem(
                      title: widget.navItems[1].name,
                      isSelected: widget.navItems[1].isSelected,
                      //selectedColor: Colors.blue,
                      textColor: Colors.grey,
                      onTap: () => _onTapNavItem(
                        context: widget.navItems[1].key,
                        navItemName: widget.navItems[1].name,
                      ),
                    ),
                    doubleHorizontalSpacing(),
                    NavItem(
                      title: widget.navItems[2].name,
                      isSelected: widget.navItems[2].isSelected,
                      textColor: Colors.grey,
                      onTap: () => _onTapNavItem(
                        context: widget.navItems[2].key,
                        navItemName: widget.navItems[2].name,
                      ),
                    ),
                    ResponsiveBuilder(
                      refinedBreakpoints: RefinedBreakpoints(),
                      builder: (context, sizingInformation) {
                        double screenWidth = sizingInformation.screenSize.width;
                        //TODO:: Use this for actual.. if (screenWidth >= RefinedBreakpoints().tabletSmall &&  screenWidth < RefinedBreakpoints().tabletNormal) {
                        if (screenWidth > RefinedBreakpoints().tabletLarge) {
                          return Row(
                            children: [
                              doubleHorizontalSpacing(),
                              NavItem(
                                title: widget.navItems[3].name,
                                isSelected: widget.navItems[3].isSelected,
                                textColor: Colors.grey,
                                onTap: () => _onTapNavItem(
                                  context: widget.navItems[3].key,
                                  navItemName: widget.navItems[3].name,
                                ),
                              ),
                            ],
                          );
                        } else {
                          return SizedBox();
                        }
                      },
                    ),
                  ]))
            ],
          ),
        ),
      ),
    );
  }

  _onTapNavItem({
    required GlobalKey context,
    required String navItemName,
  }) {
    for (int index = 0; index < widget.navItems.length; index++) {
      if (navItemName == widget.navItems[index].name) {
        scrollToSection(context.currentContext!);
        setState(() {
          widget.navItems[index].isSelected = true;
        });
      } else {
        widget.navItems[index].isSelected = false;
      }
    }
  }

  Widget horizontalSpacing() {
    double width = context.layout.value(
      xs: Sizes.WIDTH_24,
      sm: Sizes.WIDTH_24,
      md: Sizes.WIDTH_40,
      lg: Sizes.WIDTH_40,
      xl: Sizes.WIDTH_40,
    );
    return SizedBox(width: width);
  }

  Widget doubleHorizontalSpacing() {
    double width = context.layout.value(
      xs: Sizes.WIDTH_24,
      sm: Sizes.WIDTH_24,
      md: Sizes.WIDTH_40,
      lg: Sizes.WIDTH_40,
      xl: Sizes.WIDTH_40,
    );
    return SizedBox(width: 2 * width);
  }

  double customSidePadding() {
    double width = context.layout.value(
      xs: Sizes.WIDTH_24,
      sm: Sizes.WIDTH_24,
      md: Sizes.WIDTH_40,
      lg: Sizes.WIDTH_40,
      xl: Sizes.WIDTH_40,
    );

    return width;
  }
}
