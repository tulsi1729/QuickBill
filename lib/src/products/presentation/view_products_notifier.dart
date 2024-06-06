import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_bill/src/products/models/product.dart';
import 'package:quick_bill/src/products/repository/products_repository.dart';

class ViewProductsNotifier extends AsyncNotifier<List<Product>> {
  late final ProductsRepository _repository;
  @override
  FutureOr<List<Product>> build() {
    _repository = ref.watch(productsRepositoryProvider);
    return _repository.getAllProducts();
  }

  void add(Product product) {
    state = AsyncData([...(state.value ?? []), product]);
    _repository.save(entityJSON: product.toMap());
  }

  void edit(Product editedProduct) {
    List<Product> products = [...(state.value ?? [])];
    int index =
        products.indexWhere((product) => product.guid == editedProduct.guid);
    Product existing =
        products.firstWhere((product) => product.guid == editedProduct.guid);
    products.remove(existing);
    products.insert(index, editedProduct);
    state = AsyncData(products);
  }

  bool delete(Product deleteProduct) {
    bool isDeleted = (state.value ?? []).remove(deleteProduct);
    state = AsyncData([...(state.value ?? [])]);
    return isDeleted;
  }
}

final productsProvider =
    AsyncNotifierProvider<ViewProductsNotifier, List<Product>>(
        ViewProductsNotifier.new);
