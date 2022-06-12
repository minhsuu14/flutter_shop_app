import 'package:flutter/material.dart';
import 'constants.dart';

class SquareIconButton extends StatelessWidget {
  final Function() onPressed;
  final Color iconColor, buttonColor;
  final double width;
  final IconData icon;
  final double borderRadius;

  const SquareIconButton({
    Key? key,
    required this.onPressed,
    this.iconColor = COLOR_GREEN,
    this.buttonColor = Colors.white,
    required this.icon,
    this.width = 70,
    this.borderRadius = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width,
        height: width,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Icon(
          icon,
          color: iconColor,
        ),
      ),
    );
  }
}
