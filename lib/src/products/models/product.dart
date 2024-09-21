import 'package:quick_bill/src/common/constants/string_constants.dart';

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

  Map<String, dynamic> toMap() {
    return {
      StringConstants.guid: guid,
      StringConstants.name: name,
      StringConstants.price: price,
      StringConstants.description: description,
      StringConstants.categoryGuid: categoryGuid,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      guid: map[StringConstants.guid] as String,
      name: map[StringConstants.name] as String,
      price: map[StringConstants.price] as double,
      description: map[StringConstants.description] as String?,
      categoryGuid: map[StringConstants.categoryGuid] as String,
    );
  }
}
