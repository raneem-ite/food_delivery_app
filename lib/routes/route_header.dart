import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/pages/food/popular_food_detail.dart';
import 'package:food_delivery/pages/food/recommended_food_details.dart';
import 'package:food_delivery/pages/home/home_page.dart';
import 'package:get/route_manager.dart';

class RouteHelper {
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cart = "/cart";

  static String getInitial() => initial;
  static String getPopularFood(int pageId, String pageName) =>
      '$popularFood?pageId=$pageId&page=$pageName';
  static String getRecommendedFood(int pageId, String pageName) =>
      '$recommendedFood?pageId=$pageId&page=$pageName';

  static String getcart() => cart;
  static List<GetPage> routes = [
    GetPage(name: initial, page: () => const HomePage()),
    GetPage(
        name: popularFood,
        page: () {
          int pageId = int.parse(Get.parameters['pageId']!);
          String pageName = Get.parameters['page']!;
          return PopularFoodDetail(pageId: pageId, backPage: pageName);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: recommendedFood,
        page: () {
          int pageId = int.parse(Get.parameters['pageId']!);
          String pageName = Get.parameters['page']!;
          return RecommendedFoodDetails(pageId: pageId, backPage: pageName);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: cart,
        page: () => const CartPage(),
        transition: Transition.fadeIn),
  ];
}
