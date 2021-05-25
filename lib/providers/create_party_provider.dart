import 'dart:io';

import 'package:flutter/widgets.dart';

class CreatePartyChnageNotifierProvider extends ChangeNotifier {
  TextEditingController _partyNameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _memberController = TextEditingController();
  int _countMember = 1;
  File? _image;
  bool _error = false;

  TextEditingController get partyNameController => _partyNameController;
  TextEditingController get descriptionController => _descriptionController;
  TextEditingController get memberController => _memberController;

  int get countMember => _countMember;
  set countMember(int value) {
    _countMember = value;
    notifyListeners();
  }

  File? get image => _image;
  set image(File? value) {
    _image = value;
    notifyListeners();
  }

  bool get error => _error;
  set error(bool value) {
    _error = value;
    notifyListeners();
  }

  set setMember(String value) {
    _memberController.text = value;
  }

  void checkPartyName() {
    if (_partyNameController.text.isEmpty)
      _error = true;
    else
      _error = false;
  }

  void check() {
    checkPartyName();
    if (!_error) {
      
    }
  }
}
