class Filter {
  int minPrice;
  int maxPrice;
  String roomsNumber;
  String bedsNumber;
  String bathsNumber;
  bool hasWiFi;
  bool hasAC;
  bool hasWashingMachine;
  bool hasFridge;
  bool hasTV;

  Filter({
    this.minPrice = 20,
    this.maxPrice = 2000,
    this.roomsNumber = 'Неважно',
    this.bedsNumber = 'Неважно',
    this.bathsNumber = 'Неважно',
    this.hasWiFi = false,
    this.hasAC = false,
    this.hasWashingMachine = false,
    this.hasFridge = false,
    this.hasTV = false,
  });
}
