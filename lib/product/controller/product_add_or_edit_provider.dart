import 'package:auth_with_nodejs/home/view/home_page.dart';
import 'package:auth_with_nodejs/model/product.dart';
import 'package:auth_with_nodejs/services/product/product.dart';
import 'package:auth_with_nodejs/services/toast_message/toast.dart';
import 'package:flutter/material.dart';

class ProductAddOrEditProvider extends ChangeNotifier {
  bool isLoading = false;
  final formKey = GlobalKey<FormState>(); // Form key for validation

  void updateProduct(context, ProductModel product) async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    formKey.currentState!.save();

    // Create or update the product based on form data
    final updatedProduct = product;
    try {
      print(updatedProduct.description);
      isLoading = true;
      notifyListeners();
      await ProductServices().editProduct(updatedProduct);
      CustomToast().showSnackbar(context, 'Product updated successfully',
          Colors.greenAccent, Colors.black12);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const HomePage()),
          (route) => false);
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
      isLoading = false;
      notifyListeners();
    }
  }

  void create(BuildContext context, ProductModel product) async {
    print(product.description);
    try {
      final isValid = formKey.currentState!.validate();
      if (!isValid) {
        return;
      }
      formKey.currentState!.save();

      // Create or update the product based on form data
      final updatedProduct = product;
      isLoading = true;
      notifyListeners();
      await ProductServices().createProduct(updatedProduct);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const HomePage()),
          (route) => false);
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e.toString());
      isLoading = false;
      notifyListeners();
    }
  }
}
