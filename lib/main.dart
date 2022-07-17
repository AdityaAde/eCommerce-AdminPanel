import 'package:backend_getx/screen/home_screen.dart';
import 'package:backend_getx/screen/new_product_screen.dart';
import 'package:backend_getx/screen/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: const HomeScreen(),
      getPages: [
        GetPage(name: '/products', page: () => ProductScreen()),
        GetPage(name: '/products/new', page: () => NewProductScreen()),
      ],
    );
  }
}
