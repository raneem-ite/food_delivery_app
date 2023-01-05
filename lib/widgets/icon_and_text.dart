import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_delivery/styles/dimensions.dart';
import 'package:food_delivery/widgets/small_text.dart';

class IconAndText extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String text;

  const IconAndText({
    Key? key,
    required this.icon,
    required this.text,
    required this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: Dimension.iconSize24,
        ),
        const SizedBox(width: 2),
        SmallText(
          text: text,
        )
      ],
    );
  }
}
