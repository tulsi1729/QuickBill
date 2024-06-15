import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_bill/src/debug/console_log.dart';
import 'package:quick_bill/src/products/models/product.dart';
import 'package:quick_bill/src/products/presentation/view_products_notifier.dart';

class ProductPrice extends ConsumerStatefulWidget {
  const ProductPrice({super.key, required this.customerName});
  final String customerName;
  @override
  ConsumerState<ProductPrice> createState() => _ProductPriceState();
}

class _ProductPriceState extends ConsumerState<ProductPrice> {
  final priceController = TextEditingController();
  int currentPageIndex = 0;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    AsyncValue<List<Product>> productsAsync = ref.watch(productsProvider);
    final Map<String, double> productPriceMap = {};
    return Scaffold(
        appBar: AppBar(
          title: Text("Products Prices for ${widget.customerName} "),
        ),
        body: Form(
            key: _formKey,
            child: productsAsync.when(
              data: (products) => ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  itemCount: products.length,
                  itemBuilder: ((context, index) {
                    return Table(
                      children: [
                        TableRow(children: [
                          Text(
                            products[index].name,
                            style: const TextStyle(
                                fontSize: 35, fontWeight: FontWeight.w400),
                          ),
                          TextFormField(
                            onSaved: (newPriceString) {
                              double newPrice = double.parse(newPriceString!);
                              if (newPrice != products[index].price) {
                                productPriceMap[products[index].guid] =
                                    newPrice;
                              }
                            },
                            initialValue: products[index].price.toString(),
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              suffixIcon: Icon(Icons.currency_rupee),
                            ),
                          ),
                        ])
                      ],
                    );
                  })),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, _) => Text(error.toString()),
            )),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          child: Row(
            children: [
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    consoleLog(productPriceMap);
                  }
                },
                child: const Text("Save Prices"),
              )
            ],
          ),
        ));
  }
}
