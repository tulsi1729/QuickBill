import 'package:quick_bill/src/products/models/product.dart';

class BuyingProduct extends Product {
  final int quantity;
  BuyingProduct({required this.quantity, required Product p})
      : super(
          guid: p.guid,
          name: p.name,
          price: p.price,
          categoryGuid: p.categoryGuid,
        );
}
