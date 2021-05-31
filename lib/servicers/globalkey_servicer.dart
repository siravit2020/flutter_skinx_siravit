import 'package:flutter/material.dart';

class GlobalKeyService {
  late GlobalKey<NavigatorState> navigationKey;

  static GlobalKeyService instance = GlobalKeyService();

  GlobalKeyService () {
    navigationKey = GlobalKey<NavigatorState>();
  }
  
}
