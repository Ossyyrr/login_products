import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:productos_app/models/models.dart';

class ProductsService extends ChangeNotifier {
  final String _baseUrl = 'flutter-varios-ec8f7-default-rtdb.firebaseio.com';
  final List<Product> products = [];
  late Product selectedProduct;

  File? newPictureFile;

  bool isLoading = true;
  bool isSaving = false;

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

  Future saveOrCreateProduct(Product product) async {
    isSaving = true;
    notifyListeners();

    if (product.id == null) {
      // Crear
      await createProduct(product);
    } else {
      // Actualizar
      updateProduct(product);
    }

    isSaving = false;
    notifyListeners();
  }

  String updateProduct(Product product) {
    final url = Uri.https(_baseUrl, 'products/${product.id}.json');
    http.put(url, body: product.productToJson(product));

    final index = products.indexWhere((element) => element.id == product.id);
    products[index] = product;
    return product.id!;
  }

  Future<String> createProduct(Product product) async {
    final url = Uri.https(_baseUrl, 'products.json');
    final resp = await http.post(url, body: product.productToJson(product));
    final decodeData = resp.body;
    product.id = jsonDecode(decodeData)['name'];
    products.add(product);
    return product.id!;
  }

  void updateSelectedProductImage(String path) {
    selectedProduct.picture = path;
    newPictureFile = File.fromUri(Uri(path: path));
    notifyListeners();
  }

  Future<String?> uploadImage() async {
    if (newPictureFile == null) return null;
    isSaving = true;
    notifyListeners();
    final url = Uri.parse('https://api.cloudinary.com/v1_1/dsxrtenrt/image/upload?upload_preset=hh77trjt');
    final imageUploadRequest = http.MultipartRequest('POST', url);
    final file = await http.MultipartFile.fromPath('file', newPictureFile!.path);

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();

    final resp = await http.Response.fromStream(streamResponse);

    log(resp.body);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      log('Algo salió mal');
      log(resp.body);
      return null;
    }

    final decodeData = jsonDecode(resp.body);
    return decodeData['secure_url'];
  }
}
