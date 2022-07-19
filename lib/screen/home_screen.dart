import 'package:backend_getx/screen/orders_screen.dart';
import 'package:backend_getx/screen/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My eCommerce'),
        backgroundColor: Colors.black,
      ),
      body: SizedBox(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            height: 150,
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: InkWell(
              onTap: () {
                Get.to(() => ProductScreen());
              },
              child: const Card(
                child: Center(child: Text('Go To Products')),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 150,
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: InkWell(
              onTap: () {
                Get.to(() => const OrdersScreen());
              },
              child: const Card(
                child: Center(child: Text('Go To Orders')),
              ),
            ),
          )
        ],
      )),
    );
  }
}
