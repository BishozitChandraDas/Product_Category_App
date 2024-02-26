import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_category_app/config/app_color.dart';
import 'package:product_category_app/pages/cart_page.dart';
import 'package:product_category_app/pages/home_page.dart';
import 'package:product_category_app/pages/product_page.dart';
import 'package:product_category_app/provider/product_provider.dart';

import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => ProductProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(415, 860),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            theme: ThemeData(appBarTheme: const AppBarTheme(color: AppColors.red)),
            debugShowCheckedModeBanner: false,
            home: const HomePage(),
            // home: SplashScreenPage(),
            routes: {
              ProductPage.routeName: (context) => const ProductPage(),
              CartPage.routeName: (context) => const CartPage(),
            },
          );
        });
  }
}
