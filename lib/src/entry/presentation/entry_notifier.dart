import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_bill/src/entry/model/purched_product.dart';

class ViewEntryNotifier extends Notifier<List<PurchasedProduct>> {
  @override
  List<PurchasedProduct> build() {
    return <PurchasedProduct>[
      const PurchasedProduct(
          customerGuid: '1',
          productName: 'Cake',
          quantity: 10,
          productPrice: 200),
      const PurchasedProduct(
          customerGuid: '2',
          productName: 'Bread',
          quantity: 30,
          productPrice: 100),
    ];
  }
}

final entryProvider =
    NotifierProvider<ViewEntryNotifier, List<PurchasedProduct>>(
        ViewEntryNotifier.new);
