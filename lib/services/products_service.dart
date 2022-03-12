import 'dart:convert';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:productos_app/models/models.dart';

class ProductsService extends ChangeNotifier {
  final String _baseUrl = 'flutter-varios-ec8f7-default-rtdb.firebaseio.com';
  final List<Product> products = [];
  late Product selectedProduct;

  bool isLoading = true;

  ProductsService() {
    loadProducts();
  }

  Future<List<Product>> loadProducts() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.https(_baseUrl, 'products.json');

    final resp = await http.get(url);
    final Map<String, dynamic> productsMap = jsonDecode(resp.body);

    log(productsMap.toString());

    productsMap.forEach((key, value) {
      final temporalProduct = Product.fromJson(value);
      temporalProduct.id = key;
      products.add(temporalProduct);
    });
    log(products[0].name.toString());

    isLoading = false;
    notifyListeners();

    return products;
  }
}
