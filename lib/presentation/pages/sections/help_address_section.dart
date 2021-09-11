import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/presentation/layout/adaptive.dart';

import '../home_page.dart';

class HelpAddressSection extends StatelessWidget {
  const HelpAddressSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: (displayTypeOf(context) == DisplayType.desktop) ? 1 : 0.65,
      child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Stack(children: [
            Positioned(
                right: MediaQuery.of(context).size.width * 0.6,
                child: Transform.scale(
                    scale: 0.8,
                    child: DrawnCircle(
                      color: Color(0xFFEFCFB4),
                    ))),
            Positioned(
                top: 50,
                left: MediaQuery.of(context).size.width * 0.6,
                child: Transform.scale(
                    scale: 0.6,
                    child: DrawnCircle(
                      color: Color(0xFFEFCFB4),
                    ))),
            Center(
                child: Container(
                    width: (displayTypeOf(context) == DisplayType.desktop)
                        ? widthOfScreen(context) * 0.35
                        : widthOfScreen(context) * 0.88,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            "Let me know if you want to talk about a potential collaboration. I'm available for freelance work",
                            textAlign: TextAlign.start,
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold, fontSize: 40)),
                        SizedBox(height: 40),
                        Row(
                          children: [
                            Text("Let's build your app   ",
                                style: GoogleFonts.montserrat(
                                    decoration: TextDecoration.underline,
                                    color: Color(0xFFEFCFB4),
                                    fontWeight: FontWeight.bold,
                                    fontSize: (displayTypeOf(context) ==
                                            DisplayType.desktop)
                                        ? 40
                                        : 35)),
                            Icon(
                              FeatherIcons.arrowUpRight,
                              size: 40,
                              color: Color(0xFFEFCFB4),
                            )
                          ],
                        )
                      ],
                    )))
          ])),
    );
  }
}
