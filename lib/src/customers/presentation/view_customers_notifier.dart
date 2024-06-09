import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_bill/src/customers/models/customer.dart';

class ViewCustomersNotifier extends Notifier<List<Customer>> {
  @override
  List<Customer> build() {
    return const <Customer>[
      Customer(guid: "1", name: "Tom"),
      Customer(guid: "2", name: "James"),
      Customer(guid: "3", name: "Jack"),
      Customer(guid: "4", name: "Leo"),
    ];
  }

  void add(Customer newCustomer) {
    state = [...state, newCustomer];
  }

  void edit(Customer editedCustomer) {
    List<Customer> customers = [...state];
    int index = customers
        .indexWhere((customer) => customer.guid == editedCustomer.guid);
    Customer existing = customers
        .firstWhere((customer) => customer.guid == editedCustomer.guid);
    customers.remove(existing);
    customers.insert(index, editedCustomer);
    state = customers;
  }

  bool delete(Customer customer) {
    List<Customer> temp = [...state];
    bool isDeleted = temp.remove(customer);
    state = temp;
    state = [...state];
    return isDeleted;
  }
}

final customersProvider =
    NotifierProvider<ViewCustomersNotifier, List<Customer>>(
        ViewCustomersNotifier.new);
