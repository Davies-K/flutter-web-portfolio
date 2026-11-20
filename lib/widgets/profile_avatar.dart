import 'package:flutter/material.dart';
import 'package:portfolio/theme/app_theme.dart';

/// The memoji in a pastel circle, bobbing gently.
class ProfileAvatar extends StatefulWidget {
  const ProfileAvatar({
    super.key,
    required this.image,
    this.color = AppColors.avatar,
    this.size = 150,
  });

  final String image;
  final Color color;
  final double size;

  @override
  State<ProfileAvatar> createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2800),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: widget.color),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final t = Curves.easeInOutSine.transform(_controller.value);
          return Transform.translate(
            offset: Offset(0, -5 + 10 * t),
            child: Transform.rotate(angle: -0.03 + 0.06 * t, child: child),
          );
        },
        child: Center(
          child: Image.asset(widget.image, height: widget.size * 0.6),
        ),
      ),
    );
  }
}
