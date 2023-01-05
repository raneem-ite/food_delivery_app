import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/models/product_model.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/routes/route_header.dart';
import 'package:food_delivery/styles/app_constants.dart';
import 'package:food_delivery/styles/colors.dart';
import 'package:food_delivery/styles/dimensions.dart';
import 'package:food_delivery/widgets/app_column.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/expandable_text.dart';
import 'package:get/get.dart';

class PopularFoodDetail extends StatefulWidget {
  final int pageId;
  final String backPage;
  const PopularFoodDetail(
      {Key? key, required this.pageId, required this.backPage})
      : super(key: key);

  @override
  _PopularFoodDetailState createState() => _PopularFoodDetailState();
}

class _PopularFoodDetailState extends State<PopularFoodDetail> {
  late ProductsModel product;
  var controller = Get.find<PopularProductController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    product =
        Get.find<PopularProductController>().popularProductsList[widget.pageId];
    Get.find<PopularProductController>()
        .initialQuantityProduct(product, Get.find<CartController>());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
          width: double.maxFinite,
          height: double.maxFinite,
          child: Stack(
            children: [
              // background image
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.4,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          AppContstants.baseUrl + '/uploads/' + product.img!),
                    ),
                  ),
                ),
              ),
              //menu button
              Positioned(
                left: Dimension.width20,
                right: Dimension.width20,
                top: Dimension.height45,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (widget.backPage == 'cartpage') {
                          Get.toNamed(RouteHelper.getcart());
                        } else {
                          Get.toNamed(RouteHelper.getInitial());
                        }
                      },
                      child: AppIcon(
                        icon: Icons.arrow_back_ios,
                        iconSize: Dimension.iconSize16,
                      ),
                    ),
                    const Spacer(),
                    // cart button icon
                    GetBuilder<PopularProductController>(builder: (context) {
                      return InkWell(
                        onTap: () => Get.toNamed(RouteHelper.getcart()),
                        child: Stack(
                          children: [
                            //icon
                            AppIcon(
                              icon: Icons.shopping_cart_outlined,
                              iconSize: Dimension.iconSize16,
                            ),
                            // number of items in cart
                            controller.totalItems > 0
                                ? Positioned(
                                    right: 0,
                                    top: 0,
                                    child: AppIcon(
                                      icon: Icons.circle,
                                      size: Dimension.iconSize16,
                                      iconColor: Colors.transparent,
                                      backgroundColor: AppColors.mainColor,
                                    ),
                                  )
                                : Container(),

                            controller.totalItems > 0
                                ? Positioned(
                                    right: 3,
                                    top: 3,
                                    child: BigText(
                                      text: controller.totalItems.toString(),
                                      size: 11,
                                      color: Colors.white,
                                    ),
                                  )
                                : Container()
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),

              //card details
              Positioned(
                top: MediaQuery.of(context).size.height * 0.33,
                bottom: Dimension.pageViewTextConatiner + Dimension.height15,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.65,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Dimension.raduis20),
                          topRight: Radius.circular(Dimension.raduis20))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppColumn(
                        text: product.name!,
                      ),
                      SizedBox(
                        height: Dimension.height20,
                      ),
                      //desc
                      //1- desc title
                      Padding(
                        padding: EdgeInsets.only(left: Dimension.width20),
                        child: BigText(
                          text: "Introduce",
                          size: Dimension.font20,
                        ),
                      ),
                      SizedBox(
                        height: Dimension.height15,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.only(left: Dimension.width20),
                            child: ExpandedText(text: product.description!),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // actions for the details page
              Positioned(
                bottom: 0,
                // left: 20,
                // right: 20,
                child: Container(
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
                              InkWell(
                                  onTap: () {
                                    controller.setQuantity(false);
                                  },
                                  child: Icon(Icons.remove,
                                      color: AppColors.signColor)),
                              SizedBox(width: Dimension.width10 / 2),
                              GetBuilder<PopularProductController>(
                                  builder: (popularproduct) {
                                return BigText(
                                    text: controller.inCartItems.toString());
                              }),
                              SizedBox(width: Dimension.width10 / 2),
                              InkWell(
                                  onTap: () {
                                    controller.setQuantity(true);
                                  },
                                  child: Icon(Icons.add,
                                      color: AppColors.signColor)),
                            ],
                          ),
                        ),

                        ///buton
                        GestureDetector(
                          onTap: () {
                            controller.addItem(product);
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
                              child: BigText(
                                text:
                                    "\$${controller.quantity > 0 ? product.price! * controller.quantity : product.price!} | add to cart",
                                color: Colors.white,
                              )),
                        ),
                      ],
                    )),
              ),
            ],
          )),
    );
  }
}
