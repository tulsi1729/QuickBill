import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_bill/src/customers/models/customer.dart';
import 'package:quick_bill/src/customers/presentation/add_customer.dart';
import 'package:quick_bill/src/customers/presentation/view_customers_notifier.dart';
import 'package:quick_bill/src/entry/presentation/view_entry.dart';
import 'package:quick_bill/src/localization/app_localizations_context.dart';

class ViewCustomers extends ConsumerWidget {
  const ViewCustomers({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Customer> customers = ref.watch(customersProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.viewCustomersTitle),
        elevation: 5,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddCustomer()));
          },
          child: const Icon(Icons.add)),
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
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewEntry(
                                      customerName: customers[index].name)));
                        },
                        title: Text(
                          customers[index].name,
                          style: const TextStyle(fontSize: 30),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            IconButton(
                              onPressed: () => {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) => AlertDialog(
                                      title: const Text(
                                          'Are you sure you want to delete?'),
                                      content: const Text(
                                          'Deleting customer will delete customer-specific information as well'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            bool isDeleteDone = ref
                                                .read(
                                                    customersProvider.notifier)
                                                .delete(customers[index]);
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
                                ),
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
                            // IconButton(
                            //   onPressed: () {
                            //     Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //           builder: (context) => AddEntry(
                            //                 customerName: customers[index].name,
                            //               )),
                            //     );
                            //   },
                            //   icon: const Icon(Icons.add_box_sharp),
                            // ),
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
