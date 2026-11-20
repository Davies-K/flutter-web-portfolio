import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// Tracks how many interactive widgets the pointer is currently over.
class CursorController {
  CursorController._();
  static final instance = CursorController._();

  final ValueNotifier<int> _hovering = ValueNotifier(0);
  ValueListenable<int> get hovering => _hovering;

  void enter() => _hovering.value++;
  void exit() => _hovering.value = math.max(0, _hovering.value - 1);

  /// True while the pointer is over a dark surface, so the cursor turns white.
  final ValueNotifier<bool> onDark = ValueNotifier(false);
}

/// Replaces the system mouse pointer with a ring-and-dot cursor.
///
/// The dot follows the pointer exactly while the ring trails behind with
/// easing. Over anything wrapped in [CursorHover] the ring expands and the
/// dot fades. Touch input never shows the cursor.
class CustomCursor extends StatefulWidget {
  const CustomCursor({super.key, required this.child});

  final Widget child;

  @override
  State<CustomCursor> createState() => _CustomCursorState();
}

class _CustomCursorState extends State<CustomCursor>
    with SingleTickerProviderStateMixin {
  static const _ringSize = 40.0;
  static const _hoverRingSize = 64.0;
  static const _dotSize = 4.0;

  late final Ticker _ticker;
  Duration _lastTick = Duration.zero;

  Offset _target = Offset.zero;
  Offset _ring = Offset.zero;
  bool _visible = false;
  bool _pressed = false;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_onTick);
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  void _onTick(Duration elapsed) {
    final dt = (elapsed - _lastTick).inMicroseconds / 1e6;
    _lastTick = elapsed;
    // Frame-rate independent exponential easing.
    final t = 1 - math.exp(-dt * 16);
    setState(() => _ring = Offset.lerp(_ring, _target, t)!);
    if ((_ring - _target).distance < 0.1) {
      _ring = _target;
      _ticker.stop();
    }
  }

  void _track(PointerEvent event) {
    if (event.kind != PointerDeviceKind.mouse) {
      if (_visible) setState(() => _visible = false);
      return;
    }
    _target = event.position;
    if (!_visible) {
      _ring = _target;
      setState(() => _visible = true);
    } else {
      setState(() {});
    }
    if (!_ticker.isActive) {
      _lastTick = Duration.zero;
      _ticker.start();
    }
  }

  void _setPressed(PointerEvent event, bool pressed) {
    if (event.kind == PointerDeviceKind.mouse) {
      setState(() => _pressed = pressed);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.none,
      onExit: (_) => setState(() => _visible = false),
      child: Listener(
        behavior: HitTestBehavior.translucent,
        onPointerHover: _track,
        onPointerMove: _track,
        onPointerDown: (e) {
          _track(e);
          _setPressed(e, true);
        },
        onPointerUp: (e) => _setPressed(e, false),
        child: Stack(
          children: [
            widget.child,
            if (_visible)
              ValueListenableBuilder<int>(
                valueListenable: CursorController.instance.hovering,
                builder: (context, hovering, _) => ValueListenableBuilder<bool>(
                  valueListenable: CursorController.instance.onDark,
                  builder: (context, onDark, _) => _buildCursor(
                      hovering > 0, onDark ? Colors.white : Colors.black),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCursor(bool hovering, Color color) {
    final ringSize = hovering ? _hoverRingSize : _ringSize;
    final scale = _pressed ? 0.8 : 1.0;
    return IgnorePointer(
      child: Stack(
        children: [
          Positioned(
            left: _ring.dx - _hoverRingSize / 2,
            top: _ring.dy - _hoverRingSize / 2,
            width: _hoverRingSize,
            height: _hoverRingSize,
            child: Center(
              child: AnimatedScale(
                scale: scale,
                duration: const Duration(milliseconds: 150),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOutCubic,
                  width: ringSize,
                  height: ringSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: hovering
                        ? color.withValues(alpha: 0.08)
                        : Colors.transparent,
                    border: Border.all(width: 1.5, color: color),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: _target.dx - _dotSize / 2,
            top: _target.dy - _dotSize / 2,
            child: AnimatedOpacity(
              opacity: hovering ? 0 : 1,
              duration: const Duration(milliseconds: 150),
              child: Container(
                width: _dotSize,
                height: _dotSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Marks [child] as interactive so the custom cursor reacts to it.
///
/// Leaves the system cursor deferred to [CustomCursor], which hides it.
class CursorHover extends StatefulWidget {
  const CursorHover({super.key, required this.child, this.onHover});

  final Widget child;
  final ValueChanged<bool>? onHover;

  @override
  State<CursorHover> createState() => _CursorHoverState();
}

class _CursorHoverState extends State<CursorHover> {
  bool _inside = false;

  void _set(bool inside) {
    if (_inside == inside) return;
    _inside = inside;
    inside
        ? CursorController.instance.enter()
        : CursorController.instance.exit();
    widget.onHover?.call(inside);
  }

  @override
  void dispose() {
    if (_inside) CursorController.instance.exit();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _set(true),
      onExit: (_) => _set(false),
      child: widget.child,
    );
  }
}

/// A tappable region that reports hover state and drives the custom cursor.
class Clickable extends StatefulWidget {
  const Clickable({
    super.key,
    required this.onTap,
    required this.builder,
    this.semanticLabel,
  });

  final VoidCallback? onTap;
  final Widget Function(BuildContext context, bool hovered) builder;
  final String? semanticLabel;

  @override
  State<Clickable> createState() => _ClickableState();
}

class _ClickableState extends State<Clickable> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: widget.semanticLabel,
      child: CursorHover(
        onHover: (h) => setState(() => _hovered = h),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: widget.onTap,
          child: widget.builder(context, _hovered),
        ),
      ),
    );
  }
}

/// Rebuilds with hover state for decorative hover effects on elements that
/// aren't clickable, so the cursor keeps its resting shape.
class CursorHoverBuilder extends StatefulWidget {
  const CursorHoverBuilder({super.key, required this.builder});

  final Widget Function(BuildContext context, bool hovered) builder;

  @override
  State<CursorHoverBuilder> createState() => _CursorHoverBuilderState();
}

class _CursorHoverBuilderState extends State<CursorHoverBuilder> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: widget.builder(context, _hovered),
    );
  }
}
