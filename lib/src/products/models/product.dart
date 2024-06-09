class Product {
  final String guid;
  final String name;
  final double price;
  final String? description;
  final String categoryGuid;

  const Product({
    required this.guid,
    required this.name,
    required this.price,
    required this.categoryGuid,
    this.description,
  });

  String toString() {
    return 'Product{ guid: $guid, name: $name, price: $price, description: $description, categoryGuid: $categoryGuid }';
  }
}
