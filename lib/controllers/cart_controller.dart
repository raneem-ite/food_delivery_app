import 'package:flutter/material.dart';
import 'package:food_delivery/data/repository/cart_repo.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/models/product_model.dart';
import 'package:food_delivery/styles/colors.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};

  void addItem(ProductsModel product, int quantity) {
    int totalQuantity = 0;
    //to check if the product exist in map or not
    if (_items.containsKey(product.id)) {
      _items.update(product.id!, (value) {
        totalQuantity = value.quantity! + quantity;

        return CartModel(
            id: value.id,
            img: value.img,
            name: value.name,
            price: value.price,
            quantity: (value.quantity! + quantity),
            isExist: value.isExist,
            product: product,
            time: value.time);
      });
      if (totalQuantity <= 0) {
        _items.remove(product.id);
      }
    } else {
      //to check if the user add quanitity
      if (quantity > 0) {
        // if the key doesn't match => it will create a new item with new key
        // and add it to map
        _items.putIfAbsent(
            product.id!,
            () => CartModel(
                id: product.id,
                img: product.img,
                name: product.name,
                price: product.price,
                quantity: quantity,
                product: product,
                isExist: true,
                time: DateTime.now().toString()));
      } else {
        Get.snackbar(
            "item count", "you should at least add one item to the cart",
            backgroundColor: AppColors.mainColor, colorText: Colors.white);
      }
    }
    update();
  }

  bool existInCart(ProductsModel product) => _items.containsKey(product.id);

  int getQuantity(ProductsModel product) {
    int quantity = 0;
    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems {
    int totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });

    return totalQuantity;
  }

  int get getTotalAmount {
    int totalAmount = 0;
    _items.forEach((key, value) {
      totalAmount += value.quantity! * value.price!;
    });

    return totalAmount;
  }

  Map<int, CartModel> get items => _items;
  List<CartModel> get cartItems => _items.values.toList();
}
