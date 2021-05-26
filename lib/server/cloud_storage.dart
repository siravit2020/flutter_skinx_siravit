import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';

class CloudStorageDb {
  Future<String> uploadImage(String partyId, File file) async {
    try {
      final ref =
          firebase_storage.FirebaseStorage.instance.ref('$partyId/image');
      await ref.putFile(file);
      String r = await ref.getDownloadURL();
      return r;
      
    } on FirebaseException catch (e) {
      print(e);
      return '';
      // e.g, e.code == 'canceled'
    }
  }
}
