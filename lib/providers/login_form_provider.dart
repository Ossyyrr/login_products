import 'dart:developer';

import 'package:flutter/cupertino.dart';

class LoginFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  bool isValidForm() {
    log((formKey.currentState?.validate() ?? false).toString());
    log(email + ' - ' + password);
    return formKey.currentState?.validate() ?? false;
  }
}
