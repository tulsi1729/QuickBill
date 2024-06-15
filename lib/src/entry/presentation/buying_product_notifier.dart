import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_bill/src/entry/model/buying_product.dart';
import 'package:quick_bill/src/products/models/product.dart';

class BuyingProductNotifier extends Notifier<Map<String, BuyingProduct>> {
  @override
  Map<String, BuyingProduct> build() {
    return {};
  }

  void add(String productGuid, BuyingProduct buyingProduct) {
    if (state[productGuid] != null) {
      int existingQuantity = state[productGuid]!.quantity;
      state[productGuid] = BuyingProduct(
          p: Product(
              categoryGuid: buyingProduct.categoryGuid,
              name: buyingProduct.name,
              price: buyingProduct.price,
              description: buyingProduct.description,
              guid: buyingProduct.guid),
          quantity: existingQuantity + buyingProduct.quantity);
    } else {
      state[productGuid] = buyingProduct;
    }
    state = {...state};
  }

  void remove(String guid) {
    Map<String, BuyingProduct> temp = state;
    temp.remove(guid);
    state = {...temp};
  }

  void clear() {
    state = {};
  }
}

final buyingProductProvider =
    NotifierProvider<BuyingProductNotifier, Map<String, BuyingProduct>>(
        BuyingProductNotifier.new);
