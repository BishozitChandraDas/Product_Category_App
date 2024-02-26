import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_category_app/config/app_color.dart';
import 'package:product_category_app/pages/cart_page.dart';
import 'package:product_category_app/pages/product_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.purple,
        body: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(130.w, 50.h),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: AppColors.red),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      ProductPage.routeName,
                    );
                  },
                  child: const Text("Products")),
              SizedBox(
                height: 20.h,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(130.w, 50.h),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: AppColors.yellow),
                  onPressed: () {
                    Navigator.pushNamed(context, CartPage.routeName);
                  },
                  child: const Text("Carts")),
            ],
          ),
        ),
      ),
    );
  }
}
