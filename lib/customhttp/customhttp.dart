import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:product_category_app/models/categorymodel.dart';
import 'package:product_category_app/models/productmodel.dart';

class CustomHttpRequest {
  static Future<dynamic> products() async {
    ProductModel? productModel;
    final url = "https://e-unionint.com/api/product-by-category/7";

    try {
      final response = await http.get(
        Uri.parse(url),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        productModel = ProductModel.fromJson(data);
      }
      return productModel!;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  static Future<dynamic> categories() async {
    CategoryModel? categoryModel;
    final url = "https://e-unionint.com/api/get-categories";

    try {
      final response = await http.get(
        Uri.parse(url),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        categoryModel = CategoryModel.fromJson(data);
      }
      return categoryModel!;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
