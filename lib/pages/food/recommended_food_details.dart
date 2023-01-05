import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/models/product_model.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/routes/route_header.dart';
import 'package:food_delivery/styles/app_constants.dart';
import 'package:food_delivery/styles/colors.dart';
import 'package:food_delivery/styles/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/expandable_text.dart';
import 'package:get/get.dart';

class RecommendedFoodDetails extends StatefulWidget {
  final int pageId;
  final String backPage;
  const RecommendedFoodDetails(
      {Key? key, required this.pageId, required this.backPage})
      : super(key: key);

  @override
  State<RecommendedFoodDetails> createState() => _RecommendedFoodDetailsState();
}

class _RecommendedFoodDetailsState extends State<RecommendedFoodDetails> {
  late ProductsModel product;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    product = Get.find<RecommendedProductController>()
        .recommendedProductsList[widget.pageId];
    Get.find<PopularProductController>()
        .initialQuantityProduct(product, Get.find<CartController>());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    if (widget.backPage == "cartpage") {
                      Get.toNamed(RouteHelper.getcart());
                    } else {
                      Get.toNamed(RouteHelper.getInitial());
                    }
                  },
                  child: AppIcon(
                    icon: Icons.clear,
                    iconSize: Dimension.iconSize16,
                  ),
                ),
                const Spacer(),
                GetBuilder<PopularProductController>(builder: (controller) {
                  return InkWell(
                    // onTap: () => Get.to(() => const CartPage()),
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
                                right: 3, //it equal ~ 3
                                top: 3,
                                child: BigText(
                                  text: controller.totalItems.toString(),
                                  size: Dimension.iconSize11,
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
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(Dimension.height20),
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimension.raduis20),
                        topRight: Radius.circular(Dimension.raduis20)),
                  ),
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(vertical: Dimension.height10 / 2),
                  child: Center(
                      child: BigText(
                    text: product.name!,
                    size: Dimension.font26,
                  ))),
            ),
            pinned: true,
            backgroundColor: AppColors.mainColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppContstants.baseUrl + '/uploads/' + product.img!,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(Dimension.width10),
              child: ExpandedText(text: product.description!),
            ),
          )
        ],
      ),
      bottomNavigationBar:
          GetBuilder<PopularProductController>(builder: (controller) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //// rasing sectoin

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dimension.width20 * 2.5,
                vertical: Dimension.height10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //minus
                  GestureDetector(
                    onTap: () {
                      controller.setQuantity(false);
                    },
                    child: AppIcon(
                        icon: Icons.remove,
                        backgroundColor: AppColors.mainColor,
                        iconSize: Dimension.iconSize24,
                        iconColor: Colors.white),
                  ),
                  BigText(
                      text: "\$${product.price!}  X  ${controller.inCartItems}",
                      color: AppColors.mainBlackColor,
                      size: Dimension.font26),
                  GestureDetector(
                    onTap: () {
                      controller.setQuantity(true);
                    },
                    child: AppIcon(
                        icon: Icons.add,
                        backgroundColor: AppColors.mainColor,
                        iconSize: Dimension.iconSize24,
                        iconColor: Colors.white),
                  )
                ],
              ),
            ),

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
                      child: Icon(
                        Icons.favorite,
                        color: AppColors.mainColor,
                        size: Dimension.font26,
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
                            text: "\$${product.price} | add to cart",
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
}
