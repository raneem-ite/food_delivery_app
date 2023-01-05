import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/models/product_model.dart';
import 'package:food_delivery/pages/food/popular_food_detail.dart';
import 'package:food_delivery/routes/route_header.dart';
import 'package:food_delivery/styles/app_constants.dart';
import 'package:food_delivery/styles/colors.dart';
import 'package:food_delivery/styles/dimensions.dart';
import 'package:food_delivery/widgets/app_column.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/icon_and_text.dart';
import 'package:food_delivery/widgets/loading.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  _FoodPageBodyState createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  final PageController _pageController = PageController(viewportFraction: 0.85);
  double _currentPageValue = 0.0;
  final double _height = Dimension.pageViewConatiner;
  double _currtransform = 0;
  final double _scaleFator =
      0.8; // i want it 80% percent from its original size
  double currScale = 0.0;
  @override
  void initState() {
    super.initState();
    Get.find<PopularProductController>().getPopularProductList();
    Get.find<RecommendedProductController>().getRecommendedProductList();
    _pageController.addListener(() {
      setState(() {
        _currentPageValue = _pageController.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PopularProductController>(
      builder: (popularProducts) {
        return popularProducts.isLoaded
            ? SizedBox(
                height: Dimension.pageView,
                child: PageView.builder(
                    controller: _pageController,
                    itemCount: popularProducts.popularProductsList.length,
                    itemBuilder: (context, index) {
                      return _buildPageItem(
                          index,
                          popularProducts.popularProductsList.length,
                          popularProducts.popularProductsList[index]);
                    }),
              )
            : const LoadingWidget();
      },
    );
  }

  _buildPageItem(int index, int length, ProductsModel product) {
    // print("my height is " + MediaQuery.of(context).size.height.toString());
    Matrix4 matrix = Matrix4.identity();
    if (index == _currentPageValue.floor()) {
      currScale = 1 - (_currentPageValue - index) * (1 - _scaleFator);
      // we need to add transaction while scaling the widget

    }
    // next slide
    else if (index == _currentPageValue.floor() + 1) {
      currScale =
          _scaleFator + (_currentPageValue - index + 1) * (1 - _scaleFator);
    }
    // previous  slide
    else if (index == _currentPageValue.floor() - 1) {
      // currScale =
      //     _scaleFator - (_currentPageValue - index - 1) * (1 - _scaleFator);
      currScale = 1 - (_currentPageValue - index) * (1 - _scaleFator);
    } else {
      currScale = 0.8;
    }
    _currtransform = _height * (1 - currScale) / 2;
    matrix = Matrix4.diagonal3Values(1, currScale, 1)
      ..setTranslationRaw(0, _currtransform, 0);
    return Transform(
      transform: matrix,
      child: Stack(children: [
        // image food
        GestureDetector(
          onTap: () {
            Get.toNamed(RouteHelper.getPopularFood(index, "home"));
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            height: _height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimension.raduis30),
                image: DecorationImage(
                    image: NetworkImage(
                        AppContstants.baseUrl + '/uploads/' + product.img!),
                    fit: BoxFit.cover),
                color: const Color(0xFF69c5df)),
          ),
        ),

        // text food
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: Dimension.height30, vertical: Dimension.width20),
            padding: EdgeInsets.all(Dimension.padding15),
            // width: 200,
            height: Dimension.pageViewTextConatiner,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimension.raduis30),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                      color: Color(0xFFe8e8e8),
                      blurRadius: 5.0,
                      offset: Offset(0, 5)),
                  BoxShadow(
                      color: Colors.white,
                      // blurRadius: 5.0,
                      offset: Offset(-5, 0)),
                  BoxShadow(
                      color: Colors.white,
                      // blurRadius: 5.0,
                      offset: Offset(5, 0)),
                ]),
            child: _sliderContent(product),
          ),
        ),

        //dot indicator
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            child: Wrap(
              children: List.generate(
                  length,
                  (indexIndicator) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        width: index == indexIndicator ? 15 : 7,
                        height: 7,
                        decoration: BoxDecoration(
                            color: index == indexIndicator
                                ? AppColors.mainColor
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(25)),
                      )),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _sliderContent(ProductsModel product) {
    return Padding(
      padding: EdgeInsets.all(Dimension.width10 / 2),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // top
          children: [
            BigText(
              text: product.name!,
              size: Dimension.font20,
              // color: Colors.black54,
            ),

            //text 2
            Row(
              children: [
                // stars
                Wrap(
                  children: List.generate(
                      5,
                      (indexStar) => Icon(
                            Icons.star,
                            color: indexStar < product.stars!
                                ? AppColors.mainColor
                                : Colors.grey,
                            size: Dimension.font16,
                          )),
                ),
                const SizedBox(width: 10),
                // text
                SmallText(
                  text: product.stars!.toString(),
                  size: Dimension.font14,
                ),
                const SizedBox(width: 10),
                //comment
                SmallText(text: "1287 comments", size: Dimension.font14),
              ],
            ),

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

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
}
