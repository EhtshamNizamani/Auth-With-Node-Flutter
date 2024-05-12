import 'package:auth_with_nodejs/model/product.dart';
import 'package:auth_with_nodejs/services/http/http_services.dart';
import 'package:auth_with_nodejs/services/shared_preff/shared_preff_services.dart';

class ProductServices {
  Future<List<ProductModel>> getAllProducts() async {
    const apiUrl = 'api/product';

    try {
      final response = await HttpServices().get(
        apiUrl: apiUrl,
        headers: HttpServices.headerWithAccessToken(
            await SharePreServices.getAccessToken() ?? ''),
      );
      List<ProductModel> products = [];

      for (dynamic data in response['data']) {
        products.add(ProductModel.fromJson(data));
      }

      return products;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> editProduct(ProductModel product) async {
    final apiUrl = 'api/product/${product.id}';
    print(apiUrl);
    try {
      final response = await HttpServices().patch(
          apiUrl: apiUrl,
          headers: HttpServices.headerWithAccessToken(
              await SharePreServices.getAccessToken() ?? ''),
          body: product.toMap());
      // List<ProductModel> products = [];

      // for (dynamic data in response['data']) {
      //   products.add(ProductModel.fromJson(data));
      // }
      print(response);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> deleteProduct(String id) async {
    final apiUrl = 'api/product/$id';
    try {
      final response = await HttpServices().delete(
        apiUrl: apiUrl,
        headers: HttpServices.headerWithAccessToken(
            await SharePreServices.getAccessToken() ?? ''),
      );

      print(response);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> createProduct(ProductModel productModel) async {
    final apiUrl = 'api/product';
    try {
      final response = await HttpServices().post(
          apiUrl: apiUrl,
          headers: HttpServices.headerWithAccessToken(
              await SharePreServices.getAccessToken() ?? ''),
          body: productModel.toMap());

      print(response);

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
