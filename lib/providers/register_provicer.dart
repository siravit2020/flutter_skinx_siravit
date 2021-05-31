import 'package:email_validator/email_validator.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_skinx_siravit/constants/type_text_field.dart';
import 'package:flutter_skinx_siravit/dialogs/error_dialog.dart';
import 'package:flutter_skinx_siravit/dialogs/loading_dialog.dart';
import 'package:flutter_skinx_siravit/servicers/authentication_service.dart';
import 'package:flutter_skinx_siravit/servicers/navigation_service.dart';
export 'package:provider/provider.dart';

class RegisterChangeNotifierProvider extends ChangeNotifier {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  TypeTextField _typeError = TypeTextField.none;
  String _messageError = '';
  bool _checkBoxValue = false;

  TextEditingController get nameController => _nameController;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;

  String get messageError => _messageError;

  bool get checkBoxValue => _checkBoxValue;

  set checkBoxValue(bool value) {
    _checkBoxValue = value;
    notifyListeners();
  }

  TypeTextField get typeError => _typeError;

  set typeError(value) {
    _typeError = value;
    notifyListeners();
  }

  void checkMessageError() async {
    String name = _nameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;
    bool isValidate = EmailValidator.validate(email);

    _typeError = TypeTextField.name;
    if (name.isEmpty) {
      _messageError = 'กรุณากรอกชื่อ';
      return;
    }

    _typeError = TypeTextField.email;
    if (email.isEmpty) {
      _messageError = 'กรุณากรอกอีเมล';
      return;
    } else if (!isValidate) {
      _messageError = 'กรุณากรอกอีเมลให้ถูกต้อง';
      return;
    }

    _typeError = TypeTextField.password;
    if (password.isEmpty) {
      _messageError = 'กรุณากรอกรหัสผ่าน';
      return;
    } else if (password.length < 8) {
      _messageError = 'กรุณากรอกรหัสผ่านอย่างน้อย 8 ตัวอักษร';
      return;
    } else if (!password.contains(RegExp(r'^[a-zA-Z0-9]+$'))) {
      _messageError =
          'กรุณากรุณากรอกรหัสผ่านให้ถูกต้อง สามารถใช้ได้เฉพาะตัวอักษร และ ตัวเลขเท่านั้น';
      return;
    }

    _typeError = TypeTextField.confirmPassword;
    if (password != confirmPassword) {
      _messageError = 'กรุณากรอกรหัสผ่านให้ตรงกัน';
      return;
    }

    _typeError = TypeTextField.checkBox;
    if (!_checkBoxValue) {
      _messageError = 'กรุณากดยอมรับเงื่อนไขและข้อตกลง';
      return;
    }

    _typeError = TypeTextField.none;
    _messageError = '';
  }

  void checkAuthentication() async {
    checkMessageError();
    notifyListeners();
    if (_messageError.isEmpty) {
      showLoadingDialog();
      final result = await AuthenticationServices().register(
        _emailController.text,
        _passwordController.text,
        _nameController.text,
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
    _nameController.text = '';
    _emailController.text = '';
    _passwordController.text = '';
    _confirmPasswordController.text = '';
    _typeError = TypeTextField.none;
    _messageError = '';
    _checkBoxValue = false;
  }
}
