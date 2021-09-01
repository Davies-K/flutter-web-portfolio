import 'package:flutter/material.dart';
import 'package:portfolio/presentation/layout/adaptive.dart';
import 'package:portfolio/values/spaces.dart';
import 'package:portfolio/values/values.dart';
import 'package:portfolio/widgets/content_area.dart';

class NavSectionMobile extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const NavSectionMobile({required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    double screenWidth = widthOfScreen(context);
    double contentAreaWidth = screenWidth * 0.5;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        // boxShadow: [
        //   Shadows.elevationShadow,
        // ],
      ),
      child: Row(
        children: [
          ContentArea(
            width: contentAreaWidth,
            height: Sizes.HEIGHT_56,
            backgroundColor: Colors.white,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.menu,
                    size: Sizes.ICON_SIZE_30,
                    color: Colors.purple,
                  ),
                  onPressed: () {
                    if (scaffoldKey.currentState!.isEndDrawerOpen) {
                      scaffoldKey.currentState?.openEndDrawer();
                    } else {
                      //open menu
                      scaffoldKey.currentState?.openDrawer();
                    }
                  },
                ),
                SpaceW16(),
                SelectableText(
                  StringConst.NAME_ABBREV,
                  style: textTheme.headline3?.copyWith(
                    fontSize: Sizes.TEXT_SIZE_34,
                  ),
                ),
              ],
            ),
          ),
          ContentArea(
            width: contentAreaWidth,
            height: Sizes.HEIGHT_56,
            backgroundColor: Colors.purple,
            padding: const EdgeInsets.only(right: Sizes.PADDING_16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // CircularContainer(
                //   color: AppColors.purple100,
                //   child: IconButton(
                //     onPressed: () => openUrlLink(StringConst.EMAIL_URL),
                //     icon: Icon(Icons.mail_outline),
                //   ),
                // )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
