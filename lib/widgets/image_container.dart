import 'package:flutter/material.dart';

class ProfileImageContainer extends StatelessWidget {
  final String imageUrl;
  final Color color;
  final double scale;
  ProfileImageContainer(
      {Key? key,
      required this.imageUrl,
      required this.color,
      required this.scale})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale,
      child: Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
          child: Center(
            child: Image(
                image: AssetImage(imageUrl), fit: BoxFit.contain, height: 120),
          )),
    );
  }
}
