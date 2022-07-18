import 'package:backend_getx/controller/product_controller.dart';
import 'package:backend_getx/models/product_models.dart';
import 'package:backend_getx/screen/new_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({Key? key}) : super(key: key);

  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Product'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            InkWell(
              child: SizedBox(
                height: 100,
                child: Card(
                  margin: EdgeInsets.zero,
                  color: Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: const [
                        Icon(Icons.add_circle, color: Colors.white),
                        SizedBox(width: 15),
                        Text(
                          'Add a New Product',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              onTap: () {
                Get.to(() => NewProductScreen());
              },
            ),
            Expanded(
                child: Obx(
              () => ListView.builder(
                itemCount: productController.products.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 235,
                    child: ProductCard(
                      product: productController.products[index],
                      index: index,
                    ),
                  );
                },
              ),
            ))
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final int index;

  ProductCard({super.key, required this.product, required this.index});

  final ProductController productController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.only(top: 10),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                product.description,
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  SizedBox(
                    height: 80,
                    width: 80,
                    child: Image.network(product.imageUrl, fit: BoxFit.cover),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 40,
                              child: Text(
                                'Price',
                                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              width: 175,
                              child: Slider(
                                value: product.price,
                                min: 0,
                                max: 25,
                                divisions: 10,
                                activeColor: Colors.black,
                                inactiveColor: Colors.black12,
                                onChanged: (value) {
                                  productController.updateProductPrice(index, product, value);
                                },
                                onChangeEnd: (value) {
                                  productController.saveNewProductPrice(product, 'price', value);
                                },
                              ),
                            ),
                            Text(
                              product.price.toStringAsFixed(1),
                              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 40,
                              child: Text(
                                'Qty',
                                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              width: 175,
                              child: Slider(
                                value: product.quantity.toDouble(),
                                min: 0,
                                max: 100,
                                divisions: 10,
                                activeColor: Colors.black,
                                inactiveColor: Colors.black12,
                                onChanged: (value) {
                                  productController.updateProductQuantity(index, product, value.toInt());
                                },
                                onChangeEnd: (value) {
                                  productController.saveNewProductQuantity(product, 'quantity', value.toInt());
                                },
                              ),
                            ),
                            Text(
                              '${product.quantity.toInt()}',
                              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
