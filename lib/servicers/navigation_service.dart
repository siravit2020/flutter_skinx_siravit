import 'package:flutter/material.dart';
import 'package:flutter_skinx_siravit/servicers/globalkey_servicer.dart';

class NavigationService {
  late GlobalKey<NavigatorState> navigationKey;

  static NavigationService instance = NavigationService();

  NavigationService () {
    navigationKey = GlobalKeyService.instance.navigationKey;
  }

  Future<dynamic> navigateToReplacement(String _rn) {
    return navigationKey.currentState!.pushReplacementNamed(_rn);
  }

  Future<dynamic> navigateAndRemoveUntil(String _rn) {
    return navigationKey.currentState!.pushNamedAndRemoveUntil(_rn, (route) => false);
  }

  Future<dynamic> navigateTo(String _rn) {
    return navigationKey.currentState!.pushNamed(_rn);
  }

  Future<dynamic> navigateToRoute(MaterialPageRoute _rn) {
    return navigationKey.currentState!.push(_rn);
  }

  pop() {
    return navigationKey.currentState!.pop();
  }
}
