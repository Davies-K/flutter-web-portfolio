import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/Constants/data.dart';
import 'package:portfolio/presentation/pages/sections/nav_section/nav_section_web.dart';
import 'package:portfolio/values/values.dart';
import 'package:portfolio/widgets/app_drawer.dart';
import 'package:portfolio/widgets/footer.dart';
import 'package:portfolio/widgets/image_container.dart';
import 'package:portfolio/widgets/job_descripton.dart';
import 'package:portfolio/widgets/nav_item.dart';
import 'package:portfolio/widgets/rounded_button.dart';
import 'package:portfolio/widgets/skill_text_item.dart';
import 'package:portfolio/widgets/social_icons_container.dart';
import 'package:portfolio/widgets/source_project.dart';
import 'package:portfolio/widgets/tech_stack_container.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:layout/layout.dart';
import 'sections/nav_section/nav_section_mobile.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Offset pointer = Offset(300, 300);
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
    TextTheme textTheme = Theme.of(context).textTheme;

    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
    final ScrollController _scrollController = ScrollController();

    final List<NavItemData> navItems = [
      NavItemData(name: StringConst.PORTFOLIO, key: GlobalKey()),
      NavItemData(name: StringConst.SERVICES, key: GlobalKey()),
      NavItemData(name: StringConst.RESUME, key: GlobalKey()),
      NavItemData(name: StringConst.CONTACT, key: GlobalKey()),
    ];
    return Scaffold(
        drawer: ResponsiveBuilder(
          refinedBreakpoints: RefinedBreakpoints(),
          builder: (context, sizingInformation) {
            if (sizingInformation.isMobile) {
              return AppDrawer(
                menuList: navItems,
                color: Colors.white,
              );
            } else {
              return SizedBox();
            }
          },
        ),
        body: MouseRegion(
          cursor: SystemMouseCursors.none,
          onHover: (eve) {
            setState(() {
              pointer = eve.position;
            });
          },
          child: Stack(
            children: [
              Column(children: [
                ResponsiveBuilder(
                  refinedBreakpoints: RefinedBreakpoints(),
                  builder: (context, sizingInformation) {
                    if (sizingInformation.isMobile) {
                      return NavSectionMobile(scaffoldKey: _scaffoldKey);
                    } else {
                      return NavSectionWeb(
                        navItems: navItems,
                      );
                    }
                  },
                ),
                SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        maxVerticalSpacing(),
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
                                fontSize: 50,
                                label: "Building ",
                                color: Color(0xFFD0EBED)),
                            Text('digital',
                                style: GoogleFonts.raleway(
                                    fontSize: 50, fontWeight: FontWeight.w600))
                          ],
                        ),
                        Text('products, brands, and \nexperience',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.raleway(
                                fontSize: 50, fontWeight: FontWeight.w600)),
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
                            width: socialIconContainerWidth(),
                            child: SocialIconsContainer()),
                        SizedBox(height: 20),
                        RoundedButton(
                            label: "Connect with Me", width: 180, height: 60),
                        maxVerticalSpacing(),
                        CustomUnderlined(
                            fontSize: 30,
                            label: "Clients ",
                            color: Color(0xFFF8E0CD)),
                        SizedBox(height: 30),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TechStackContainer(label: "Google"),
                              TechStackContainer(label: "uber"),
                              TechStackContainer(label: "stack"),
                              TechStackContainer(label: "evelead")
                            ]),
                        maxVerticalSpacing(),
                        Container(
                          height: 600,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 1000,
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
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ServiceContainer(),
                                      ServiceContainer(),
                                      ServiceContainer()
                                    ]),
                              )
                            ],
                          ),
                        ),
                        maxVerticalSpacing(),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                              width: 1000,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomUnderlined(
                                        fontSize: 40,
                                        label: "Resume",
                                        color: Color(0xFFD9DEFD)),
                                    maxVerticalSpacing(),
                                    Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  buildUnderlinedText(
                                                      "Experience",
                                                      GoogleFonts.lato(
                                                          color:
                                                              Color(0xFFD4EBEB),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 30)),
                                                  SizedBox(height: 40),
                                                  JobDescriptionItem(
                                                    company: 'Uber',
                                                    team: 'Product Designer',
                                                    timeSpan:
                                                        'December 2019 - Current',
                                                  ),
                                                  SizedBox(height: 40),
                                                  JobDescriptionItem(
                                                    company: 'Apple',
                                                    team: 'Product Designer',
                                                    timeSpan:
                                                        'December 2019 - Current',
                                                  )
                                                ]),
                                          ),
                                          //SizedBox(width: 200),
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  buildUnderlinedText(
                                                      "Education",
                                                      GoogleFonts.lato(
                                                          color:
                                                              Color(0xFFFEE1D9),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 30)),
                                                  SizedBox(height: 40),
                                                  JobDescriptionItem(
                                                    company:
                                                        'SUNY Politechnic Institute',
                                                    team:
                                                        'MSc. Information Design & Technology',
                                                    timeSpan:
                                                        'December 2019 - Current',
                                                  ),
                                                  SizedBox(height: 40),
                                                  JobDescriptionItem(
                                                    company:
                                                        'Florida Gulf Coast University',
                                                    team: 'Product Designer',
                                                    timeSpan:
                                                        'December 2019 - Current',
                                                  )
                                                ]),
                                          )
                                        ]),
                                    maxVerticalSpacing(),
                                    Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CustomUnderlined(
                                                      fontSize: 30,
                                                      label: "Skills",
                                                      color: Color(0xFFD4EBEB)),
                                                  SizedBox(height: 40),
                                                  Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Expanded(
                                                            flex: 1,
                                                            child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  TitleItem(
                                                                    company:
                                                                        "Design",
                                                                  ),
                                                                  SizedBox(
                                                                      height:
                                                                          10),
                                                                  ...List.generate(
                                                                      AppData
                                                                          .designSkills
                                                                          .length,
                                                                      (index) =>
                                                                          SkillTextItem(
                                                                              label: AppData.designSkills[index]))
                                                                ])),
                                                        Expanded(
                                                            flex: 1,
                                                            child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  TitleItem(
                                                                    company:
                                                                        "Development",
                                                                  ),
                                                                  SizedBox(
                                                                      height:
                                                                          10),
                                                                  ...List.generate(
                                                                      AppData
                                                                          .designSkills
                                                                          .length,
                                                                      (index) =>
                                                                          SkillTextItem(
                                                                              label: AppData.designSkills[index]))
                                                                ]))
                                                      ]),
                                                ]),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CustomUnderlined(
                                                      fontSize: 30,
                                                      label: "Courses",
                                                      color: Color(0xFFFEE1D9)),
                                                  SizedBox(height: 40),
                                                  JobDescriptionItem(
                                                    company:
                                                        'SUNY Politechnic Institute',
                                                    team:
                                                        'MSc. Information Design & Technology',
                                                    timeSpan:
                                                        'December 2019 - Current',
                                                  ),
                                                  SizedBox(height: 40),
                                                  JobDescriptionItem(
                                                    company:
                                                        'Florida Gulf Coast University',
                                                    team: 'Product Designer',
                                                    timeSpan:
                                                        'December 2019 - Current',
                                                  )
                                                ]),
                                          )
                                        ])
                                  ])),
                        ),
                        maxVerticalSpacing(),
                        //ShowCase
                        Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.8,
                            color: Colors.black),
                        // maxVerticalSpacing(),
                        Container(
                            width: 1100,
                            //  height: MediaQuery.of(context).size.height,
                            child: Row(children: [
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                      alignment: Alignment.center,
                                      child: Center(
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text("Taskez",
                                                  style: GoogleFonts.raleway(
                                                    fontSize: 30,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                              SizedBox(height: 20),
                                              Text(
                                                  "This was my first Flutter project in production. Your best \nfriend for generating designs from templates with your \nphotos. And oh, it comes with a feature that allows you \ndraw, overlay text and frames in a story-ish format.",
                                                  textAlign: TextAlign.left,
                                                  style: GoogleFonts.lato(
                                                    fontSize: 16,
                                                  )),
                                              SizedBox(height: 20),
                                              Image(
                                                  image: AssetImage(
                                                    "assets/images/play-store.png",
                                                  ),
                                                  width: 200,
                                                  height: 80)
                                            ]),
                                      ))),
                              Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      maxVerticalSpacing(),
                                      Stack(children: [
                                        Transform.scale(
                                            scale: 0.8, child: DrawnCircle()),
                                        Positioned(
                                            top: 400,
                                            left: 50,
                                            child: Container(
                                                width: 400,
                                                height: 400,
                                                decoration: BoxDecoration(
                                                    color: Color(0xFFE9FAFB),
                                                    shape: BoxShape.circle))),
                                        Image(
                                          fit: BoxFit.fitHeight,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.8,
                                          image: AssetImage(
                                              "assets/images/phone_screenshot.png"),
                                        )
                                      ]),
                                    ],
                                  ))
                            ])),

                        maxVerticalSpacing(),
                        //open-sourced project
                        Container(
                            width: 1000,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Works I have done, ",
                                      style: GoogleFonts.lato(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 40)),
                                  Row(
                                    children: [
                                      Row(
                                        children: [
                                          Text("open-sourced ",
                                              style: GoogleFonts.lato(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 40)),
                                          CustomUnderlined(
                                              fontSize: 40,
                                              label: "projects",
                                              color: Color(0xFFEFCFB4)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(children: [
                                    //first column
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 30),
                                          SourceProject(
                                            label: "Taskez",
                                            description:
                                                "We helped Vencortex in redesigning a whole new customer experience",
                                          ),
                                          SizedBox(height: 30),
                                          SourceProject(
                                            label: "Taskez",
                                            description:
                                                "We helped Vencortex in redesigning a whole new customer experience",
                                          )
                                        ]),
                                    SizedBox(width: 50),
                                    //second column
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 200),
                                          SizedBox(height: 30),
                                          SourceProject(
                                            label: "Taskez",
                                            description:
                                                "We helped Vencortex in redesigning a whole new customer experience",
                                          ),
                                          SizedBox(height: 30),
                                          SourceProject(
                                            label: "Taskez",
                                            description:
                                                "We helped Vencortex in redesigning a whole new customer experience",
                                          )
                                        ]),
                                  ])
                                ])),
                        Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height,
                            child: Stack(children: [
                              Positioned(
                                  right:
                                      MediaQuery.of(context).size.width * 0.6,
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
                                      width: MediaQuery.of(context).size.width *
                                          0.35,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              "Let me know if you want to talk about a potential collaboration. I'm available for freelance work",
                                              textAlign: TextAlign.start,
                                              style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 40)),
                                          SizedBox(height: 40),
                                          Row(
                                            children: [
                                              Text("Let's build your app   ",
                                                  style: GoogleFonts.montserrat(
                                                      decoration: TextDecoration
                                                          .underline,
                                                      color: Color(0xFFEFCFB4),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 40)),
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

                        maxVerticalSpacing(),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.85,
                            child: Footer())
                      ],
                    ),
                  ),
                )
              ]),

              //mouse cursor pointer
              Positioned(
                left: pointer.dx,
                top: pointer.dy,
                child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            width: 1.5,
                            color: Colors.black,
                            style: BorderStyle.solid)),
                    child: Center(
                      child: Container(
                          width: 3,
                          height: 3,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.black)),
                    )),
              ),
            ],
          ),
        ));
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
}

