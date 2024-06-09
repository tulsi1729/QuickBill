import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_bill/src/categories/presentation/product_price.dart';
import 'package:quick_bill/src/entry/add_entry.dart';
import 'package:quick_bill/src/entry/model/purched_product.dart';
import 'package:quick_bill/src/entry/presentation/entry_notifier.dart';

class Entry extends ConsumerStatefulWidget {
  const Entry({super.key, required this.customerName});
  final String customerName;

  @override
  ConsumerState<Entry> createState() => EntryState();
}

class EntryState extends ConsumerState<Entry> {
  @override
  Widget build(BuildContext context) {
    List<PurchasedProduct> purchasedProduct = ref.watch(entryProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Entry for ${widget.customerName} "),
        elevation: 5,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ProductPrice(customerName: widget.customerName)));
              },
              icon: const Icon(Icons.add_circle))
        ],
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
                itemCount: purchasedProduct.length,
                itemBuilder: ((context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(purchasedProduct[index].productName),
                      subtitle: Row(
                        children: [
                          Text(
                            'Quantity : ${purchasedProduct[index].quantity}',
                          ),
                          const SizedBox(
                            width: 80,
                          ),
                          Text(
                              'ProductPrice : ${purchasedProduct[index].productPrice.toString()} ₹'),
                        ],
                      ),
                    ),
                  );
                })),
          )
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        child: Text(
          "PurchasedProduct TotalPrice : ${ref.read(entryProvider).map((product) => product.productPrice * product.quantity).fold(0.0, (previousValue, element) => previousValue + element)} ₹",
          style: const TextStyle(fontSize: 22),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddEntry(
                          customerName: widget.customerName,
                        )));
          },
          child: const Icon(Icons.add)),
    );
  }
}
