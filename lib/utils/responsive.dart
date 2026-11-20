import 'package:flutter/widgets.dart';

/// Width-based breakpoints for the whole site.
class Responsive {
  static const mobileMax = 700.0;
  static const desktopMin = 1150.0;
  static const contentWidth = 1000.0;

  static double width(BuildContext context) => MediaQuery.sizeOf(context).width;

  static bool isMobile(BuildContext context) => width(context) < mobileMax;

  static bool isDesktop(BuildContext context) => width(context) >= desktopMin;

  /// Picks a value for the current breakpoint.
  static T value<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    required T desktop,
  }) {
    if (isMobile(context)) return mobile;
    if (isDesktop(context)) return desktop;
    return tablet ?? desktop;
  }
}

/// Centers [child] and caps it at the site's content width, keeping
/// a comfortable gutter on smaller screens.
class ContentBox extends StatelessWidget {
  const ContentBox({
    super.key,
    required this.child,
    this.maxWidth = Responsive.contentWidth,
  });

  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    final gutter = Responsive.value<double>(
      context,
      mobile: 20,
      tablet: 40,
      desktop: 0,
    );
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: gutter),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: SizedBox(width: double.infinity, child: child),
        ),
      ),
    );
  }
}
