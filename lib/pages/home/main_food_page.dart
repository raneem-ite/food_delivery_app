import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/models/product_model.dart';
import 'package:food_delivery/pages/home/food_page_body.dart';
import 'package:food_delivery/routes/route_header.dart';
import 'package:food_delivery/styles/app_constants.dart';
import 'package:food_delivery/styles/colors.dart';
import 'package:food_delivery/styles/dimensions.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/icon_and_text.dart';
import 'package:food_delivery/widgets/loading.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  _MainFoodPageState createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //App bar
          Container(
            margin:
                const EdgeInsets.only(top: 45, bottom: 15, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // Country + City
                  children: [
                    BigText(
                      text: "Germany",
                      color: AppColors.mainColor,
                    ),
                    //choose city
                    Row(
                      children: const [
                        SmallText(
                          text: "Berlin",
                          color: Colors.black54,
                        ),
                        Icon(Icons.arrow_drop_down_rounded)
                      ],
                    )
                  ],
                ),

                //app Icon
                Center(
                  child: Container(
                    width: Dimension.height45,
                    height: Dimension.height45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimension.raduis15),
                        color: AppColors.mainColor),
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: Dimension.iconSize24,
                    ),
                  ),
                )
              ],
            ),
          ),
          // slider for food
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const FoodPageBody(),

                  SizedBox(
                    height: Dimension.height30,
                  ),
                  //List of foods //title
                  listFoodTitle(),

                  //List of food Body
                  _showRecommendedList(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  GetBuilder<RecommendedProductController> _showRecommendedList() {
    return GetBuilder<RecommendedProductController>(
        builder: (recommendedProductList) {
      return recommendedProductList.isLoaded
          ? ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: recommendedProductList.recommendedProductsList.length,
              itemBuilder: (context, index) {
                ProductsModel productItem =
                    recommendedProductList.recommendedProductsList[index];
                return GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getRecommendedFood(index, "home"));
                  },
                  child: Container(
                    // height: 300,
                    margin: EdgeInsets.only(
                        left: Dimension.width20,
                        right: Dimension.width20,
                        bottom: Dimension.height10),
                    child: Row(
                      children: [
                        // photo
                        Container(
                          width: Dimension.imgSize,
                          height: Dimension.imgSize,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimension.raduis20),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(AppContstants.baseUrl +
                                      '/uploads/' +
                                      productItem.img!))),
                        ),

                        //list content

                        _listContent(productItem)
                      ],
                    ),
                  ),
                );
              })
          : const LoadingWidget();
    });
  }

  Expanded _listContent(ProductsModel productItem) {
    return Expanded(
      child: Container(
        // width: 100,
        height: Dimension.contentSize,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(Dimension.raduis20),
                bottomRight: Radius.circular(Dimension.raduis20)),
            color: Colors.white),
        child: Padding(
          padding: EdgeInsets.all(Dimension.width10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BigText(
                text: productItem.name!,
                size: Dimension.font20,
              ),
              SizedBox(
                height: Dimension.height30,
                child: SmallText(
                  text: productItem.description!,
                ),
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
                  // const SizedBox(width: 5),
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
            ],
          ),
        ),
      ),
    );
  }

  Container listFoodTitle() {
    return Container(
      margin: EdgeInsets.only(left: Dimension.width30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          //title
          BigText(
            text: "Recommended",
            size: Dimension.font20,
          ),
          SizedBox(width: Dimension.width10),
          Container(
            margin: const EdgeInsets.only(bottom: 5),
            child: const BigText(
              text: '.',
              color: Colors.black26,
            ),
          ),
          SizedBox(width: Dimension.width10),
          // subtitle
          Container(
            margin: const EdgeInsets.only(bottom: 3),
            child: const SmallText(
              text: "Food pairing",
            ),
          ),
        ],
      ),
    );
  }
}
