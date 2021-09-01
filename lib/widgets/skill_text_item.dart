import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SkillTextItem extends StatelessWidget {
  final String label;
  const SkillTextItem({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Text(label, style: GoogleFonts.lato(fontSize: 15)),
    );
  }
}
