import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/styles/colors.dart';
import 'package:food_delivery/styles/dimensions.dart';
import 'package:food_delivery/widgets/small_text.dart';

class ExpandedText extends StatefulWidget {
  final String text;

  const ExpandedText({Key? key, required this.text}) : super(key: key);

  @override
  _ExpandedTextState createState() => _ExpandedTextState();
}

class _ExpandedTextState extends State<ExpandedText> {
  late String firstHalf;
  late String secondHalf;
  bool hideText = true;
  double textHeight = Dimension.screenHeight / 5.63;
  @override
  void initState() {
    super.initState();
    if (widget.text.length > textHeight) {
      //the text is long so we have to split it into two sections
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: secondHalf.isEmpty
            ? SmallText(
                text: widget.text,
                size: Dimension.font16,
                color: AppColors.paraColor,
              )
            : Column(
                children: [
                  SmallText(
                      text: hideText
                          ? (firstHalf + "...")
                          : (firstHalf + secondHalf),
                      size: Dimension.font16,
                      textHeight: 1.5,
                      color: AppColors.paraColor),
                  InkWell(
                    onTap: () {
                      setState(() {
                        hideText = !hideText;
                      });
                    },
                    child: Row(
                      children: [
                        SmallText(
                            text: hideText ? "Show more" : "Show less",
                            color: AppColors.mainColor,
                            size: Dimension.font16),
                        Icon(
                          hideText
                              ? Icons.arrow_drop_down
                              : Icons.arrow_drop_up,
                          color: AppColors.mainColor,
                        )
                      ],
                    ),
                  )
                ],
              ));
  }
}
