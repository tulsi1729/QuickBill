import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_bill/src/categories/models/category.dart';
import 'package:quick_bill/src/categories/presentation/view_categories_notifier.dart';
import 'package:quick_bill/src/localization/app_localizations_context.dart';
import 'package:quick_bill/src/products/models/product.dart';
import 'package:quick_bill/src/products/presentation/add_product.dart';
import 'package:quick_bill/src/products/presentation/view_products_notifier.dart';

class ViewProducts extends ConsumerWidget {
  const ViewProducts({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Product> products = ref.watch(productsProvider);
    List<Category> categories = ref.watch(categoriesProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.viewProductTitle),
        elevation: 5,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddProduct()),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: products.isEmpty
              ? Text(context.l10n.noProductMessage)
              : ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(
                          products[index].name,
                          style: const TextStyle(fontSize: 30),
                        ),
                        subtitle: Column(children: <Widget>[
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                products[index].description == null
                                    ? Container()
                                    : Text(
                                        products[index].description!,
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                Row(
                                  children: [
                                    Text(
                                      '${products[index].price}₹',
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    const Spacer(),
                                    Text(
                                        categories
                                            .firstWhere((element) =>
                                                element.guid ==
                                                products[index].categoryGuid)
                                            .name,
                                        style: const TextStyle(fontSize: 20))
                                  ],
                                ),
                              ]),
                        ]),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            IconButton(
                                onPressed: () {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) => AlertDialog(
                                        title: const Text('Alert'),
                                        content: const Text(
                                            'Are you sure you want to delete?'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              bool isDeleteDone = ref
                                                  .read(
                                                      productsProvider.notifier)
                                                  .delete(products[index]);
                                              String message = "";
                                              if (isDeleteDone) {
                                                message = context.l10n
                                                    .customerRequiredMessageDelete;
                                              } else {
                                                message = context.l10n
                                                    .customerRequiredMessageNotDelete;
                                              }

                                              SnackBar snackBar = SnackBar(
                                                  content: Text(message));
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                              Navigator.pop(context);
                                            },
                                            child: const Text('YES'),
                                          ),
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text('NO'),
                                          ),
                                        ]),
                                  );
                                },
                                icon: const Icon(Icons.delete)),
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddProduct(
                                              preFillProduct: products[index],
                                              isEditMode: true,
                                            )),
                                  );
                                },
                                icon: const Icon(Icons.edit)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
