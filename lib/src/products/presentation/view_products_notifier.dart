import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_bill/src/products/models/product.dart';
import 'package:uuid/uuid.dart';

class ViewProductsNotifier extends Notifier<List<Product>> {
  @override
  List<Product> build() {
    return <Product>[
      const Product(
          guid: "1",
          name: "chocolate",
          price: 100.0,
          description: "tulsi",
          categoryGuid: '1'),
      const Product(guid: "2", name: "Mango", price: 150.0, categoryGuid: '2'),
      const Product(
          guid: "3", name: "Strawberry", price: 150.0, categoryGuid: '2'),
    ];
  }

  void add(Product product) {
    state = [...state, product];
  }

  void edit(Product editedProduct) {
    List<Product> products = [...state];
    int index =
        products.indexWhere((product) => product.guid == editedProduct.guid);
    Product existing =
        products.firstWhere((product) => product.guid == editedProduct.guid);
    products.remove(existing);
    products.insert(index, editedProduct);
    state = products;
  }

  bool delete(Product deleteProduct) {
    bool isDeleted = state.remove(deleteProduct);
    state = [...state];
    return isDeleted;
  }
}

final productsProvider = NotifierProvider<ViewProductsNotifier, List<Product>>(
    ViewProductsNotifier.new);
