import 'package:flutter/widgets.dart';
import 'package:productos_app/models/models.dart';

class ProductFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ProductFormProvider(this.product);

  Product product;

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
