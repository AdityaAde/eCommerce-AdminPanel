import 'package:backend_getx/controller/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class NewProductScreen extends StatelessWidget {
  NewProductScreen({Key? key}) : super(key: key);

  final ProductController productController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a Product'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
                child: Card(
                  margin: EdgeInsets.zero,
                  color: Colors.black,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          // ignore: no_leading_underscores_for_local_identifiers
                          ImagePicker _picker = ImagePicker();
                          // ignore: no_leading_underscores_for_local_identifiers
                          final XFile? _image = await _picker.pickImage(source: ImageSource.gallery);

                          if (_image == null) {
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text('No image was selected'),
                            ));
                          }
                        },
                        icon: const Icon(
                          Icons.add_circle,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        'Add an Image',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Product Information',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              _buildTextformField('Product ID', 'id', productController),
              _buildTextformField('Product Name', 'name', productController),
              _buildTextformField('Product Description', 'description', productController),
              _buildTextformField('Product Category', 'category', productController),
              const SizedBox(height: 10),
              _buildSlider('Price', 'price', productController, productController.price),
              _buildSlider('Quantity', 'quantity', productController, productController.quantity),
              const SizedBox(height: 10),
              _buildCheckbox('Recommended', 'isRecommended', productController, productController.isRecommended),
              _buildCheckbox('Popular', 'isPopular', productController, productController.isPopular),
              Center(
                  child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.black),
                onPressed: () {
                  print(productController.newProduct);
                },
                child: const Text('Save'),
              )),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField _buildTextformField(
    String hintText,
    String name,
    ProductController productController,
  ) {
    return TextFormField(
      decoration: InputDecoration(hintText: hintText),
      onChanged: (value) {
        productController.newProduct.update(name, (_) => value, ifAbsent: () => value);
      },
    );
  }

  Row _buildSlider(
    String title,
    String name,
    ProductController productController,
    double? controllerValue,
  ) {
    return Row(
      children: [
        SizedBox(
          width: 75,
          child: Text(
            title,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Slider(
            // ignore: prefer_if_null_operators
            value: (controllerValue == null) ? 0 : controllerValue,
            min: 0,
            max: 25,
            divisions: 10,
            activeColor: Colors.black,
            inactiveColor: Colors.black12,
            onChanged: (value) {
              productController.newProduct.update(name, (_) => value, ifAbsent: () => value);
            },
          ),
        ),
      ],
    );
  }

  Row _buildCheckbox(
    String title,
    String name,
    ProductController productController,
    bool? controllerValue,
  ) {
    return Row(
      children: [
        SizedBox(
            width: 125,
            child: Text(
              title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            )),
        Checkbox(
          value: (controllerValue == null) ? false : controllerValue,
          checkColor: Colors.black,
          activeColor: Colors.black12,
          onChanged: (value) {
            productController.newProduct.update(name, (_) => value, ifAbsent: () => value);
          },
        ),
      ],
    );
  }
}
