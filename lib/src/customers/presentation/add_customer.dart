import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_bill/src/customers/models/customer.dart';
import 'package:quick_bill/src/customers/presentation/view_customers_notifier.dart';
import 'package:quick_bill/src/localization/app_localizations_context.dart';
import 'package:uuid/uuid.dart';

class AddCustomer extends ConsumerWidget {
  final bool isEditMode;
  final Customer? preFillCustomer;

  const AddCustomer({
    super.key,
    this.isEditMode = false,
    this.preFillCustomer,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final addCustomerController =
        TextEditingController(text: preFillCustomer?.name ?? '');
    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text(isEditMode
              ? context.l10n.editCustomerTitle
              : context.l10n.addCustomerTitle),
          elevation: 5,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: addCustomerController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return context.l10n.customerNameRequiredMessage;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: context.l10n.customerLabelRequiredMessage,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    if (isEditMode) {
                      final editedCustomer = Customer(
                        guid: preFillCustomer!.guid,
                        name: addCustomerController.text,
                      );
                      Navigator.pop(context);
                      ref.read(customersProvider.notifier).edit(editedCustomer);
                    } else {
                      final newCustomer = Customer(
                        guid: const Uuid().v4(),
                        name: addCustomerController.text,
                      );
                      Navigator.pop(context);
                      ref.read(customersProvider.notifier).add(newCustomer);
                    }
                  }
                },
                child: Text(context.l10n.saveCustomerLabel),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
