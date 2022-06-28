import 'package:flutter/material.dart';
import 'package:rent_home/models/filter_model.dart';
import 'package:rent_home/models/home_model.dart';

class FilterProvider extends ChangeNotifier {
  Filter _filterObject = Filter();

  final _houseProperties = <String>[
    'Комнаты',
    'Спальни',
    'Ванны',
  ];

  final _propertiesNumber = <String>[
    'Неважно',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '9+',
  ];

  final _homeAppliances = <String>[
    'Кухонный мебель',
    'Мебель в комнатах',
    'Холодильник',
    'Стиральная машина',
    'Телевизор',
    'Wi-Fi',
    'Кондитционер',
    'Посудамойка',
    'Душевая кабина',
    'Можно с детми',
    'Можно с животными',
  ];

  RangeValues _sliderValue = const RangeValues(1, 100);

  RangeValues get sliderValue => _sliderValue;

  set sliderValue(RangeValues value) {
    if (value != _sliderValue) {
      _sliderValue = value;
      _filterObject.minPrice = _sliderValue.start.floor() * 20;
      _filterObject.maxPrice = _sliderValue.end.floor() * 20;
      filter();
      notifyListeners();
    }
  }

  List<String> get homeAppliances => _homeAppliances;

  List<String> get propertiesNumber => _propertiesNumber;

  List<String> get houseProperties => _houseProperties;

  int get minPrice => _sliderValue.start.floor() * 20;

  int get maxPrice => _sliderValue.end.floor() * 20;

  int get avgPrice => ((minPrice + maxPrice) / 2).round();

  void filter() {
    homes = homes
        .where(
          (element) =>
              _filterObject.maxPrice >= int.parse(element.price) ||
              _filterObject.minPrice <= int.parse(element.price) ||
                  element.roomsCount == _filterObject.roomsNumber ||
                  element.bedsCount == _filterObject.bedsNumber ||
                  element.bathCount == _filterObject.bathsNumber,
        )
        .toList();
  }

  /// For ListView
  bool checkIfSelected(int index, int i) {
    // * i - is index of _houseProperties list
    // * index - is index of _propertiesNumber list
    String number = _houseProperties[i] == 'Комнаты'
        ? _filterObject.roomsNumber
        : _houseProperties[i] == 'Спальни'
            ? _filterObject.bedsNumber
            : _filterObject.bathsNumber;

    return propertiesNumber[index] == number;
  }

  void updateSelected(int index, int i) {
    // * i - is index of _houseProperties list
    // * index - is index of _propertiesNumber list
    _houseProperties[i] == 'Комнаты'
        ? _filterObject.roomsNumber = _propertiesNumber[index]
        : _houseProperties[i] == 'Спальни'
            ? _filterObject.bedsNumber = _propertiesNumber[index]
            : _filterObject.bathsNumber = _propertiesNumber[index];

    filter();
    notifyListeners();
  }

  /// For CheckboxListTile
  bool identifyValue(String title) {
    switch (title) {
      case 'Wi-Fi':
        return _filterObject.hasWiFi;
      case 'Кондиционер':
        return _filterObject.hasAC;
      case 'Посудомоечная машина':
        return _filterObject.hasWashingMachine;
      case 'Холодильник':
        return _filterObject.hasFridge;
      case 'Телевизор':
        return _filterObject.hasTV;
    }
    return false;
  }

  void updateValue(String title, bool value) {
    switch (title) {
      case 'Wi-Fi':
        _filterObject.hasWiFi = value;
        notifyListeners();
        break;
      case 'Кондиционер':
        _filterObject.hasAC = value;
        notifyListeners();
        break;
      case 'Посудомоечная машина':
        _filterObject.hasWashingMachine = value;
        notifyListeners();
        break;
      case 'Холодильник':
        _filterObject.hasFridge = value;
        notifyListeners();
        break;
      case 'Телевизор':
        _filterObject.hasTV = value;
        notifyListeners();
        break;
    }
  }

  /// For Buttons
  void clear() {
    _filterObject = Filter();
    _sliderValue = const RangeValues(1, 100);
    print(
        'slider.start: ${_sliderValue.start} \t slider.end: ${_sliderValue.end}');
    print(
        'minPrice: ${_filterObject.minPrice} \t maxPrice: ${_filterObject.maxPrice}');
    print(
        'roomsNumber: ${_filterObject.roomsNumber} \t bedsNumber: ${_filterObject.bedsNumber} \t bathsNumber: ${_filterObject.bathsNumber}');
    print(
        'hasWiFi: ${_filterObject.hasWiFi} \t hasAC: ${_filterObject.hasAC} \t hasWashingMachine: ${_filterObject.hasWashingMachine} \t hasFridge: ${_filterObject.hasFridge} \t hasTV: ${_filterObject.hasTV}');
    notifyListeners();
  }

  void done(BuildContext context) {
    print(
        'minPrice: ${_filterObject.minPrice} \t maxPrice: ${_filterObject.maxPrice}');
    print(
        'roomsNumber: ${_filterObject.roomsNumber} \t bedsNumber: ${_filterObject.bedsNumber} \t bathsNumber: ${_filterObject.bathsNumber}');
    print(
        'hasWiFi: ${_filterObject.hasWiFi} \t hasAC: ${_filterObject.hasAC} \t hasWashingMachine: ${_filterObject.hasWashingMachine} \t hasFridge: ${_filterObject.hasFridge} \t hasTV: ${_filterObject.hasTV}');
    Navigator.pop(context);
  }
}
