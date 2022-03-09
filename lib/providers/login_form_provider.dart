import 'dart:developer';

import 'package:flutter/cupertino.dart';

class LoginFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    log((formKey.currentState?.validate() ?? false).toString());
    log(email + ' - ' + password);
    return formKey.currentState?.validate() ?? false;
  }
}
