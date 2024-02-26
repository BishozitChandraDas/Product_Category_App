import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:product_category_app/customhttp/customhttp.dart';
import 'package:product_category_app/models/categorymodel.dart';
import 'package:product_category_app/models/productmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductProvider with ChangeNotifier {
  ProductModel? productModel;
  CategoryModel? categoryModel;
  List<ProductData> cartProducts = [];
  getData() {
    _products();
    _categories();
  }

  bool get hasDataLoaded => productModel != null && categoryModel != null;
  _products() async {
    productModel = await CustomHttpRequest.products();
    notifyListeners();
    return productModel!;
  }

  _categories() async {
    categoryModel = await CustomHttpRequest.categories();
    notifyListeners();
    return categoryModel!;
  }

  Future<void> loadCartProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = prefs.getStringList('cartProducts');
    if (cartJson != null) {
      cartProducts = cartJson
          .map((jsonString) => ProductData.fromJson(json.decode(jsonString)))
          .toList();
      notifyListeners();
    }
  }

  bool isProductInCart(ProductData product) {
    return cartProducts.any((item) => item.id == product.id);
  }

  void toggleCart(ProductData product) async {
    if (isProductInCart(product)) {
      cartProducts.removeWhere((item) => item.id == product.id);
    } else {
      cartProducts.add(product);
    }
    await _saveCartProducts();
    notifyListeners();
  }

  Future<void> _saveCartProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson =
        cartProducts.map((item) => json.encode(item.toJson())).toList();
    prefs.setStringList('cartProducts', cartJson);
  }
}
