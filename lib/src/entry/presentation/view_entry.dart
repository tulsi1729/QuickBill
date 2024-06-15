import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_bill/src/categories/presentation/product_price.dart';
import 'package:quick_bill/src/entry/model/entry.dart';
import 'package:quick_bill/src/entry/presentation/add_entry.dart';
import 'package:quick_bill/src/entry/presentation/view_entry_notifier.dart';

class ViewEntry extends ConsumerStatefulWidget {
  const ViewEntry({super.key, required this.customerName});
  final String customerName;

  @override
  ConsumerState<ViewEntry> createState() => EntryState();
}

class EntryState extends ConsumerState<ViewEntry> {
  @override
  Widget build(BuildContext context) {
    purchasedProductFunction(purchasedProduct) {
      return purchasedProduct
          .map((product) => product.productPrice * product.quantity)
          .fold(0.0, (previousValue, element) => previousValue + element);
    }

    String getDate(String dateString) {
      DateTime dateObject = DateTime.parse(dateString);
      return "${dateObject.day}/${dateObject.month}/${dateObject.year}/${dateObject.hour}:${dateObject.minute} ";
    }

    List<Entry> entries = ref.watch(entriesProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("ViewEntry for ${widget.customerName} "),
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
                itemCount: entries.length,
                itemBuilder: ((context, index) {
                  return Card(
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(entries[index].productName,
                              style: const TextStyle(fontSize: 20)),
                          Text(
                            getDate(entries[index].createdOn),
                          )
                        ],
                      ),
                      subtitle: Row(
                        children: [
                          Text(
                            'Quantity : ${entries[index].quantity}',
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          Text(
                              'ProductPrice : ${entries[index].productPrice.toString()} ₹'),
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
          "PurchasedProduct TotalPrice : ${purchasedProductFunction(entries)} ₹",
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
