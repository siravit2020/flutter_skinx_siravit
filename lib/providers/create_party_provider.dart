import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_skinx_siravit/server/cloud_firestore.dart';
import 'package:flutter_skinx_siravit/server/cloud_storage.dart';
import 'package:flutter_skinx_siravit/servicers/navigation_service.dart';

class CreatePartyChnageNotifierProvider extends ChangeNotifier {
  TextEditingController _partyNameController = TextEditingController();
  TextEditingController _memberController = TextEditingController();
  int _countMember = 1;
  File? _image;
  bool _error = false;

  TextEditingController get partyNameController => _partyNameController;
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

  void clear() {
    _partyNameController.text = '';
    _memberController.text = '';
    _countMember = 1;
    _image = null;
    _error = false;
  }

  Future<bool> check() async {
    checkPartyName();
    if (!_error) {
      return true;
    }
    notifyListeners();
    return false;
  }

  Future<void> updateParty() async {
    final docReference = await CloudFirestoreDb().addParty(
        FirebaseAuth.instance.currentUser!.uid,
        _partyNameController.text,
        _countMember);
    CloudFirestoreDb().updateUserParty(
        FirebaseAuth.instance.currentUser!.uid, docReference.id);
    if (_image != null) {
      final imageUrl = await CloudStorageDb().uploadImage(
        docReference.id,
        _image!,
      );
      print('image $imageUrl');
      await CloudFirestoreDb().updateImage(
        docReference.id,
        imageUrl,
      );
    }
    clear();
  }
}
