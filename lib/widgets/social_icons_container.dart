import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

class SocialIconsContainer extends StatelessWidget {
  const SocialIconsContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: Colors.grey),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(children: [
          Expanded(flex: 1, child: Icon(FeatherIcons.github)),
          Expanded(
              flex: 1,
              child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                      border: Border(
                          left: BorderSide(width: 2, color: Colors.grey),
                          right: BorderSide(width: 2, color: Colors.grey))),
                  child: Icon(FeatherIcons.twitter))),
          Expanded(flex: 1, child: Icon(FeatherIcons.linkedin))
        ]));
  }
}
