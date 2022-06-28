import 'package:flutter/material.dart';

class PropertyBenefitsProvider extends ChangeNotifier {
  final Map<String, String> media = {
    'assets/icons/announcement_page_icons/kitchen_facility.png':
        'Кухонная мебель',
    'assets/icons/announcement_page_icons/sofa.png': 'Мебель в комнатах',
    'assets/icons/announcement_page_icons/fridge.png': 'Холодильник',
    'assets/icons/announcement_page_icons/washing_machine.png':
        'Стиральная машина',
    'assets/icons/announcement_page_icons/tv.png': 'Телевизор',
    'assets/icons/announcement_page_icons/wifi.png': 'Интернет',
    'assets/icons/announcement_page_icons/air_conditioner.png': 'Кондиционер',
    'assets/icons/announcement_page_icons/dish_washer.png': 'Посудомоечная машина',
    'assets/icons/announcement_page_icons/bath.png': 'Душевая кабина',
    'assets/icons/announcement_page_icons/baby.png': 'Можно с детьми',
    'assets/icons/announcement_page_icons/animals.png': 'Домашние животные разрешены',
  };
  List<bool> listFacilities = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  void updateFacilities(int index) {
    listFacilities[index] = !listFacilities[index];
    notifyListeners();
  }
}
