import 'package:email_validator/email_validator.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_skinx_siravit/dialogs/error_dialog.dart';
import 'package:flutter_skinx_siravit/dialogs/loading_dialog.dart';
import 'package:flutter_skinx_siravit/servicers/authentication_service.dart';
import 'package:flutter_skinx_siravit/servicers/navigation_service.dart';
export 'package:provider/provider.dart';

class LoginProvider {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;

  String checkMessageError() {
    String email = _emailController.text;
    String password = _passwordController.text;
    bool isValidate = EmailValidator.validate(email);

    if (email == '')
      return 'กรุณากรอกอีเมล';
    else if (!isValidate) {
      return 'กรุณากรอกอีเมลให้ถูกต้อง';
    }

    if (password == '') {
      return 'กรุณากรอกรหัสผ่าน';
    } else if (password.length < 8) {
      return 'กรอกรหัสผ่านอย่างน้อย 8 ตัวอักษร';
    } else if (!password.contains(RegExp(r'^[a-zA-Z0-9]+$'))) {
      return 'กรุณากรุณากรอกรหัสผ่านให้ถูกต้อง ';
    }

    return '';
  }

  void checkAuthentication() async {
    String messageError = checkMessageError();
    if (messageError.isNotEmpty)
      showErrorDialog(
        message: messageError,
      );
    else {
      showLoadingDialog();
      final result = await AuthenticationServices().signIn(
        _emailController.text,
        _passwordController.text,
      );
      NavigationService.instance.pop();
      if (result == 'success') {
        clear();
        NavigationService.instance.navigateAndRemoveUntil('/home');
      } else
        showErrorDialog(
          message: result,
        );
    }
  }

  void clear() {
    _emailController.text = '';
    _passwordController.text = '';
  }
}
