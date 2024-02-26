import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:product_category_app/config/app_color.dart';
import 'package:product_category_app/models/categorymodel.dart';
import 'package:product_category_app/provider/product_provider.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  static const String routeName = '/product_page';
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  late ProductProvider productProvider;
  late List<bool> _isSelected;
  @override
  void didChangeDependencies() {
    productProvider = Provider.of<ProductProvider>(context);
    setState(() {
      productProvider.getData();
      _isSelected = _isSelected =
          List.filled(productProvider.categoryModel?.data?.length ?? 0, false);
    });
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _isSelected = [];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.purple,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.yellow,
        title: const Text("Products"),
      ),
      body: productProvider.hasDataLoaded
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: productProvider.productModel!.data!.length,
              itemBuilder: (context, index) {
                final product = productProvider.productModel!.data![index];
                final category =
                    productProvider.categoryModel!.data!.firstWhere(
                  (cat) => cat.id == product.id,
                  orElse: () => Data(id: 0, categoryName: 'Unknown Category'),
                );
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: ListTile(
                      tileColor: AppColors.yellow,
                      title: Text("${product.productName}"),
                      subtitle: Text("${category.categoryName}"),
                      trailing: GestureDetector(
                        onTap: () {
                          productProvider.toggleCart(product);
                        },
                        child: Icon(
                          productProvider.isProductInCart(product)
                              ? Icons.remove
                              : Icons.add,
                          color: AppColors.purple,
                          size: 50,
                        ),
                      )),
                );
              },
            )
          : const Center(
              child: SpinKitFadingCircle(
                color: Colors.greenAccent,
              ),
            ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.yellow,
          onPressed: () {
            _showDialog(context);
          },
          child: Image.asset("images/cat.jpg")),
    ));
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: const EdgeInsets.all(0),
          backgroundColor: AppColors.purple,
          title: Container(
            height: 60.h,
            color: AppColors.yellow, // Yellow header color
            child: const Center(
              child: Text(
                'Categories',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: List.generate(
                productProvider.categoryModel!.data!.length,
                (index) {
                  final category = productProvider.categoryModel!.data![index];
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _isSelected = List.filled(
                            productProvider.categoryModel!.data!.length, false);
                        _isSelected[index] = true;
                      });
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.red),
                            color: _isSelected[index]
                                ? AppColors.red
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                          title: Text(
                            category.categoryName ?? '',
                            style: TextStyle(
                              color: _isSelected[index]
                                  ? AppColors.purple
                                  : AppColors.red,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
