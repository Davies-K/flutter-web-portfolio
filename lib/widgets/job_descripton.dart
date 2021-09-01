import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JobDescriptionItem extends StatelessWidget {
  final String company;
  final String team;
  final String timeSpan;
  const JobDescriptionItem(
      {Key? key,
      required this.timeSpan,
      required this.company,
      required this.team})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          TitleItem(company: company),
          Icon(FeatherIcons.arrowUpRight, color: Colors.black)
        ],
      ),
      SizedBox(height: 10),
      ItemLabel(label: team, color: Colors.black),
      SizedBox(height: 10),
      ItemLabel(label: timeSpan, color: Colors.grey)
    ]);
  }
}

class TitleItem extends StatelessWidget {
  const TitleItem({
    Key? key,
    required this.company,
  }) : super(key: key);

  final String company;

  @override
  Widget build(BuildContext context) {
    return Text("$company    ",
        style: GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 25));
  }
}

class ItemLabel extends StatelessWidget {
  const ItemLabel({
    Key? key,
    required this.color,
    required this.label,
  }) : super(key: key);

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(label,
        style: GoogleFonts.lato(fontWeight: FontWeight.bold, color: color));
  }
}
