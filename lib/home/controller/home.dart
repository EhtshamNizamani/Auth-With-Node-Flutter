import 'package:auth_with_nodejs/model/product.dart';
import 'package:auth_with_nodejs/services/product/product.dart';
import 'package:auth_with_nodejs/services/toast_message/toast.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  List<ProductModel> products = [];
  bool _isLogin = true;
  bool get isLogin => _isLogin;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void getAllProducts(BuildContext context) async {
    _isLoading = true;
    products = [];

    try {
      products = await ProductServices().getAllProducts();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e.toString());
      String errorMessage = e.toString().split(": ")[1];
      CustomToast()
          .showSnackbar(context, errorMessage, Colors.red, Colors.white);
      print(e);
      _isLoading = false;
      notifyListeners();
    }
  }

  void deleteProduct(BuildContext context, String id) async {
    _isLoading = true;
    products.removeWhere((element) => element.id == id);
    print(products);
    try {
      await ProductServices().deleteProduct(id);
      getAllProducts(context);
      CustomToast().showSnackbar(context, 'Product deleted successfully',
          Colors.greenAccent, Colors.black12);

      _isLoading = false;

      notifyListeners();
    } catch (e) {
      print(e.toString());
      String errorMessage = e.toString().split(": ")[1];
      CustomToast()
          .showSnackbar(context, errorMessage, Colors.red, Colors.white);
      print(e);
      _isLoading = false;
      notifyListeners();
    }
  }
}
