import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_skinx_siravit/models/party_model.dart';

class CloudFirestoreDb {
  Future<DocumentReference> addParty(
    String host,
    String title,
    int maxMember,
  ) async {
    final partys = FirebaseFirestore.instance.collection('partys');
    DocumentReference docReference = await partys.add({
      'host': host,
      'title': title,
      'member_max': maxMember,
    });
    return docReference;
  }

  Future<bool> updateImage(String partyId, String imageUrl) async {
    final partys = FirebaseFirestore.instance.collection('partys');
    await partys.doc(partyId).update({'image_url': imageUrl}).then(
      (value) {
        print(imageUrl);
        return true;
      },
    );
    return false;
  }

  void updateUserParty(String uid, String partyId) async {
    final users = FirebaseFirestore.instance.collection('users');

    final doc = await users.doc(uid).get();

    if (doc.exists) {
      if (doc.data()!['party_create'] != null) {
        List<String> result = List<String>.from(doc.data()!['party_create']);
        result.add(partyId);
        users.doc(uid).update({'party_create': result});
      } else {
        users.doc(uid).update({
          'party_create': [partyId]
        });
      }
    } else {
      users.doc(uid).set({
        'party_create': [partyId]
      });
    }
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> readParty() async {
    final partys = FirebaseFirestore.instance.collection('partys');
    return (await partys.get()).docs;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>?> getUserParty() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    final users = FirebaseFirestore.instance.collection('users');
    final doc = await users.doc(uid).get();
    if (doc.exists) {
      return doc;
    } else {
      return null;
    }
  }

  Future<bool> updateMember(String partyId, String uid) async {
    final partys = FirebaseFirestore.instance.collection('partys');

    final doc = await partys.doc(partyId).get();

    if (doc.data()!['member_list'] != null) {
      List<String> result = List<String>.from(doc.data()!['member_list']);
      if (result.length != (doc.data()!['member_max'])) {
        result.add(uid);
        await partys.doc(partyId).update({'member_list': result});
        await updatePartyList(partyId, uid);
        return true;
      }
      return false;
    } else {
      await partys.doc(partyId).update({
        'member_list': [uid]
      });
      await updatePartyList(partyId, uid);
      return true;
    }
  }

  Future<void> updatePartyList(String partyId, String uid) async {
    final users = FirebaseFirestore.instance.collection('users');
    final docUser = await users.doc(uid).get();
    if (docUser.exists) {
      if (docUser.data()!['party_list'] != null) {
        List<String> result = List<String>.from(docUser.data()!['party_list']);
        result.add(partyId);
        await users.doc(uid).update({'party_list': result});
      } else {
        await users.doc(uid).update({
          'party_list': [partyId]
        });
      }
    } else {
      await users.doc(uid).set({
        'party_list': [partyId]
      });
    }
  }
}
