import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/values/values.dart';

class EmailWidget extends StatelessWidget {
  Alignment? alignment;
  EmailWidget({
    this.alignment,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            alignment: alignment ?? Alignment.centerLeft,
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 1, color: Colors.grey[400]!)),
            child: Center(
                child: Icon(
              FeatherIcons.mail,
              size: 15,
            ))),
        SizedBox(width: 10),
        Text(StringConst.DEVELOPER_EMAIL,
            style: GoogleFonts.lato(fontWeight: FontWeight.bold))
      ],
    );
  }
}
