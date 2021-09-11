import 'package:flutter/material.dart';
import 'package:portfolio/presentation/layout/adaptive.dart';

import '../home_page.dart';

class ServicesSection extends StatefulWidget {
  @override
  _ServicesSectionState createState() => _ServicesSectionState();
}

class _ServicesSectionState extends State<ServicesSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: (displayTypeOf(context) == DisplayType.desktop) ? 600 : 1300,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              alignment: Alignment.center,
              width: 1000,
              height:
                  (displayTypeOf(context) == DisplayType.desktop) ? 600 : 1300,
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
            child: (displayTypeOf(context) == DisplayType.desktop)
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        ServiceContainer(),
                        ServiceContainer(),
                        ServiceContainer()
                      ])
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        ServiceContainer(),
                        ServiceContainer(),
                        ServiceContainer()
                      ]),
          )
        ],
      ),
    );
  }
}
