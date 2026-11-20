import 'package:flutter/material.dart';
import 'package:portfolio/theme/app_theme.dart';

/// A thin outlined circle used as a background decoration.
class DrawnCircle extends StatelessWidget {
  const DrawnCircle({super.key, this.size = 1000, this.color});

  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 1, color: color ?? AppColors.border),
        ),
      ),
    );
  }
}

/// A [DrawnCircle] that drifts slowly back and forth, giving static
/// backgrounds a sense of depth.
class FloatingCircle extends StatefulWidget {
  const FloatingCircle({
    super.key,
    this.size = 1000,
    this.color,
    this.drift = const Offset(24, 16),
    this.period = const Duration(seconds: 9),
  });

  final double size;
  final Color? color;
  final Offset drift;
  final Duration period;

  @override
  State<FloatingCircle> createState() => _FloatingCircleState();
}

class _FloatingCircleState extends State<FloatingCircle>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: widget.period)
        ..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Transform.translate(
        offset:
            widget.drift * Curves.easeInOutSine.transform(_controller.value),
        child: child,
      ),
      child: DrawnCircle(size: widget.size, color: widget.color),
    );
  }
}
