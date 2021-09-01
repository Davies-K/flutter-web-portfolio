import 'package:flutter/material.dart';

class CustomUnderlinedText extends StatelessWidget {
  final String label;
  const CustomUnderlinedText({Key? key, required this.label}) : super(key: key);

  // Here it is!
  Size _textSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
