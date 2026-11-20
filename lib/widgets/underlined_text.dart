import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// Text with a soft, hand-drawn arc beneath it that sketches itself in when
/// it first becomes visible.
class UnderlinedText extends StatefulWidget {
  const UnderlinedText(
    this.text, {
    super.key,
    required this.style,
    required this.color,
  });

  final String text;
  final TextStyle style;
  final Color color;

  @override
  State<UnderlinedText> createState() => _UnderlinedTextState();
}

class _UnderlinedTextState extends State<UnderlinedText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  );
  final Key _detectorKey = UniqueKey();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fontSize = widget.style.fontSize ?? 30;
    final stroke = (fontSize / 14).clamp(2.0, 4.0);
    return VisibilityDetector(
      key: _detectorKey,
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.5 && !_controller.isAnimating) {
          Future.delayed(const Duration(milliseconds: 250), () {
            if (mounted) _controller.forward();
          });
        }
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: -fontSize * 0.12,
            right: -fontSize * 0.12,
            bottom: -fontSize * 0.1,
            height: fontSize * 0.32,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, _) => CustomPaint(
                painter: _ArcPainter(
                  progress: Curves.easeInOutCubic.transform(_controller.value),
                  color: widget.color,
                  strokeWidth: stroke,
                ),
              ),
            ),
          ),
          Text(widget.text, style: widget.style),
        ],
      ),
    );
  }
}

class _ArcPainter extends CustomPainter {
  _ArcPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
  });

  final double progress;
  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    if (progress == 0) return;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;
    final path = Path()
      ..moveTo(0, size.height)
      ..quadraticBezierTo(
        size.width / 2,
        -size.height * 0.4,
        size.width,
        size.height,
      );
    for (final PathMetric metric in path.computeMetrics()) {
      canvas.drawPath(metric.extractPath(0, metric.length * progress), paint);
    }
  }

  @override
  bool shouldRepaint(_ArcPainter old) =>
      old.progress != progress ||
      old.color != color ||
      old.strokeWidth != strokeWidth;
}
