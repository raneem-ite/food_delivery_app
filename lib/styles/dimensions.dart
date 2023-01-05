import 'package:get/get.dart';

class Dimension {
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  // page media query height = 844
  // height we used for slider = 220
  // 844 / 220 = 3.84 which is the factor
  static double pageViewConatiner = screenHeight / 3.84;

  // page media query height = 844
  // height we used for slider = 120
  // 844 / 120 = 7.03 which is the factor
  static double pageViewTextConatiner = screenHeight / 7.03;
  static double pageView = screenHeight / 2.64;
  static double listItemHeight = screenHeight / 8.44; //100pixel

  //dynamic height padding and margin
  static double height10 = screenHeight / 84.4;
  static double height15 = screenHeight / 56.27;
  static double height20 = screenHeight / 42.2;
  static double height30 = screenHeight / 28.3;
  static double height45 = screenHeight / 18.76;

  //dynamic width padding and margin
  static double width10 = screenHeight / 84.4;
  static double width15 = screenHeight / 56.27;
  static double width20 = screenHeight / 42.2;
  static double width30 = screenHeight / 28.3;

  static double padding15 = screenHeight / 56.27;

  static double font14 = screenHeight / 60.28;
  static double font16 = screenHeight / 52.75;
  static double font20 = screenHeight / 42.2;
  static double font26 = screenHeight / 32.46;

  static double raduis15 = screenHeight / 56.27;
  static double raduis20 = screenHeight / 42.2;
  static double raduis30 = screenHeight / 28.13;

  //iconSize
  static double iconSize24 = screenHeight / 35.17;
  static double iconSize16 = screenHeight / 52.75;
  static double iconSize11 = screenHeight / 76.72;

  //imgsize
  static double imgSize = screenWidth / 3.25; //width = 120 pixel
  static double contentSize = screenWidth / 3.99; //width = 100
}
