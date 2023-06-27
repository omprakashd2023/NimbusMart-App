import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../services/admin_services.dart';

import '../../../common/widgets/custom_textfield.dart';
import '../../../common/widgets/custom_button.dart';

import '../../../common/utils/utils.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _addProductFormKey = GlobalKey<FormState>();
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  final AdminServices _adminServices = AdminServices();

  String category = 'Mobiles';

  List<String> productCategories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion'
  ];

  List<File> productImages = [];

  void selectProductImages() async {
    final images = await pickImages();
    if (images.isNotEmpty) {
      showSnackBar(context, 'Images Selected');
    }
    setState(() {
      productImages = images;
    });
  }

  void addProduct() {
    if (_addProductFormKey.currentState!.validate() &&
        productImages.isNotEmpty) {
      _adminServices.addProduct(
        productName: productNameController.text,
        description: descriptionController.text,
        category: category,
        price: double.parse(priceController.text),
        quantity: int.parse(quantityController.text),
        images: productImages,
        context: context,
      );
    }
  }

  @override
  void dispose() {
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          elevation: 0.0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF1E88E5),
                  Color(0xFF64B5F6),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: const Text(
            'Add Product',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _addProductFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 15.0,
                ),
                productImages.isNotEmpty
                    ? DottedBorder(
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(10.0),
                        dashPattern: const [10, 4],
                        strokeCap: StrokeCap.round,
                        child: CarouselSlider(
                          items: productImages
                              .map(
                                (item) => Builder(
                                  builder: (context) => ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.file(
                                      item,
                                      fit: BoxFit.cover,
                                      height: 200.0,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          options: CarouselOptions(
                            autoPlayInterval: const Duration(seconds: 2),
                            autoPlay: true,
                            viewportFraction: 1,
                            height: 200.0,
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: selectProductImages,
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(10.0),
                          dashPattern: const [10, 4],
                          strokeCap: StrokeCap.round,
                          child: Container(
                            width: double.infinity,
                            height: 150.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.folder_open_outlined,
                                  size: 40.0,
                                  color: Colors.black87,
                                ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                Text(
                                  'Select Product Images',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 30.0,
                ),
                CustomTextfield(
                  controller: productNameController,
                  hintText: 'Product Name',
                ),
                const SizedBox(
                  height: 10.0,
                ),
                CustomTextfield(
                  controller: descriptionController,
                  hintText: 'Description',
                  maxLines: 7,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                CustomTextfield(
                  controller: priceController,
                  hintText: 'Price',
                ),
                const SizedBox(
                  height: 10.0,
                ),
                CustomTextfield(
                  controller: quantityController,
                  hintText: 'Quantity',
                ),
                const SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    value: category,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: productCategories.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (newVal) {
                      setState(() {
                        category = newVal!;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                CustomButton(
                  text: 'Sell',
                  onTap: addProduct,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
