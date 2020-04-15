import 'dart:io';

import 'package:dob/data/model/product_model.dart';
import 'package:scoped_model/scoped_model.dart';

class Products extends Model {
  List<Product> _products = [];
  void add_products(
    String title,
    String description,
    double price,
    File image,
    int days,
    int hours,
  ) {
    print("New Item is added");
    final Product newProduct = Product(
      title: title,
      description: description,
      price: price,
      image: image,
      days: days,
      hours: hours,
    );
    _products.add(newProduct);
    notifyListeners();
  }

  List<Product> get allProducts {
    return List.from(_products);
  }
}
