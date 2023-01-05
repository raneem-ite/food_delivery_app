import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/routes/route_header.dart';
import 'package:food_delivery/styles/app_constants.dart';
import 'package:food_delivery/styles/colors.dart';
import 'package:food_delivery/styles/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //top icons
          Positioned(
              left: Dimension.width20,
              right: Dimension.width20,
              top: Dimension.height20 * 3,
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Get.toNamed(RouteHelper.getInitial()),
                    child: AppIcon(
                      icon: Icons.arrow_back_ios,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: Dimension.iconSize24,
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () => Get.toNamed(RouteHelper.getInitial()),
                    child: AppIcon(
                      icon: Icons.home_outlined,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: Dimension.iconSize24,
                    ),
                  ),
                  SizedBox(
                    width: Dimension.width10,
                  ),
                  AppIcon(
                    icon: Icons.shopping_cart_outlined,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimension.iconSize24,
                  )
                ],
              )),
          Positioned(
            top: Dimension.height20 * 6,
            left: Dimension.width20,
            right: Dimension.width20,
            bottom: 0,
            child: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: GetBuilder<CartController>(builder: (controller) {
                return ListView.builder(
                    itemCount: controller.cartItems.length,
                    itemBuilder: (context, index) {
                      CartModel cartItem = controller.cartItems[index];
                      return cartItemWidget(cartItem);
                    });
              }),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(builder: (controller) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ///add to cart section
            Container(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimension.width20,
                    vertical: Dimension.height30),
                height: Dimension.pageViewTextConatiner + 10,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: AppColors.buttonBackgroundColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimension.raduis30),
                        topRight: Radius.circular(Dimension.raduis30))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //adding
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimension.width20,
                          vertical: Dimension.height20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(Dimension.raduis20),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: Dimension.width10 / 2),
                          GetBuilder<PopularProductController>(
                              builder: (popularproduct) {
                            return BigText(
                                text: "\$" +
                                    controller.getTotalAmount.toString());
                          }),
                          SizedBox(width: Dimension.width10 / 2),
                        ],
                      ),
                    ),

                    ///buton
                    GestureDetector(
                      onTap: () {
                        // controller.addItem(product);
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimension.width20,
                              vertical: Dimension.height20),
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(Dimension.raduis20),
                            ),
                          ),
                          child: const BigText(
                            text: "Check out",
                            color: Colors.white,
                          )),
                    ),
                  ],
                )),
          ],
        );
      }),
    );
  }

  Container cartItemWidget(CartModel cartItem) {
    return Container(
      margin: EdgeInsets.only(bottom: Dimension.height10),
      padding: EdgeInsets.symmetric(horizontal: Dimension.height10),
      height: Dimension.listItemHeight,
      width: double.infinity,
      child: Row(
        children: [
          //phtoto
          GestureDetector(
            onTap: () {
              int productIndex = Get.find<PopularProductController>()
                  .popularProductsList
                  .indexOf(cartItem.product!);
              print("index is $productIndex and name ${cartItem.product!.name}" +
                  " and the list ${Get.find<PopularProductController>().popularProductsList[0].name}" +
                  " and cart prod is ${cartItem.name}" +
                  "another function ${Get.find<PopularProductController>().popularProductsList.indexWhere((element) => element == cartItem.product)}" +
                  " function ${Get.find<PopularProductController>().popularProductsList.indexOf(cartItem.product!)}");
              if (productIndex >= 0) {
                print("index is $productIndex");
                Get.toNamed(
                    RouteHelper.getPopularFood(productIndex, 'cartpage'));
              } else {
                int recProduct = Get.find<RecommendedProductController>()
                    .recommendedProductsList
                    .indexOf(cartItem.product!);

                recProduct >= 0
                    ? Get.toNamed(
                        RouteHelper.getRecommendedFood(recProduct, 'cartpage'))
                    : {};
              }
            },
            child: Container(
              width: Dimension.height20 * 5,
              height: Dimension.height20 * 5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimension.raduis20),
                  image: DecorationImage(
                      image: NetworkImage(
                        AppContstants.baseUrl + '/uploads/' + cartItem.img!,
                      ),
                      fit: BoxFit.cover)),
            ),
          ),
          SizedBox(
            width: Dimension.width10,
          ),
          // listtile content
          Expanded(
              child: Container(
            height: Dimension.height20 * 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //title
                BigText(text: cartItem.name!, color: Colors.black45),
                //type
                SmallText(text: "Spicy"),
                //actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BigText(
                        text: "\$ ${cartItem.price}", color: Colors.redAccent),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimension.width20,
                          vertical: Dimension.height10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(Dimension.raduis20),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                              onTap: () => Get.find<CartController>()
                                  .addItem(cartItem.product!, -1),
                              child: Icon(Icons.remove,
                                  color: AppColors.signColor)),
                          SizedBox(width: Dimension.width10 / 2),
                          BigText(text: "${cartItem.quantity!}"),
                          SizedBox(width: Dimension.width10 / 2),
                          InkWell(
                              onTap: () => Get.find<CartController>()
                                  .addItem(cartItem.product!, 1),
                              child:
                                  Icon(Icons.add, color: AppColors.signColor)),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          )),
        ],
      ),
    );
  }
}
