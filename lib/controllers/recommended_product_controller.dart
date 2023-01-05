import 'package:food_delivery/data/repository/recommended_product_repo.dart';
import 'package:food_delivery/models/product_model.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;

  RecommendedProductController({required this.recommendedProductRepo});

  List<dynamic> _recommendedProductsList = [];
  bool _isLoaded = false;

  Future<void> getRecommendedProductList() async {
    Response response =
        await recommendedProductRepo.getRecommendedProductList();
    if (response.statusCode == 200) {
      // _recommendedProductsList = []; // do not repeat the data
      _recommendedProductsList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    } else {}
  }

  List<dynamic> get recommendedProductsList => _recommendedProductsList;
  bool get isLoaded => _isLoaded;
}
