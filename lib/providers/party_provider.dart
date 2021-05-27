import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_skinx_siravit/models/party_model.dart';
import 'package:flutter_skinx_siravit/server/cloud_firestore.dart';
export 'package:provider/provider.dart';

class PartyChangeNotifierProvider extends ChangeNotifier {
  List<PartyModel>? _listParty;
  List<String> _listPartyId = [];
  bool _loading = true;

  List<PartyModel>? get listParty => _listParty;

  bool get loading => _loading;

  set loading(value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> readParty() async {
    String currentUser = FirebaseAuth.instance.currentUser!.uid;
    var result = await CloudFirestoreDb().readParty();
    List<PartyModel> list = [];
    List<String> listId = [];
    int index = 0;
    print('index $index');
    for (int i = 0; i < result.length; i++) {
      PartyModel data = PartyModel.fromJson(result[i].data());
      if (data.memberList != []) {
        if (data.memberList!.length != data.memberMax) {
          list.add(data);
          listId.add(result[index].id);
          if (list[index].memberList!.contains(currentUser)) {
            list[index].join = true;
          } else {
            list[index].join = false;
          }
          index++;
        }
      } else {
        list.add(data);
        listId.add(result[index].id);
        if (list[index].memberList!.contains(currentUser)) {
          list[index].join = true;
        } else {
          list[index].join = false;
        }
        index++;
      }
    }
    _listParty = list;
    _listPartyId = listId;
    _loading = false;
  }

  Future<bool> updateMember(int index) async {
    var result = await CloudFirestoreDb().updateMember(
      _listPartyId[index],
      FirebaseAuth.instance.currentUser!.uid,
    );
    return result;
  }

  Future<void> updateParty() async {
    await readParty();
    _loading = false;
    update();
  }

  Future<void> fakeDowload() async {
    _loading = true;
    await Future.delayed(Duration(milliseconds: 1000));
    await readParty();
    update();
  }

  void update() {
    notifyListeners();
  }

  void clear() {
    _listParty = null;
    _listPartyId = [];
  }
}
