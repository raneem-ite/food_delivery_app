import 'package:food_delivery/models/product_model.dart';

class CartModel {
  int? id;
  String? name;
  int? quantity;
  bool? isExist;
  String? time;
  int? price;
  String? img;
  ProductsModel? product;

  CartModel(
      {this.id,
      this.name,
      this.price,
      this.img,
      this.isExist,
      this.quantity,
      this.product,
      this.time});

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isExist = json['isExist'];
    price = json['price'];
    quantity = json['quantity'];
    img = json['img'];
    time = json['time'];
    product = ProductsModel.fromJson(json['product']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['img'] = img;
    return data;
  }
}
