import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_skinx_siravit/models/party_model.dart';
import 'package:flutter_skinx_siravit/server/cloud_firestore.dart';
export 'package:provider/provider.dart';

class PartyChangeNotifierProvider extends ChangeNotifier {
  PartyChangeNotifierProvider() {
    fakeDowload();
  }
  final currentUser = FirebaseAuth.instance.currentUser!.uid;
  List<PartyModel>? _listParty;
  List<String> _listPartyId = [];

  List<PartyModel>? get listParty => _listParty;

  set listParty(value) {
    _listParty = value;
    notifyListeners();
  }

  Future<void> readParty() async {
    final result = await CloudFirestoreDb().readParty();
    List<PartyModel> list = [];
    int index = 0;
    for (int i = 0; i < result.length; i++) {
      PartyModel data = PartyModel.fromJson(result[i].data());
      if (data.memberList != []) {
        if (data.memberList!.length != data.memberMax) {
          list.add(data);
          _listPartyId.add(result[index].id);
          if (list[index].memberList!.contains(currentUser)) {
            list[index].join = true;
          } else {
            list[index].join = false;
          }
          index++;
        }
      } else {
        list.add(data);
        _listPartyId.add(result[index].id);
        if (list[index].memberList!.contains(currentUser)) {
          list[index].join = true;
        } else {
          list[index].join = false;
        }
        index++;
      }
    }
    _listParty = list;
  }

  Future<void> updateMember(int index) async {
    
    await CloudFirestoreDb().updateMember(
      _listPartyId[index],
      FirebaseAuth.instance.currentUser!.uid,
    );
    await readParty();
  }

  Future<void> fakeDowload() async {
    clear();
    await Future.delayed(Duration(milliseconds: 1000));
    readParty().then((value) => update());
  }

  void update() {
    notifyListeners();
  }

  void clear() {
    _listParty = null;
    _listPartyId = [];
  }
}
