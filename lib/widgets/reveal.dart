import 'dart:async';

import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// Fades and slides [child] into place the first time it scrolls into view.
class Reveal extends StatefulWidget {
  const Reveal({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.offset = 32,
    this.duration = const Duration(milliseconds: 800),
  });

  final Widget child;
  final Duration delay;

  /// Vertical distance, in logical pixels, the child travels while appearing.
  final double offset;
  final Duration duration;

  @override
  State<Reveal> createState() => _RevealState();
}

class _RevealState extends State<Reveal> with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: widget.duration);
  late final Animation<double> _curve =
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
  final Key _detectorKey = UniqueKey();
  Timer? _timer;
  bool _triggered = false;

  void _onVisibility(VisibilityInfo info) {
    if (_triggered || info.visibleFraction < 0.05) return;
    _triggered = true;
    _timer = Timer(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: _detectorKey,
      onVisibilityChanged: _onVisibility,
      child: AnimatedBuilder(
        animation: _curve,
        builder: (context, child) => Opacity(
          opacity: _curve.value,
          child: Transform.translate(
            offset: Offset(0, widget.offset * (1 - _curve.value)),
            child: child,
          ),
        ),
        child: widget.child,
      ),
    );
  }
}
