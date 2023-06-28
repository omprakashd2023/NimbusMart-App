import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];

  void addProduct({required Product product}) {
    _products.add(product);
    notifyListeners();
  }

  void removeProduct({required Product product}) {
    _products.remove(product);
    notifyListeners();
  }

  void editProduct({required Product product}) {
    final index = _products.indexWhere((prod) => prod.id == product.id);
    _products[index] = product;
    notifyListeners();
  }

  void setProducts({required List<Product> products}) {
    _products = products;
    notifyListeners();
  }

  Product getProduct({required int index}) {
    return _products[index];
  }

  List<Product> get allProducts {
    return [..._products];
  }

  List<Product> getProductsByCategory({required String category}) {
    return _products.where((prod) => prod.category == category).toList();
  }
}
