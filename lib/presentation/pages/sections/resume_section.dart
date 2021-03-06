import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/Constants/data.dart';
import 'package:portfolio/presentation/layout/adaptive.dart';
import 'package:portfolio/values/values.dart';
import 'package:portfolio/widgets/job_descripton.dart';
import 'package:portfolio/widgets/skill_text_item.dart';
import 'package:layout/layout.dart';
import '../home_page.dart';

class ResumeSection extends StatelessWidget {
  ResumeSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

    return Transform.scale(
      scale: (displayTypeOf(context) == DisplayType.desktop &&
              !isDisplaySmallDesktopOrIpadPro(context))
          ? 1.0
          : 0.8,
      child: Align(
        alignment: Alignment.center,
        child: Container(
            width: (displayTypeOf(context) == DisplayType.desktop &&
                    !isDisplaySmallDesktopOrIpadPro(context))
                ? 1000
                : double.infinity,
            padding: (displayTypeOf(context) == DisplayType.desktop &&
                    !isDisplaySmallDesktopOrIpadPro(context))
                ? EdgeInsets.only(left: 0, right: 0)
                : EdgeInsets.only(left: 5, right: 5),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CustomUnderlined(
                  fontSize: 40, label: "Resume", color: Color(0xFFD9DEFD)),
              maxVerticalSpacing(),
              (displayTypeOf(context) == DisplayType.desktop)
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                          Expanded(flex: 1, child: experienceColumn()),
                          //SizedBox(width: 200),
                          Expanded(flex: 1, child: educationColumn())
                        ])
                  : Wrap(children: [
                      experienceColumn(),
                      //SizedBox(width: 200),
                      educationColumn()
                    ]),
              maxVerticalSpacing(),
              (displayTypeOf(context) == DisplayType.desktop)
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                          Expanded(flex: 1, child: skillsColumn(context)),
                          Expanded(flex: 1, child: coursesColumn())
                        ])
                  : Wrap(children: [skillsColumn(context), coursesColumn()])
            ])),
      ),
    );
  }

  buildUnderlinedText(String text, TextStyle style) {
    final Size txtSize = _textSize(text, style);
    print(txtSize.height);
    return CustomUnderlined(
        fontSize: style.fontSize!,
        label: text,
        textWidth: txtSize.width * 1.5,
        color: style.color!,
        style: style);
  }

  // Here it is!
  Size _textSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }

  Column coursesColumn() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      CustomUnderlined(
          fontSize: 30, label: "Courses", color: Color(0xFFFEE1D9)),
      SizedBox(height: 40),
      JobDescriptionItem(
        company: 'SUNY Politechnic Institute',
        team: 'MSc. Information Design & Technology',
        timeSpan: 'December 2019 - Current',
      ),
      SizedBox(height: 40),
      JobDescriptionItem(
        company: 'Florida Gulf Coast University',
        team: 'Product Designer',
        timeSpan: 'December 2019 - Current',
      )
    ]);
  }

  Column skillsColumn(context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      CustomUnderlined(fontSize: 30, label: "Skills", color: Color(0xFFD4EBEB)),
      SizedBox(height: 40),
      Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleItem(
                        company: "Design",
                      ),
                      SizedBox(height: 10),
                      ...List.generate(
                          AppData.designSkills.length,
                          (index) => SkillTextItem(
                              label: AppData.designSkills[index])),
                      SizedBox(height: 40),
                    ])),
            (displayTypeOf(context) == DisplayType.desktop &&
                    !isDisplaySmallDesktopOrIpadPro(context))
                ? Expanded(
                    flex: 1,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleItem(
                            company: "Development",
                          ),
                          SizedBox(height: 10),
                          ...List.generate(
                              AppData.designSkills.length,
                              (index) => SkillTextItem(
                                  label: AppData.designSkills[index]))
                        ]))
                : SizedBox(width: 0)
          ]),
    ]);
  }

  Column experienceColumn() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      buildUnderlinedText(
          "Experience",
          GoogleFonts.lato(
              color: Color(0xFFD4EBEB),
              fontWeight: FontWeight.bold,
              fontSize: 30)),
      SizedBox(height: 40),
      JobDescriptionItem(
        company: 'Uber',
        team: 'Product Designer',
        timeSpan: 'December 2019 - Current',
      ),
      SizedBox(height: 40),
      JobDescriptionItem(
        company: 'Apple',
        team: 'Product Designer',
        timeSpan: 'December 2019 - Current',
      ),
      SizedBox(height: 40),
    ]);
  }

  Column educationColumn() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      buildUnderlinedText(
          "Education",
          GoogleFonts.lato(
              color: Color(0xFFFEE1D9),
              fontWeight: FontWeight.bold,
              fontSize: 30)),
      SizedBox(height: 40),
      JobDescriptionItem(
        company: 'SUNY Politechnic Institute',
        team: 'MSc. Information Design & Technology',
        timeSpan: 'December 2019 - Current',
      ),
      SizedBox(height: 40),
      JobDescriptionItem(
        company: 'Florida Gulf Coast University',
        team: 'Product Designer',
        timeSpan: 'December 2019 - Current',
      )
    ]);
  }
}
