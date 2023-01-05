import 'package:food_delivery/data/api/api_client.dart';
import 'package:food_delivery/styles/app_constants.dart';
import 'package:get/get_connect.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class PopularProductRepo extends GetxService {
  final ApiClient apiClient;

  PopularProductRepo({required this.apiClient});

  Future<Response> getPopularProductList() async {
    return await apiClient.getData(AppContstants.popularProductsUri);
  }
}
