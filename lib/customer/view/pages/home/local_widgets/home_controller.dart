import 'package:flutter/material.dart';
import 'package:rent_home/models/all_models.dart';

class HomeController extends ChangeNotifier {
  int houseTypeIndex = -1;
  int cityTypeIndex = -1;
  int tabBarIndex = 0;

  Map<String, String> response = {
    "typeSale": "Rent",
    "typeHouse": "",
    "typeCity": "",
  };


  callToSaleType(String responseTypeSale) {
    response["typeSale"] = responseTypeSale;
    notifyListeners();
  }

  callToHouseType(int index) {
    houseTypeIndex = index;
    if (index == 0) response["typeHouse"] = AppArtList.products[index].name;
    notifyListeners();
  }

  callToCityType(int index) {
    cityTypeIndex = index;
    response["typeCity"] = ImageCityList.list[index].name;
    notifyListeners();
  }
}
