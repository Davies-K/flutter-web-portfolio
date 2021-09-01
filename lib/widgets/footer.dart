import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/widgets/email_widget.dart';

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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
                flex: 1,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(FeatherIcons.github),
                      Icon(FeatherIcons.linkedin),
                      Icon(FeatherIcons.twitter)
                    ])),
            Expanded(
                flex: 9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    EmailWidget(
                      alignment: Alignment.centerRight,
                    ),
                  ],
                ))
          ],
        ),
      )
    ]);
  }
}
