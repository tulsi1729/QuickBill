import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_bill/src/products/models/product.dart';

class ViewProductsNotifier extends Notifier<List<Product>> {
  @override
  List<Product> build() {
    return const <Product>[];
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
