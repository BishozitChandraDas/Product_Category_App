import 'package:flutter/material.dart';
import 'package:product_category_app/config/app_color.dart';
import 'package:product_category_app/models/categorymodel.dart';
import 'package:product_category_app/provider/product_provider.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  static const String routeName = '/cart_page';
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.purple,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.yellow,
          title: const Text('Carts'),
        ),
        body: ListView.builder(
          itemCount: productProvider.cartProducts.length,
          itemBuilder: (context, index) {
            final product = productProvider.cartProducts[index];
            final category = productProvider.categoryModel!.data!.firstWhere(
              (cat) => cat.id == product.id,
              orElse: () => Data(id: 0, categoryName: 'Unknown Category'),
            );
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                  tileColor: AppColors.yellow,
                  title: Text(product.productName ?? ''),
                  subtitle: Text("${category.categoryName}"),
                  trailing: GestureDetector(
                    onTap: () {
                      productProvider.cartProducts.remove(product);
                      setState(() {});
                    },
                    child: const Icon(
                      Icons.delete,
                      color: AppColors.purple,
                      size: 50,
                    ),
                  )),
              // Add any other details you want to display
            );
          },
        ),
      ),
    );
  }
}
