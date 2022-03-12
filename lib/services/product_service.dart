import 'package:flutter/widgets.dart';
import 'package:productos_app/models/models.dart';

class ProductsService extends ChangeNotifier {
  final String _baseUrl = 'flutter-varios-ec8f7-default-rtdb.firebaseio.com';
  final List<Product> products = [];
}
