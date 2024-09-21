import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_bill/src/customers/models/customer.dart';
import 'package:quick_bill/src/customers/presentation/add_customer.dart';
import 'package:quick_bill/src/customers/presentation/view_customers_notifier.dart';
import 'package:quick_bill/src/localization/app_localizations_context.dart';

class ViewCustomers extends ConsumerWidget {
  const ViewCustomers({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<Customer>> customersAsync = ref.watch(customersProvider);
    return customersAsync.when(
      data: (customers) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddCustomer()));
          },
          child: const Icon(Icons.add_box),
        ),
        appBar: AppBar(
          title: Text(context.l10n.viewCustomersTitle),
          elevation: 5,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: customers.isEmpty
                ? Text(context.l10n.noCustomerMessage)
                : ListView.builder(
                    itemCount: customers.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(
                            customers[index].name,
                            style: const TextStyle(fontSize: 30),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              IconButton(
                                onPressed: () {
                                  final isDeleteDone = ref
                                      .read(customersProvider.notifier)
                                      .delete(customers[index]);

                                  String message = "";
                                  if (isDeleteDone) {
                                    message = context
                                        .l10n.categoryRequiredMessageDelete;
                                  } else {
                                    message = context
                                        .l10n.categoryRequiredMessageNotDelete;
                                  }

                                  SnackBar snackBar =
                                      SnackBar(content: Text(message));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                },
                                icon: const Icon(Icons.delete),
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddCustomer(
                                              preFillCustomer: customers[index],
                                              isEditMode: true,
                                            )),
                                  );
                                },
                                icon: const Icon(Icons.edit),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, _) => Text(
        "Error: $error",
      ),
    );
  }
}
