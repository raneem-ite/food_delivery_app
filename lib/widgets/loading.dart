import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/styles/colors.dart';
import 'package:food_delivery/styles/dimensions.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Dimension.height10),
      child: Center(
          child: CircularProgressIndicator(
        color: AppColors.mainColor,
      )),
    );
  }
}
