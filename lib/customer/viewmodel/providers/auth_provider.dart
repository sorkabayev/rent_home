import 'package:flutter/material.dart';
import 'package:rent_home/services/hive_service.dart';
import 'package:rent_home/services/log_service.dart';

class AuthProvider extends ChangeNotifier {
  bool isSeller = HiveService.getRole() == null
      ? false
      : HiveService.getRole() == "seller"
          ? true
          : false;

  changePageRoute() {
    isSeller = !isSeller;
    notifyListeners();
  }

  aaaa(){
    Log.w("message11111111");
  }
}
