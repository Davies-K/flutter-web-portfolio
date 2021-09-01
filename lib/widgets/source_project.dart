import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SourceProject extends StatelessWidget {
  final String label;
  final String description;

  const SourceProject(
      {Key? key, required this.label, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: 300,
            color: Colors.black),
        SizedBox(height: 30),
        Text(label, style: GoogleFonts.lato(fontWeight: FontWeight.bold)),
        Text(description, style: GoogleFonts.lato())
      ],
    );
  }
}
