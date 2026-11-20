import 'package:flutter/widgets.dart';

/// Non-web fallback (used by tests); the web build embeds a real iframe.
class IframeView extends StatelessWidget {
  const IframeView({super.key, required this.url, this.desktopWidth = 1280});

  final String url;
  final double desktopWidth;

  @override
  Widget build(BuildContext context) => const SizedBox.expand();
}
