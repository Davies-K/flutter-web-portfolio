import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:layout/layout.dart';
import 'package:portfolio/presentation/layout/adaptive.dart';
import 'package:portfolio/values/values.dart';
import 'package:portfolio/widgets/image_container.dart';
import 'package:portfolio/widgets/rounded_button.dart';
import 'package:portfolio/widgets/social_icons_container.dart';
import 'package:portfolio/widgets/tech_stack_container.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../home_page.dart';

class HeaderSection extends StatefulWidget {
  HeaderSection({Key? key}) : super(key: key);

  @override
  _HeaderSectionState createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {
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

  double socialIconContainerWidth() {
    double width = context.layout.value(
      xs: Sizes.WIDTH_160,
      sm: Sizes.WIDTH_160,
      md: Sizes.WIDTH_200,
      lg: Sizes.WIDTH_200,
      xl: Sizes.WIDTH_200,
    );
    return width;
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: (displayTypeOf(context) == DisplayType.mobile) ? 0.85 : 1,
      child: Column(children: [
        SizedBox(height: 20),
        ProfileImageContainer(
          color: Color(0xFFE9FAFB),
          imageUrl: 'assets/images/8.png',
          scale: 1.0,
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomUnderlined(
                fontSize: 50, label: "Building ", color: Color(0xFFD0EBED)),
            Text('digital',
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.w600))
          ],
        ),
        Container(
          width: double.infinity,
          child: Text('products, brands, and \nexperience',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.w600)),
        ),
        SizedBox(height: 20),
        Text(
          'a Product Designer and Visual Developer in SF.',
          textAlign: TextAlign.center,
        ),
        Text(
            'I specialize in UI/UX Design, Responsive Web Design, \nand Visual Development.',
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(
              color: AppColors.primaryText,
              height: 1.5,
            )),
        SizedBox(height: 20),
        Container(
            width: socialIconContainerWidth(), child: SocialIconsContainer()),
        SizedBox(height: 20),
        RoundedButton(label: "Connect with Me", width: 180, height: 60),
        maxVerticalSpacing(),
        CustomUnderlined(
            fontSize: 30, label: "Clients ", color: Color(0xFFF8E0CD)),
        SizedBox(height: 30),
        (displayTypeOf(context) != DisplayType.mobile)
            ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                TechStackContainer(label: "Google"),
                TechStackContainer(label: "uber"),
                TechStackContainer(label: "stack"),
                TechStackContainer(label: "evelead")
              ])
            : Wrap(alignment: WrapAlignment.center, children: [
                TechStackContainer(label: "Google"),
                TechStackContainer(label: "uber"),
                TechStackContainer(label: "stack"),
                TechStackContainer(label: "evelead")
              ])
      ]),
    );
  }
}
