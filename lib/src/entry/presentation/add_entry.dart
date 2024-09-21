import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_bill/src/entry/model/buying_product.dart';
import 'package:quick_bill/src/entry/model/entry.dart';
import 'package:quick_bill/src/entry/presentation/buying_product_Notifier.dart';
import 'package:quick_bill/src/entry/presentation/selected_product_provider.dart';
import 'package:quick_bill/src/entry/presentation/view_entry_notifier.dart';
import 'package:quick_bill/src/products/models/product.dart';
import 'package:quick_bill/src/products/presentation/view_products_notifier.dart';

class AddEntry extends ConsumerStatefulWidget {
  const AddEntry({super.key, required this.customerName});

  final String customerName;
  @override
  ConsumerState<AddEntry> createState() => _AddEntryState();
}

class _AddEntryState extends ConsumerState<AddEntry> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final addQualityController = TextEditingController();
    AsyncValue<List<Product>> productsAsync = ref.watch(productsProvider);
    Map<String, BuyingProduct> buyingProductMap =
        ref.watch(buyingProductProvider);
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Entry for ${widget.customerName}"),
          elevation: 5,
        ),
        body: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border:
                    Border.all(color: const Color.fromARGB(255, 54, 55, 56)),
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                      5.0), //                 <--- border radius here
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: productsAsync.when(
                          data: (products) => DropdownButtonFormField(
                            validator: (value) {
                              if (value == null) {
                                return "Select Product";
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) {
                              ref.read(selectedProductProvider.notifier).state =
                                  value;
                            },
                            decoration: const InputDecoration(
                                labelText: "select product",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                  Radius.circular(5.0),
                                ))),
                            value: ref.watch(selectedProductProvider),
                            icon: const Icon(Icons.arrow_drop_down),
                            items: products.map((valueItem) {
                              return DropdownMenuItem<Product>(
                                value: valueItem,
                                child: Column(
                                  children: [
                                    Text(valueItem.name),
                                    Text(valueItem.price.toString()),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                          loading: () => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          error: (error, _) => Text(error.toString()),
                        ),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      Flexible(
                        child: TextFormField(
                          controller: addQualityController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter quantity";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: "Enter Quantity",
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        final buyingProduct = BuyingProduct(
                          quantity: int.parse(addQualityController.text),
                          p: ref.watch(selectedProductProvider)!,
                        );

                        ref.read(buyingProductProvider.notifier).add(
                              ref.read(selectedProductProvider)!.guid,
                              buyingProduct,
                            );
                        FocusScope.of(context).unfocus();
                      },
                      child: const Text(
                        "Add",
                      )),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  border:
                      Border.all(color: const Color.fromARGB(255, 54, 55, 56)),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(
                        5.0), //                 <--- border radius here
                  ),
                ),
                child: ListView.builder(
                    itemCount: buyingProductMap.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(
                              buyingProductMap.values.elementAt(index).name),
                          subtitle: Row(
                            children: [
                              Text(
                                  "Price : ${buyingProductMap.values.elementAt(index).price.toString()} ₹"),
                              const SizedBox(
                                width: 40,
                              ),
                              Text(
                                  "Quantity : ${buyingProductMap.values.elementAt(index).quantity.toString()} "),
                            ],
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                ref.read(buyingProductProvider.notifier).remove(
                                    buyingProductMap.values
                                        .elementAt(index)
                                        .guid);
                              },
                              icon: const Icon(Icons.remove_circle)),
                        ),
                      );
                    }),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                        'Total Price: ${ref.read(buyingProductProvider).values.map<double>((value) => value.price * value.quantity).fold(0.0, (previousValue, element) => previousValue + element)} ₹'),
                  ],
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        List<Entry> entries = ref
                            .read(buyingProductProvider)
                            .values
                            .map((buyingProduct) {
                          return Entry(
                              productName: buyingProduct.name,
                              quantity: buyingProduct.quantity,
                              productPrice: buyingProduct.price,
                              createdOn: DateTime.now().toString(),
                              customerGUID: buyingProduct.categoryGuid);
                        }).toList();
                        ref.read(entriesProvider.notifier).add(entries);

                        Navigator.pop(context);
                        ref.read(buyingProductProvider.notifier).clear();
                      },
                      child: const Text('Save Entry'),
                    ),
                  ],
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
