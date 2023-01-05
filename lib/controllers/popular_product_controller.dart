import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/data/repository/popluar_product_repo.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/models/product_model.dart';
import 'package:food_delivery/styles/colors.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;

  PopularProductController({required this.popularProductRepo});

  late List<dynamic> _popularProductsList;
  bool _isLoaded = false;
  int _quantity = 0;
  int _inCartItems = 0;
  late CartController _cart;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      _popularProductsList = []; // do not repeat the data
      _popularProductsList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    } else {}
  }

  void setQuantity(bool isIncrement) {
    // increase the quantity
    if (isIncrement) {
      // check to not increase the quanitiy more than the ones in the stock
      _quantity = checkQuantity(quantity + 1);
    } else {
      // to not get the quantity from less than 0
      _quantity = checkQuantity(quantity - 1);
    }

    update();
  }

  int checkQuantity(int quantity) {
    // just for demo purpose
    int stockQuantity = 20;
    if (_inCartItems + quantity < 0) {
      Get.snackbar("item count", "you can't reduce more",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);

      if (_inCartItems > 0) {
        _quantity = _inCartItems;
        return _quantity;
      }
      return 0;
    } else if (_inCartItems + quantity > stockQuantity) {
      Get.snackbar("item count", "you can't add more than in the stock",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
      return stockQuantity;
    } else {
      return quantity;
    }
  }

  void initialQuantityProduct(ProductsModel product, CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    // if exist item in storage
    // get from storage _inCartItem = 3
    if (_cart.existInCart(product)) {
      _inCartItems = _cart.getQuantity(product);
    }
  }

  void addItem(ProductsModel products) {
    _cart.addItem(products, _quantity);
    _quantity = 0;
    _inCartItems = _cart.getQuantity(products);
    update();
  }

  List<dynamic> get popularProductsList => _popularProductsList;
  bool get isLoaded => _isLoaded;
  int get quantity => _quantity;
  int get inCartItems => _inCartItems + _quantity;
  int get totalItems => _cart.totalItems;
  List<CartModel> get cartItems => _cart.cartItems;
}
