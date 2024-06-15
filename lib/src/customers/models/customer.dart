class Customer {
  final String guid;
  final Map<String, double> productPriceMap;
  final String name;
  const Customer(
      {required this.guid,
      required this.name,
      this.productPriceMap = const {}});
}
