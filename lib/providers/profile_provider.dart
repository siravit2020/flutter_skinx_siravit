import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_skinx_siravit/models/user_party_model.dart';
import 'package:flutter_skinx_siravit/server/cloud_firestore.dart';
import 'package:flutter_skinx_siravit/servicers/navigation_service.dart';
export 'package:provider/provider.dart';

class ProfileChangeNotifierProvider extends ChangeNotifier {
  UserPartyModel? _userParty;
  String? _name;

  String? get name => _name;
  UserPartyModel? get userParty => _userParty;

 
  Future<void> initialData() async {
    _name = FirebaseAuth.instance.currentUser!.displayName!;
    var result = await CloudFirestoreDb().getUserParty();
    if (result != null) _userParty = UserPartyModel.fromJson(result.data()!);
    notifyListeners();
  }

  Future<void> signOut() async {
    _name = null;
    _userParty = null;
    await FirebaseAuth.instance.signOut();
    NavigationService.instance.navigateAndRemoveUntil('splash');
  }
}