class ServiceContainer extends StatelessWidget {
  const ServiceContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        width: 350,
        height: 350,
        color: Colors.white);
  }
}

class DrawnCircle extends StatelessWidget {
  final double? size;
  final Color? color;
  const DrawnCircle({
    Key? key,
    this.size,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: size ?? 1000,
        height: size ?? 1000,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 1, color: color ?? Color(0xFFE5E6EB))));
  }
}

class CustomUnderlined extends StatelessWidget {
  final double fontSize;
  final String label;
  final double? textWidth;
  final Color color;
  final TextStyle? style;

  const CustomUnderlined({
    Key? key,
    required this.fontSize,
    this.style,
    this.textWidth,
    required this.label,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(label,
          style: GoogleFonts.raleway(
              // letterSpacing: -3,
              fontWeight: textWidth != null ? FontWeight.bold : FontWeight.w600,
              fontSize: fontSize)),
      CustomPaint(
        painter: OpenPainter(textWidth ?? fontSize * 5,
            trueWidth: textWidth != null ? true : null,
            strokeWidth: fontSize / 10,
            color: color),
      ),
    ]);
  }
}

class OpenPainter extends CustomPainter {
  final double strokeSize;
  final double strokeWidth;
  final Color color;
  final bool? trueWidth;

  OpenPainter(
    this.strokeSize, {
    required this.strokeWidth,
    required this.color,
    this.trueWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    //draw arc
    canvas.drawArc(
        Offset(trueWidth != null ? -(strokeWidth * 35) : -(strokeWidth * 25),
                -strokeWidth * 2) &
            Size(strokeSize, strokeSize / 5 + 30),
        3.8, //radians
        1.8, //radians
        false,
        paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
