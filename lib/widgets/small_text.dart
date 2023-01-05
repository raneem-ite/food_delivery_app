import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SmallText extends StatelessWidget {
  final String text;
  final Color? color;
  final double size;
  final double textHeight;

  const SmallText(
      {Key? key,
      required this.text,
      this.color = const Color(0xFFccc7c5),
      this.size = 12,
      this.textHeight = 1.2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontSize: size,
          fontFamily: 'Roboto',
          height: textHeight),
    );
  }
}
