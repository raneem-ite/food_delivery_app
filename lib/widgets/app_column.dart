import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/styles/colors.dart';
import 'package:food_delivery/styles/dimensions.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'icon_and_text.dart';

class AppColumn extends StatelessWidget {
  final String text;

  const AppColumn({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Dimension.height20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          // top
          children: [
            BigText(
              text: text,
              size: Dimension.font26,
              // color: Colors.black54,
            ),

            SizedBox(height: Dimension.height10),

            //text 2
            Row(
              children: [
                // stars
                Wrap(
                  children: List.generate(
                      5,
                      (index) => Icon(
                            Icons.star,
                            color: AppColors.mainColor,
                            size: Dimension.font16,
                          )),
                ),
                const SizedBox(width: 10),
                // text
                SmallText(
                  text: "4.5",
                  size: Dimension.font16,
                ),
                const SizedBox(width: 10),
                //comment
                SmallText(text: "1287 comments", size: Dimension.font16),
              ],
            ),

            SizedBox(height: Dimension.height20),

            //actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconAndText(
                  icon: Icons.circle_sharp,
                  text: "Normal",
                  iconColor: AppColors.yellowColor,
                ),
                IconAndText(
                  icon: Icons.location_on,
                  text: "1.7km",
                  iconColor: AppColors.mainColor,
                ),
                IconAndText(
                  icon: Icons.access_time_rounded,
                  text: "32min",
                  iconColor: AppColors.iconColor2,
                ),
              ],
            )
          ]),
    );
  }
}
