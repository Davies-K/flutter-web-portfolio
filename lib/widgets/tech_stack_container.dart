import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TechStackContainer extends StatelessWidget {
  final String label;
  const TechStackContainer({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(minWidth: 200),
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        width: 10,
        margin: EdgeInsets.only(right: 20, bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 3,
              offset: Offset(4, 8), // changes position of shadow
            ),
          ],
        ),
        child: Center(
            child: Text(label,
                style: GoogleFonts.modernAntiqua(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ))));
  }
}
