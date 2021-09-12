import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/widgets/email_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Footer extends StatefulWidget {
  Footer({Key? key}) : super(key: key);

  @override
  _FooterState createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Divider(),
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Icon(FeatherIcons.github),
              SizedBox(width: 20),
              Icon(FeatherIcons.linkedin),
              SizedBox(width: 20),
              Icon(FeatherIcons.twitter)
            ]),

            EmailWidget(
              alignment: Alignment.centerRight,
            ),

            // ResponsiveBuilder(
            //   refinedBreakpoints: RefinedBreakpoints(),
            //   builder: (context, sizingInformation) {
            //     if (sizingInformation.isMobile) {
            //       return Expanded(
            //           flex: 9,
            //           child: Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               children: [
            //                 Icon(FeatherIcons.github),
            //                 SizedBox(width: 10),
            //                 Icon(FeatherIcons.linkedin),
            //                 SizedBox(width: 10),
            //                 Icon(FeatherIcons.twitter)
            //               ]));
            //     } else {
            //       return Expanded(
            //           flex: 1,
            //           child: Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               children: [
            //                 Icon(FeatherIcons.github),
            //                 SizedBox(width: 10),
            //                 Icon(FeatherIcons.linkedin),
            //                 SizedBox(width: 10),
            //                 Icon(FeatherIcons.twitter)
            //               ]));
            //     }
            //   },
            // ),
            // Expanded(
            //     flex: 9,
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.end,
            //       children: [
            //         EmailWidget(
            //           alignment: Alignment.centerRight,
            //         ),
            //       ],
            //     ))
          ],
        ),
      )
    ]);
  }
}
