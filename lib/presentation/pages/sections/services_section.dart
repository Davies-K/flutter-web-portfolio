import 'package:flutter/material.dart';
import 'package:portfolio/presentation/layout/adaptive.dart';

import '../home_page.dart';

class ServicesSection extends StatefulWidget {
  ServicesSection({Key? key}) : super(key: key);

  @override
  _ServicesSectionState createState() => _ServicesSectionState();
}

class _ServicesSectionState extends State<ServicesSection> {
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: (displayTypeOf(context) == DisplayType.desktop) ? 1 : 0.8,
      child: Container(
        key: widget.key!,
        height: 600,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                alignment: Alignment.center,
                width: (displayTypeOf(context) == DisplayType.desktop &&
                        !isDisplaySmallDesktopOrIpadPro(context))
                    ? 1000
                    : double.infinity,
                height: 600,
                //padding: EdgeInsets.all(50),
                color: Color(0xFFF4F5FC),
                child: Stack(
                  children: [
                    Positioned(
                      right: 600,
                      child: DrawnCircle(),
                    ),
                    Positioned(
                      left: 600,
                      bottom: 5,
                      child: DrawnCircle(),
                    ),
                    Positioned(
                      top: 20,
                      right: 50,
                      left: 50,
                      child: CustomUnderlined(
                          fontSize: 30,
                          label: "Services",
                          color: Color(0xFFB5C0FD)),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: (displayTypeOf(context) == DisplayType.desktop &&
                      !isDisplaySmallDesktopOrIpadPro(context))
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          ServiceContainer(),
                          ServiceContainer(),
                          ServiceContainer()
                        ])
                  : Container(
                      width: double.infinity,
                      height: 400,
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              ServiceContainer(),
                              ServiceContainer(),
                              ServiceContainer()
                            ]),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
