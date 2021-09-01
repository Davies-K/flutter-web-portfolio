import 'package:flutter/material.dart';
import 'package:portfolio/values/values.dart';

class NavItemData {
  final String name;
  final GlobalKey key;
  bool isSelected;

  NavItemData({
    required this.name,
    required this.key,
    this.isSelected = false,
  });
}

class NavItem extends StatelessWidget {
  NavItem({
    required this.title,
    this.isSelected = false,
    this.titleStyle,
    this.textColor = Colors.black,
    this.selectedColor = Colors.black,
    this.onTap,
  });

  final String title;
  bool isSelected;
  final Color textColor;
  final Color selectedColor;
  final TextStyle? titleStyle;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        child: Text(
          title,
          style: titleStyle ??
              textTheme.headline6?.copyWith(
                color: isSelected ? selectedColor : textColor,
                fontSize: Sizes.TEXT_SIZE_14,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
              ),
        ),
      ),
    );
  }
}
