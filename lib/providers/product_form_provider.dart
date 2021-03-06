import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:productos_app/models/models.dart';

class ProductFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ProductFormProvider(this.product);

  Product product;

  updateAvailability(bool value) {
    log(value.toString());
    product.available = value;
    notifyListeners();
  }

  bool isValidForm() {
    log(product.name);
    log(product.price.toString());
    log(product.available.toString());
    return formKey.currentState?.validate() ?? false;
  }
}
