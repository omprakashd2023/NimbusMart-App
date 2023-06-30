import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];

  void addProduct({required Product product}) {
    final index = _products.indexWhere((prod) => prod.id == product.id);
    if (index == -1) {
      _products.add(product);
    } else {
      _products.removeAt(index);
      _products.insert(index, product);
    }
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

  Product getProductById({required String id}) {
    return _products.firstWhere((prod) => prod.id == id);
  }

  List<Product> get allProducts {
    return [..._products];
  }

  List<Product> getProductsByCategory({required String category}) {
    return _products.where((prod) => prod.category == category).toList();
  }
}
